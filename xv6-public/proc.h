#include "wmap.h"

#define MAX_MMAPS 16
#define MAX_WMAP_INFO 16
#define MAX_PAGES 1024 * 1024       // 1M pages for 4GB memory

//metadata to manage memory maps
struct mmap_region {
    uint addr;       // Starting virtual address
    int length;      // Size of the mapping
    int flags;       // Flags for the mapping (e.g., MAP_SHARED)
    int used;        // Indicates if this region is active, 1 if used
    int fd;          // The file descriptor
    int n_loaded_pages; //Updates whenever this memory region is being allocated in trap.c
};

// Per-CPU state
struct cpu {
  uchar apicid;                // Local APIC ID
  struct context *scheduler;   // swtch() here to enter scheduler
  struct taskstate ts;         // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS];   // x86 global descriptor table
  volatile uint started;       // Has the CPU started?
  int ncli;                    // Depth of pushcli nesting.
  int intena;                  // Were interrupts enabled before pushcli?
  struct proc *proc;           // The process running on this cpu or null
};

extern struct cpu cpus[NCPU];
extern int ncpu;
extern int total_mmaps;
extern int n_loaded_pages;
extern struct proc *initproc; //Added to provide vm.c access to perform COW on non-init processes
extern uchar ref_counts[MAX_PAGES];

// Lock to protect refs array updates
extern struct spinlock refs_lock;

//PAGEBREAK: 17
// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context {
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

enum procstate { UNUSED, EMBRYO, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  uint sz;                     // Size of process memory (bytes)
  pde_t* pgdir;                // Page table
  char *kstack;                // Bottom of kernel stack for this process
  enum procstate state;        // Process state
  int pid;                     // Process ID
  struct proc *parent;         // Parent process
  struct trapframe *tf;        // Trap frame for current syscall
  struct context *context;     // swtch() here to run process
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
  struct mmap_region mmap[MAX_MMAPS]; // Array of memory mappings

  struct wmapinfo wmap;             // Memory map information
  int total_mmaps;                  // Number of memory maps
};

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap
