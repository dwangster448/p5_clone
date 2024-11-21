// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "proc.h"

// // Lock to protect refs array updates
// struct spinlock refs_lock;

void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run
{
  struct run *next;
};

struct
{
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
} kmem;

void init_refs()
{
  initlock(&refs_lock, "refs_lock");
  //acquire(&refs_lock);
  memset(ref_counts, 0, sizeof(ref_counts)); // Set all reference counts to 0
  //release(&refs_lock);
}

int get_ref_count(uint pa)
{
  if (pa >= PHYSTOP)
  {
    panic("get_ref_count");
  }
  return ref_counts[pa / PGSIZE];
}

// Increment the reference count for a physical page.
void incref(uint pa)
{
  //acquire(&refs_lock);
  if (pa >= PHYSTOP) {
  //release(&refs_lock);
    panic("incref: invalid physical address: ");
  }
  ref_counts[pa / PGSIZE]++;
  //release(&refs_lock);
}

// Decrement the reference count for a physical page.
// Free the page if the reference count reaches zero.
void decref(uint pa)
{
  //acquire(&refs_lock);
  if (pa >= PHYSTOP) {
    //release(&refs_lock);
    panic("decref: invalid physical address");
  }

  if (ref_counts[pa / PGSIZE] < 1) {
    //release(&refs_lock);
    panic("decref: reference count underflow");
  }

  ref_counts[pa / PGSIZE]--;

  // Free the page if no more references exist
  if (ref_counts[pa / PGSIZE] == 0)
  {
    
    kfree((char *)P2V(pa)); // Convert to virtual address before freeing
    //release(&refs_lock);
    return;
  }
}

// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}

void kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
}

void freerange(void *vstart, void *vend)
{
  char *p;
  p = (char *)PGROUNDUP((uint)vstart);
  for (; p + PGSIZE <= (char *)vend; p += PGSIZE)
    kfree(p);
}
// PAGEBREAK: 21
//  Free the page of physical memory pointed at by v,
//  which normally should have been returned by a
//  call to kalloc().  (The exception is when
//  initializing the allocator; see kinit above.)
void kfree(char *v)
{
  struct run *r;

  if ((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
  //acquire(&kmem.lock);
  if (get_ref_count(V2P(v)) > 1)
  {
    decref(V2P(v));
    //release(&kmem.lock);
    return;
  }
  //release(&kmem.lock);

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if (kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run *)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if (kmem.use_lock)
    release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char *
kalloc(void)
{
  struct run *r;

  if (kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if (r)
    kmem.freelist = r->next;

  uint pa = V2P((char *)r);
  ref_counts[pa / PGSIZE] = 1; // Initialize ref count

  if (kmem.use_lock)
    release(&kmem.lock);
  return (char *)r;
}
