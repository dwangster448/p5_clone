#include "types.h"
#include "x86.h"
#include "mmu.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "proc.h"
#include "wmap.h"

uint find_free_mmap_space(struct proc *p, int length);
int check_fixed(struct proc p, uint addr, int length);
uint suggestive_address(struct proc *p, uint addr, int length);

int sys_fork(void)
{
  return fork();
}

int sys_exit(void)
{
  exit();
  return 0; // not reached
}

int sys_wait(void)
{
  return wait();
}

int sys_kill(void)
{
  int pid;

  if (argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int sys_getpid(void)
{
  return myproc()->pid;
}

int sys_sbrk(void)
{
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if (growproc(n) < 0)
    return -1;
  return addr;
}

int sys_sleep(void)
{
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n)
  {
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

uint wmap(void)
{
  uint addr;
  int int_addr;
  // use a argint here to retrieve int n argument
  if (argint(0, &int_addr) < 0)
  {
    return FAILED; // Failed fetching value to integer
  }
  addr = (uint)int_addr;

  int length;
  // use a argint here to retrieve int n argument
  if (argint(1, &length) < 0)
  {
    return FAILED; // Failed fetching value to integer
  }

  int flags;
  // use a argint here to retrieve int n argument
  if (argint(2, &flags) < 0)
  {
    return FAILED; // Failed fetching value to integer
  }

  int fd;
  // use a argint here to retrieve int n argument
  if (argint(3, &fd) < 0)
  {
    return FAILED; // Failed fetching value to integer
  }

  // Ensure valid length and alignment
  if (length <= 0 || (addr % PGSIZE != 0))
    return FAILED;

  // Round the length up to the next multiple of PGSIZE
  // if (length % PGSIZE != 0)
  // {
  //   length = PGROUNDUP(length);
  // }

  if (!(flags & MAP_SHARED))
  {
    return FAILED; // MAP_SHARED is mandatory
  }

  if (!(flags & MAP_FIXED))
  {
    return FAILED; // MAP_FIXED is mandatory
  }

  struct proc *p = myproc();

  // Begin condition checking based on if MAP_FIXED is set
  if (flags & MAP_FIXED)
  {
    int result = check_fixed(*p, addr, length);
    if (result == FAILED)
    { // use helper function to check whether fixed address is valid
      return FAILED;
    }
  }
  else if (addr == 0) // addr = 0 means no addr given
  {
    addr = find_free_mmap_space(p, length); // Helper function to find free space
    if (addr == 0)
    {
      return FAILED; // No suitable address found
    }
  }
  else
  { // Handle suggestive use of addr
    addr = suggestive_address(p, addr, length);
    if (addr == 0)
      return FAILED; // Address hint is invalid and no suitable space found
  }

  for (int i = 0; i < MAX_MMAPS; i++)
  {
    if (!p->mmap[i].used) // Found a free memory space in memory map
    {
      p->mmap[i].addr = addr;
      p->mmap[i].length = length;
      // cprintf("length of current mmap addition: %d\n", length);
      p->mmap[i].flags = flags;
      p->mmap[i].fd = fd; // Store the file descriptor for file-backed mapping
      p->mmap[i].used = 1;

      p->total_mmaps++;

      if (!(flags & MAP_ANONYMOUS))
      {                                // perform logic for file-back mapping
        struct file *f = p->ofile[fd]; // Retrieves the file structure of pointer, Dont knpw if this is right syntax to grab it

        // cprintf("file pointer at fd %d, %d\n", fd, &f);
        if (f == 0) // Note that fd might just be a file descriptor between 0-15 since there are only 16 file indexes in the proc
        {
          cprintf("Invalid file descriptor\n");
          // The file descriptor is invalid or closed
          return FAILED; // Error handling: return failure
        }
        p->ofile[fd] = filedup(f); // First duplication and swap at original place of fd file structure retrieval
        /**/
        int dup_used = 0;

        // Now we need to duplicate the file descriptor for kernel usage
        int fd_dup = -1;
        for (int i = 0; i < NOFILE; i++)
        {
          if ((p->ofile[i] == 0) & (dup_used == 0)) // Store duplicated fd file structure at index in proc
          {                                         // Find an empty slot in the process's file descriptor array
            p->ofile[i] = filedup(f);               // Duplicate the file descriptor
            fd_dup = i;                             // Store the duplicated file descriptor index
            dup_used = 1;
          }
        }
        // cprintf("successful fd copy:\n");

        if (fd_dup == -1)
        {
          // No available slot for the file descriptor
          return FAILED; // Error handling: return failure
        }

        p->mmap[i].fd = fd_dup;
      }

      return addr; // return the current add
    }
  }

  return FAILED;
}

uint va2pa(void)
{
  int va;
  // use a argint here to retrieve int n argument
  if (argint(0, &va) < 0)
  {
    return FAILED; // Failed fetching value to integer
  }

  uint pt_index = va & 0xFFFFF000;

  uint offset = va & 0x00000FFF;

  pte_t *pte = walkpgdir(myproc()->pgdir, (void *)pt_index, 0); // TODO check pde_t pte_t type check

  // cprintf("pte:%d\n", &pte);

  if (pte == 0 || !(*pte & PTE_P)) // second condition checks if pte present bit is valid, if invalid means pte is not set and no physical mapping
  {
    return FAILED;
  }
  uint physical_address = *pte + offset;

  return physical_address;
}

int wunmap(void)
{
  uint addr;
  int int_addr;

  // Fetch the address argument
  if (argint(0, &int_addr) < 0)
  {
    return FAILED; // Failed fetching value
  }
  addr = (uint)int_addr;

  // Validate the address range (adjust as needed for your system's mmap range)
  if (addr < 0x60000000 || addr >= 0x80000000)
  {
    return FAILED;
  }

  struct proc *p = myproc();
  struct mmap_region *mmap = 0;

  int found = 0;

  // Find the memory region in p->mmap
  for (int i = 0; i < MAX_MMAPS; i++)
  {
    if (p->mmap[i].used && addr >= p->mmap[i].addr && addr < p->mmap[i].addr + p->mmap[i].length && found == 0)
    {
      mmap = &p->mmap[i];
      found = 1;
    }
  }

  // If no valid mmap region is found, return error
  if (!mmap)
  {
    return FAILED;
  }

  // Deallocate the memory for the mmap region
  for (uint page_start = PGROUNDDOWN(mmap->addr); page_start < mmap->addr + mmap->length; page_start += PGSIZE)
  {
    pte_t *pte = walkpgdir(p->pgdir, (void *)page_start, 0);

    if (pte && (*pte & PTE_P))
    {
      uint physical_address = PTE_ADDR(*pte);
/*
      // If it's file-backed, write any dirty pages back to the file
      if (!(mmap->flags & MAP_ANONYMOUS) && (*pte & PTE_D))
      {
        struct file *f = p->ofile[mmap->fd];
        if (f)
        {
          int file_offset = page_start - mmap->addr;
          f->off = file_offset;                        // Adjust file offset
          filewrite(f, P2V(physical_address), PGSIZE); // Write back data
        }
      }
*/
      // Free the physical memory
      kfree(P2V(physical_address));

      // Clear the page table entry
      *pte = 0;

      // Invalidate the TLB entry
      //invlpg((void *)page_start);
    }
  }

  // Mark the mmap region as unused
  mmap->used = 0;
  mmap->n_loaded_pages = 0;

  // Decrement total mmap count
  p->total_mmaps--;

  return SUCCESS;
}

int getwmapinfo(void)
{
  struct wmapinfo *info;

  if (argptr(0, (char **)&info, sizeof(info)) < 0)
  {
    cprintf("Could not get argptr\n");
    return FAILED;
  }

  struct proc *p = myproc();

  if (p == 0)
  {
    return FAILED;
  }

  for (int i = 0; i < MAX_WMMAP_INFO; i++)
    if (p->mmap[i].used) // If the mmap entry is used
    {
      info->addr[i] = p->mmap[i].addr;                     // Copy the starting address
      info->length[i] = p->mmap[i].length;                 // Copy the length
      info->n_loaded_pages[i] = p->mmap[i].n_loaded_pages; // Number of pages loaded into memory
    }

  info->total_mmaps = p->total_mmaps;
  return SUCCESS;
}

uint find_free_mmap_space(struct proc *p, int length)
{
  uint start_addr = 0x60000000;
  uint end_addr = 0x80000000;

  // Iterate over the valid address range in page-sized increments
  for (uint addr = start_addr; addr + length <= end_addr; addr += PGSIZE)
  {
    int overlap = 0;

    // Check for overlap with existing mappings
    for (int i = 0; i < MAX_MMAPS; i++)
    {
      struct mmap_region *mmap = &p->mmap[i];
      if (mmap->used &&
          !(addr + length <= mmap->addr || addr >= mmap->addr + mmap->length)) // If overlap exists
      {
        overlap = 1;
        break;
      }
    }

    // If no overlap found, return this address
    if (!overlap)
    {
      return addr;
    }
  }

  return 0; // No suitable address found
}

int check_fixed(struct proc p, uint addr, int length)
{
  // addr must be non-zero and aligned
  if (addr == 0 || addr % PGSIZE != 0)
  {
    return FAILED; // Invalid address for MAP_FIXED
  }

  // Ensure addr is within valid bounds
  if (addr < 0x60000000 || addr + length > 0x80000000)
  {
    return FAILED; // Address out of valid range
  }

  // Check for overlap with existing mappings
  for (int i = 0; i < MAX_MMAPS; i++)
  {
    struct mmap_region *mmap = &p.mmap[i];

    if (mmap->used)
    {
      // If the ranges [addr, addr + length) and [mmap->addr, mmap->addr + mmap->length) overlap:
      if (addr < mmap->addr + mmap->length && addr + length > mmap->addr)
      {
        return FAILED; // Overlap detected
      }
    }
  }

  return 1; // No overlap
}

uint suggestive_address(struct proc *p, uint addr, int length)
{
  // Validate addr and check for overlap first
  if (addr % PGSIZE != 0 || addr < 0x60000000 || addr + length > 0x80000000)
  {
    addr = find_free_mmap_space(p, length); // If addr is invalid, dynamically find a space
    if (addr == 0)
      return 0; // No space available

    return addr;
  }

  // Check for overlap with existing mappings
  for (int i = 0; i < MAX_MMAPS; i++)
  {
    struct mmap_region *mmap = &p->mmap[i];
    if (mmap->used &&
        (addr < mmap->addr + mmap->length && addr + length > mmap->addr)) // Overlap detected
    {
      addr = find_free_mmap_space(p, length); // Find free space if overlap detected
      if (addr == 0)
        return 0; // No space available
      break;      // If a new address is found, break out of the loop
    }
  }

  return addr; // Valid or newly allocated address
}