#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "x86.h"
#include "traps.h"
#include "wmap.h"

// int fileread(struct file *f, char *buf, int offset, int n);
//  struct file* get_file_by_fd(int fd);

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[]; // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;
int MAX_OPEN_FILES = 16;

void tvinit(void)
{
  int i;

  for (i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE << 3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE << 3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void idtinit(void)
{
  lidt(idt, sizeof(idt));
}

// PAGEBREAK: 41
void trap(struct trapframe *tf)
{
  if (tf->trapno == T_SYSCALL)
  {
    if (myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if (myproc()->killed)
      exit();
    return;
  }

  switch (tf->trapno)
  {
  case T_IRQ0 + IRQ_TIMER:
    if (cpuid() == 0)
    {
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE + 1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  case T_PGFLT: // T_PGFLT = 14
    uint fault_addr = rcr2();

    struct proc *p = myproc();
    if (p == 0)
    {
      panic("trap: page fault with no process");
    }

    int found = 0;

    for (int i = 0; i < MAX_MMAPS; i++)
    {
      struct mmap_region *mmap = &p->mmap[i]; // TODO What are we supposed to do for n_loaded_pages
      if (mmap->used &&
          fault_addr >= mmap->addr &&
          fault_addr <= mmap->addr + mmap->length)
      {

        found = 1; // We found the valid memory region in memory map

        // Align the fault address to the page boundary
        uint page_start = PGROUNDDOWN(fault_addr);

        // Allocate a physical page
        char *mem = kalloc();
        if (mem == 0)
        {
          cprintf("Lazy allocation failed: out of memory\n");
          p->killed = 1;
          break;
        }

        // Zero out the page and map it into the process's address space
        memset(mem, 0, PGSIZE);

        // Map the physical page to the faulting virtual address
        if (mappages(p->pgdir, (char *)page_start, PGSIZE, V2P(mem), PTE_W | PTE_U) < 0)
        {
          cprintf("Lazy allocation failed: mappages failed\n");
          kfree(mem);
          p->killed = 1;
          break;
        }

        // Map anonymous is not set, proceed to perform file back mapping with fd parameter: mmap->fd
        if (!(mmap->flags & MAP_ANONYMOUS))
        {
          // Use the `fd` directly to access the file
          struct file *f = p->ofile[mmap->fd]; // Get the file pointer

          // Calculate the offset in the file for this page
          int file_offset = page_start - mmap->addr;

          // Adjust the file offset temporarily for reading
          int original_offset = f->off;
          f->off = file_offset;

          // Read data from the file into the allocated memory page
          int bytes_read = fileread(f, mem, PGSIZE);
          f->off = original_offset; // Restore the original offset

          if (bytes_read < 0)
          {
            cprintf("File read failed for mmap region\n");
            kfree(mem);
            p->killed = 1;
            break;
          }

          // Zero out the rest of the page if fewer than PGSIZE bytes were read
          if (bytes_read < PGSIZE)
          {
            memset(mem + bytes_read, 0, PGSIZE - bytes_read);
          }
        }
        else
        {
          // Don't need to consider fd. It's NOT File-backed mapping
        }

        break; // Stop searching once a match is handled
      }
    }

    // If no valid mapping was found for the faulting address
    if (!found)
    {
      cprintf("Segmentation Fault: Fault address 0x%x\n", fault_addr);
      p->killed = 1; // Mark the process for termination
      break;
      // goto pagefault_default;
    } // kill the process

  // pagefault_default:
  //  PAGEBREAK: 13
  default:
    if (myproc() == 0 || (tf->cs & 3) == 0)
    {
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if (myproc() && myproc()->state == RUNNING &&
      tf->trapno == T_IRQ0 + IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if (myproc() && myproc()->killed && (tf->cs & 3) == DPL_USER)
    exit();
}

// int fileread(struct file *f, char *buf, int offset, int n)
// {
//   if (f->type != FD_INODE)
//   {
//     return -1; // Only support files of type FD_INODE
//   }

//   struct inode *ip = f->ip;
//   ilock(ip);

//   int bytes_read = readi(ip, buf, offset, n); // Read `n` bytes from `offset`
//   iunlock(ip);

//   return bytes_read;
// }

// struct file* get_file_by_fd(int fd) {
//     struct proc *p = myproc(); // Get the current process (you likely have a function like myproc() that returns the current process)

//     if (p == 0 || fd < 0 || fd >= MAX_OPEN_FILES) {
//         return FAILED; // Invalid process or file descriptor out of range
//     }

//     struct file *f = p->ofile[fd];  // p->ofile is the file descriptor table
//     if (f == 0) {
//         return FAILED; // File descriptor is not in use
//     }

//     return f;  // Return the file structure
// }