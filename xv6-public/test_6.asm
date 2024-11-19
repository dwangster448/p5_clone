
_test_6:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// Summary: MAP+ALLOC: Access fixed anonymous map (checks for memory allocation)
// ====================================================================

char *test_name = "TEST_6";

int main() {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	81 ec e0 00 00 00    	sub    $0xe0,%esp
    printf(1, "\n\n%s\n", test_name);
  16:	ff 35 40 19 00 00    	push   0x1940
  1c:	68 f7 13 00 00       	push   $0x13f7
  21:	6a 01                	push   $0x1
  23:	e8 78 0b 00 00       	call   ba0 <printf>
    validate_initial_state();
  28:	e8 73 04 00 00       	call   4a0 <validate_initial_state>

    // place map 1 (fixed and anonymous)
    int anon = MAP_FIXED | MAP_ANONYMOUS | MAP_SHARED;
    uint addr = MMAPBASE + PGSIZE * 2;
    int length = 2 * PGSIZE + 100;
    uint map = wmap(addr, length, anon, 0);
  2d:	6a 00                	push   $0x0
  2f:	6a 0e                	push   $0xe
  31:	68 64 20 00 00       	push   $0x2064
  36:	68 00 20 00 60       	push   $0x60002000
  3b:	e8 83 0a 00 00       	call   ac3 <wmap>
    if (map != addr) {
  40:	83 c4 20             	add    $0x20,%esp
    uint map = wmap(addr, length, anon, 0);
  43:	89 c3                	mov    %eax,%ebx
    if (map != addr) {
  45:	3d 00 20 00 60       	cmp    $0x60002000,%eax
  4a:	74 13                	je     5f <main+0x5f>
        printerr("wmap() returned %d\n", (int)map);
  4c:	50                   	push   %eax
  4d:	53                   	push   %ebx
  4e:	68 2c 13 00 00       	push   $0x132c
  53:	6a 01                	push   $0x1
  55:	e8 46 0b 00 00       	call   ba0 <printf>
        failed();
  5a:	e8 21 01 00 00       	call   180 <failed>
    }
    // validate map 1
    struct wmapinfo winfo;
    get_n_validate_wmap_info(&winfo, 1); // 1 map exists
  5f:	56                   	push   %esi
  60:	56                   	push   %esi
  61:	8d b5 24 ff ff ff    	lea    -0xdc(%ebp),%esi
  67:	6a 01                	push   $0x1
  69:	56                   	push   %esi
  6a:	e8 81 01 00 00       	call   1f0 <get_n_validate_wmap_info>
    map_exists(&winfo, addr, length, TRUE);
  6f:	6a 01                	push   $0x1
  71:	68 64 20 00 00       	push   $0x2064
  76:	68 00 20 00 60       	push   $0x60002000
  7b:	56                   	push   %esi
  7c:	e8 ef 01 00 00       	call   270 <map_exists>
  81:	83 c4 10             	add    $0x10,%esp
    printf(1, "INFO: Map 1 at 0x%x with length %d. \tOkay.\n", map, length);
  84:	68 64 20 00 00       	push   $0x2064
  89:	68 00 20 00 60       	push   $0x60002000
  8e:	68 54 13 00 00       	push   $0x1354
  93:	6a 01                	push   $0x1
  95:	e8 06 0b 00 00       	call   ba0 <printf>
  9a:	83 c4 20             	add    $0x20,%esp
  9d:	8d 76 00             	lea    0x0(%esi),%esi

    // access all pages of map 1
    char *arr = (char *)map;
    char val = 'p';
    for (int i = 0; i < length; i++) {
        arr[i] = val;
  a0:	c6 03 70             	movb   $0x70,(%ebx)
    for (int i = 0; i < length; i++) {
  a3:	83 c3 01             	add    $0x1,%ebx
  a6:	81 fb 64 40 00 60    	cmp    $0x60004064,%ebx
  ac:	75 f2                	jne    a0 <main+0xa0>
    }
    // validate all pages of map 1
    for (int i = 0; i < length; i++) {
  ae:	31 c0                	xor    %eax,%eax
  b0:	eb 10                	jmp    c2 <main+0xc2>
  b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  b8:	83 c0 01             	add    $0x1,%eax
  bb:	3d 64 20 00 00       	cmp    $0x2064,%eax
  c0:	74 2d                	je     ef <main+0xef>
        if (arr[i] != val) {
  c2:	0f be 90 00 20 00 60 	movsbl 0x60002000(%eax),%edx
  c9:	8d 88 00 20 00 60    	lea    0x60002000(%eax),%ecx
  cf:	80 fa 70             	cmp    $0x70,%dl
  d2:	74 e4                	je     b8 <main+0xb8>
            printerr("addr 0x%x contains %d, expected %d\n", addr + i, arr[i], val);
  d4:	83 ec 0c             	sub    $0xc,%esp
  d7:	6a 70                	push   $0x70
  d9:	52                   	push   %edx
  da:	51                   	push   %ecx
  db:	68 80 13 00 00       	push   $0x1380
  e0:	6a 01                	push   $0x1
  e2:	e8 b9 0a 00 00       	call   ba0 <printf>
            failed();
  e7:	83 c4 20             	add    $0x20,%esp
  ea:	e8 91 00 00 00       	call   180 <failed>
        }
    }
    // validate map 1 after accessing all pages
    get_n_validate_wmap_info(&winfo, 1); // 1 map exists
  ef:	50                   	push   %eax
  f0:	50                   	push   %eax
  f1:	6a 01                	push   $0x1
  f3:	56                   	push   %esi
  f4:	e8 f7 00 00 00       	call   1f0 <get_n_validate_wmap_info>
    int n_pages = PGROUNDUP(length) / PGSIZE;
    map_allocated(&winfo, addr, length, n_pages); // 3 pages loaded
  f9:	6a 03                	push   $0x3
  fb:	68 64 20 00 00       	push   $0x2064
 100:	68 00 20 00 60       	push   $0x60002000
 105:	56                   	push   %esi
 106:	e8 45 02 00 00       	call   350 <map_allocated>
    for (int i = 0; i < length; i += PGSIZE) {
        uint va = map + i;
        va_exists(va, TRUE); // each virtual address exists in pgdir
 10b:	83 c4 18             	add    $0x18,%esp
 10e:	6a 01                	push   $0x1
 110:	68 00 20 00 60       	push   $0x60002000
 115:	e8 a6 02 00 00       	call   3c0 <va_exists>
 11a:	5a                   	pop    %edx
 11b:	59                   	pop    %ecx
 11c:	6a 01                	push   $0x1
 11e:	68 00 30 00 60       	push   $0x60003000
 123:	e8 98 02 00 00       	call   3c0 <va_exists>
 128:	5b                   	pop    %ebx
 129:	5e                   	pop    %esi
 12a:	6a 01                	push   $0x1
 12c:	68 00 40 00 60       	push   $0x60004000
 131:	e8 8a 02 00 00       	call   3c0 <va_exists>
    }
    va_exists(addr + n_pages * PGSIZE, FALSE); // va after the map does not exist
 136:	58                   	pop    %eax
 137:	5a                   	pop    %edx
 138:	6a 00                	push   $0x0
 13a:	68 00 50 00 60       	push   $0x60005000
 13f:	e8 7c 02 00 00       	call   3c0 <va_exists>
    printf(1, "INFO: Accessed all pages of Map 1. \tOkay.\n");
 144:	59                   	pop    %ecx
 145:	5b                   	pop    %ebx
 146:	68 b8 13 00 00       	push   $0x13b8
 14b:	6a 01                	push   $0x1
 14d:	e8 4e 0a 00 00       	call   ba0 <printf>

    // test ends
    success();
 152:	e8 09 00 00 00       	call   160 <success>
 157:	66 90                	xchg   %ax,%ax
 159:	66 90                	xchg   %ax,%ax
 15b:	66 90                	xchg   %ax,%ax
 15d:	66 90                	xchg   %ax,%ax
 15f:	90                   	nop

00000160 <success>:
           "\033[0m" fmt,                                                           \
           ##__VA_ARGS__)

extern char *test_name;

void success() {
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "\033[0;32mSUCCESS:\033[0m %s\t PASSED\n\n", test_name);
 166:	ff 35 40 19 00 00    	push   0x1940
 16c:	68 c8 0e 00 00       	push   $0xec8
 171:	6a 01                	push   $0x1
 173:	e8 28 0a 00 00       	call   ba0 <printf>
    exit();
 178:	e8 a6 08 00 00       	call   a23 <exit>
 17d:	8d 76 00             	lea    0x0(%esi),%esi

00000180 <failed>:
}

void failed() {
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	83 ec 08             	sub    $0x8,%esp
    printf(1, "\n\033[0;31mFAIL:\033[0m %s\t FAILED (pid %d)\n\n", test_name,
 186:	e8 18 09 00 00       	call   aa3 <getpid>
 18b:	50                   	push   %eax
 18c:	ff 35 40 19 00 00    	push   0x1940
 192:	68 ec 0e 00 00       	push   $0xeec
 197:	6a 01                	push   $0x1
 199:	e8 02 0a 00 00       	call   ba0 <printf>
           getpid());
    exit();
 19e:	e8 80 08 00 00       	call   a23 <exit>
 1a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <reset_wmapinfo>:
}

void reset_wmapinfo(struct wmapinfo *info) {
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
    info->total_mmaps = -1;
 1b6:	c7 02 ff ff ff ff    	movl   $0xffffffff,(%edx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 1bc:	8d 42 04             	lea    0x4(%edx),%eax
 1bf:	83 c2 44             	add    $0x44,%edx
 1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        info->addr[i] = -1;
 1c8:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 1ce:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
 1d1:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
 1d8:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 1df:	39 d0                	cmp    %edx,%eax
 1e1:	75 e5                	jne    1c8 <reset_wmapinfo+0x18>
    }
}
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <get_n_validate_wmap_info>:

/**
 * Get the wmapinfo and validate the total number of maps
 */
void get_n_validate_wmap_info(struct wmapinfo *info, int expected_total_mmaps) {
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	53                   	push   %ebx
 1f4:	83 ec 04             	sub    $0x4,%esp
 1f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    info->total_mmaps = -1;
 1fa:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 200:	8d 43 04             	lea    0x4(%ebx),%eax
 203:	8d 53 44             	lea    0x44(%ebx),%edx
 206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi
        info->addr[i] = -1;
 210:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 216:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
 219:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
 220:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 227:	39 d0                	cmp    %edx,%eax
 229:	75 e5                	jne    210 <get_n_validate_wmap_info+0x20>
    reset_wmapinfo(info);
    int ret = getwmapinfo(info);
 22b:	83 ec 0c             	sub    $0xc,%esp
 22e:	53                   	push   %ebx
 22f:	e8 a7 08 00 00       	call   adb <getwmapinfo>
    if (ret != SUCCESS) {
 234:	83 c4 10             	add    $0x10,%esp
 237:	85 c0                	test   %eax,%eax
 239:	75 0c                	jne    247 <get_n_validate_wmap_info+0x57>
        printerr("getwmapinfo() returned %d\n", ret);
        failed();
    }
    if (info->total_mmaps != expected_total_mmaps) {
 23b:	8b 03                	mov    (%ebx),%eax
 23d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 240:	75 18                	jne    25a <get_n_validate_wmap_info+0x6a>

        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
                 expected_total_mmaps);
        failed();
    }
}
 242:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 245:	c9                   	leave  
 246:	c3                   	ret    
        printerr("getwmapinfo() returned %d\n", ret);
 247:	52                   	push   %edx
 248:	50                   	push   %eax
 249:	68 14 0f 00 00       	push   $0xf14
 24e:	6a 01                	push   $0x1
 250:	e8 4b 09 00 00       	call   ba0 <printf>
        failed();
 255:	e8 26 ff ff ff       	call   180 <failed>
        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
 25a:	ff 75 0c             	push   0xc(%ebp)
 25d:	50                   	push   %eax
 25e:	68 44 0f 00 00       	push   $0xf44
 263:	6a 01                	push   $0x1
 265:	e8 36 09 00 00       	call   ba0 <printf>
        failed();
 26a:	e8 11 ff ff ff       	call   180 <failed>
 26f:	90                   	nop

00000270 <map_exists>:

/**
 * Check if a map with the given address and length exists in the list of maps
 */
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 270:	55                   	push   %ebp
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
 271:	31 c0                	xor    %eax,%eax
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 273:	89 e5                	mov    %esp,%ebp
 275:	56                   	push   %esi
 276:	8b 55 08             	mov    0x8(%ebp),%edx
 279:	8b 75 10             	mov    0x10(%ebp),%esi
 27c:	53                   	push   %ebx
 27d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    for (int i = 0; i < info->total_mmaps; i++) {
 280:	8b 0a                	mov    (%edx),%ecx
 282:	85 c9                	test   %ecx,%ecx
 284:	7f 11                	jg     297 <map_exists+0x27>
 286:	eb 20                	jmp    2a8 <map_exists+0x38>
 288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28f:	90                   	nop
 290:	83 c0 01             	add    $0x1,%eax
 293:	39 c8                	cmp    %ecx,%eax
 295:	74 21                	je     2b8 <map_exists+0x48>
        if (info->addr[i] == addr && info->length[i] == length) {
 297:	39 5c 82 04          	cmp    %ebx,0x4(%edx,%eax,4)
 29b:	75 f3                	jne    290 <map_exists+0x20>
 29d:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
 2a1:	75 ed                	jne    290 <map_exists+0x20>
            found = 1;
 2a3:	b8 01 00 00 00       	mov    $0x1,%eax
            break;
        }
    }
    if (found != expected) {
 2a8:	3b 45 14             	cmp    0x14(%ebp),%eax
 2ab:	75 0f                	jne    2bc <map_exists+0x4c>
            1,
            "ERROR: expected mmap 0x%x with length 0x%x to %s in the list of maps\n",
            addr, length, expected ? "exist" : "NOT exist");
        failed();
    }
}
 2ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b0:	5b                   	pop    %ebx
 2b1:	5e                   	pop    %esi
 2b2:	5d                   	pop    %ebp
 2b3:	c3                   	ret    
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int found = 0;
 2b8:	31 c0                	xor    %eax,%eax
 2ba:	eb ec                	jmp    2a8 <map_exists+0x38>
        printf(
 2bc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 2c0:	ba e3 13 00 00       	mov    $0x13e3,%edx
 2c5:	b8 e7 13 00 00       	mov    $0x13e7,%eax
 2ca:	0f 44 c2             	cmove  %edx,%eax
 2cd:	83 ec 0c             	sub    $0xc,%esp
 2d0:	50                   	push   %eax
 2d1:	56                   	push   %esi
 2d2:	53                   	push   %ebx
 2d3:	68 78 0f 00 00       	push   $0xf78
 2d8:	6a 01                	push   $0x1
 2da:	e8 c1 08 00 00       	call   ba0 <printf>
        failed();
 2df:	83 c4 20             	add    $0x20,%esp
 2e2:	e8 99 fe ff ff       	call   180 <failed>
 2e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ee:	66 90                	xchg   %ax,%ax

000002f0 <get_n_validate_va2pa>:

uint get_n_validate_va2pa(uint va) {
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	53                   	push   %ebx
 2f4:	83 ec 10             	sub    $0x10,%esp
 2f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
 2fa:	53                   	push   %ebx
 2fb:	e8 cb 07 00 00       	call   acb <va2pa>
    if (ret == FAILED) {
 300:	83 c4 10             	add    $0x10,%esp
 303:	83 f8 ff             	cmp    $0xffffffff,%eax
 306:	74 13                	je     31b <get_n_validate_va2pa+0x2b>
        printerr("va2pa(0x%x)` failed\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
 308:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
 30e:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
 314:	77 18                	ja     32e <get_n_validate_va2pa+0x3e>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
    return pa;
}
 316:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 319:	c9                   	leave  
 31a:	c3                   	ret    
        printerr("va2pa(0x%x)` failed\n", va);
 31b:	51                   	push   %ecx
 31c:	53                   	push   %ebx
 31d:	68 c0 0f 00 00       	push   $0xfc0
 322:	6a 01                	push   $0x1
 324:	e8 77 08 00 00       	call   ba0 <printf>
        failed();
 329:	e8 52 fe ff ff       	call   180 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
 32e:	52                   	push   %edx
 32f:	52                   	push   %edx
 330:	68 00 00 00 0e       	push   $0xe000000
 335:	68 00 00 10 00       	push   $0x100000
 33a:	50                   	push   %eax
 33b:	53                   	push   %ebx
 33c:	68 e8 0f 00 00       	push   $0xfe8
 341:	6a 01                	push   $0x1
 343:	e8 58 08 00 00       	call   ba0 <printf>
        failed();
 348:	83 c4 20             	add    $0x20,%esp
 34b:	e8 30 fe ff ff       	call   180 <failed>

00000350 <map_allocated>:

void map_allocated(struct wmapinfo *info, uint addr, int length,
                   int n_loaded_pages) {
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	8b 55 08             	mov    0x8(%ebp),%edx
 357:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 35a:	53                   	push   %ebx
 35b:	8b 75 10             	mov    0x10(%ebp),%esi
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
 35e:	8b 1a                	mov    (%edx),%ebx
 360:	85 db                	test   %ebx,%ebx
 362:	7e 32                	jle    396 <map_allocated+0x46>
 364:	31 c0                	xor    %eax,%eax
 366:	eb 0f                	jmp    377 <map_allocated+0x27>
 368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36f:	90                   	nop
 370:	83 c0 01             	add    $0x1,%eax
 373:	39 d8                	cmp    %ebx,%eax
 375:	74 1f                	je     396 <map_allocated+0x46>
        if (info->addr[i] == addr && info->length[i] == length) {
 377:	39 4c 82 04          	cmp    %ecx,0x4(%edx,%eax,4)
 37b:	75 f3                	jne    370 <map_allocated+0x20>
 37d:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
 381:	75 ed                	jne    370 <map_allocated+0x20>
            found = 1;
            if (info->n_loaded_pages[i] != n_loaded_pages) {
 383:	8b 84 82 84 00 00 00 	mov    0x84(%edx,%eax,4),%eax
 38a:	3b 45 14             	cmp    0x14(%ebp),%eax
 38d:	75 1a                	jne    3a9 <map_allocated+0x59>
        printf(1,
               "Cause: expected 0x%x with length %d to exist in the list of maps\n",
               addr, length);
        failed();
    }
}
 38f:	8d 65 f8             	lea    -0x8(%ebp),%esp
 392:	5b                   	pop    %ebx
 393:	5e                   	pop    %esi
 394:	5d                   	pop    %ebp
 395:	c3                   	ret    
        printf(1,
 396:	56                   	push   %esi
 397:	51                   	push   %ecx
 398:	68 6c 10 00 00       	push   $0x106c
 39d:	6a 01                	push   $0x1
 39f:	e8 fc 07 00 00       	call   ba0 <printf>
        failed();
 3a4:	e8 d7 fd ff ff       	call   180 <failed>
                printf(1, "Cause: expected %d pages to be loaded, but found %d\n",
 3a9:	50                   	push   %eax
 3aa:	ff 75 14             	push   0x14(%ebp)
 3ad:	68 34 10 00 00       	push   $0x1034
 3b2:	6a 01                	push   $0x1
 3b4:	e8 e7 07 00 00       	call   ba0 <printf>
                failed();
 3b9:	e8 c2 fd ff ff       	call   180 <failed>
 3be:	66 90                	xchg   %ax,%ax

000003c0 <va_exists>:

void va_exists(uint va, int expected) {
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	53                   	push   %ebx
 3c4:	83 ec 10             	sub    $0x10,%esp
 3c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
 3ca:	53                   	push   %ebx
 3cb:	e8 fb 06 00 00       	call   acb <va2pa>
    if (ret == FAILED) { // va is not allocated
 3d0:	83 c4 10             	add    $0x10,%esp
 3d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 3d6:	74 20                	je     3f8 <va_exists+0x38>
            failed();
        }
        return;
    }
    // va is allocated
    if (!expected) {
 3d8:	8b 55 0c             	mov    0xc(%ebp),%edx
 3db:	85 d2                	test   %edx,%edx
 3dd:	74 55                	je     434 <va_exists+0x74>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
 3df:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
 3e5:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
 3eb:	77 25                	ja     412 <va_exists+0x52>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
}
 3ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f0:	c9                   	leave  
 3f1:	c3                   	ret    
 3f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (expected) {
 3f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fb:	85 c0                	test   %eax,%eax
 3fd:	74 ee                	je     3ed <va_exists+0x2d>
            printerr("expected va 0x%x to be allocated\n", va);
 3ff:	51                   	push   %ecx
 400:	53                   	push   %ebx
 401:	68 b0 10 00 00       	push   $0x10b0
 406:	6a 01                	push   $0x1
 408:	e8 93 07 00 00       	call   ba0 <printf>
            failed();
 40d:	e8 6e fd ff ff       	call   180 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
 412:	52                   	push   %edx
 413:	52                   	push   %edx
 414:	68 00 00 00 0e       	push   $0xe000000
 419:	68 00 00 10 00       	push   $0x100000
 41e:	50                   	push   %eax
 41f:	53                   	push   %ebx
 420:	68 e8 0f 00 00       	push   $0xfe8
 425:	6a 01                	push   $0x1
 427:	e8 74 07 00 00       	call   ba0 <printf>
        failed();
 42c:	83 c4 20             	add    $0x20,%esp
 42f:	e8 4c fd ff ff       	call   180 <failed>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
 434:	51                   	push   %ecx
 435:	53                   	push   %ebx
 436:	68 e4 10 00 00       	push   $0x10e4
 43b:	6a 01                	push   $0x1
 43d:	e8 5e 07 00 00       	call   ba0 <printf>
        failed();
 442:	e8 39 fd ff ff       	call   180 <failed>
 447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44e:	66 90                	xchg   %ax,%ax

00000450 <no_mmaps_in_pgdir>:

void no_mmaps_in_pgdir() {
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
 454:	bb 00 00 00 60       	mov    $0x60000000,%ebx
void no_mmaps_in_pgdir() {
 459:	83 ec 04             	sub    $0x4,%esp
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int pa = va2pa(va);
 460:	83 ec 0c             	sub    $0xc,%esp
 463:	53                   	push   %ebx
 464:	e8 62 06 00 00       	call   acb <va2pa>
        if (pa != FAILED) {
 469:	83 c4 10             	add    $0x10,%esp
 46c:	83 f8 ff             	cmp    $0xffffffff,%eax
 46f:	75 0d                	jne    47e <no_mmaps_in_pgdir+0x2e>
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
 471:	81 c3 00 10 00 00    	add    $0x1000,%ebx
 477:	79 e7                	jns    460 <no_mmaps_in_pgdir+0x10>
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
            failed();
        }
    }
}
 479:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 47c:	c9                   	leave  
 47d:	c3                   	ret    
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
 47e:	50                   	push   %eax
 47f:	53                   	push   %ebx
 480:	68 28 11 00 00       	push   $0x1128
 485:	6a 01                	push   $0x1
 487:	e8 14 07 00 00       	call   ba0 <printf>
            failed();
 48c:	e8 ef fc ff ff       	call   180 <failed>
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop

000004a0 <validate_initial_state>:

void validate_initial_state() {
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	81 ec e0 00 00 00    	sub    $0xe0,%esp
    struct wmapinfo winfo;
    get_n_validate_wmap_info(&winfo, 0); // no maps exist
 4a9:	8d 85 34 ff ff ff    	lea    -0xcc(%ebp),%eax
 4af:	6a 00                	push   $0x0
 4b1:	50                   	push   %eax
 4b2:	e8 39 fd ff ff       	call   1f0 <get_n_validate_wmap_info>
    // no_mmaps_in_pgdir();                 // no maps in the mmap range in pgdir
    printf(1, "INFO: Initially 0 maps. \tOkay.\n");
 4b7:	58                   	pop    %eax
 4b8:	5a                   	pop    %edx
 4b9:	68 68 11 00 00       	push   $0x1168
 4be:	6a 01                	push   $0x1
 4c0:	e8 db 06 00 00       	call   ba0 <printf>
}
 4c5:	83 c4 10             	add    $0x10,%esp
 4c8:	c9                   	leave  
 4c9:	c3                   	ret    
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004d0 <check_overlaps>:

void check_overlaps(uint *maps, uint *lengths, int n) {
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 1c             	sub    $0x1c,%esp
 4d9:	8b 7d 10             	mov    0x10(%ebp),%edi
    for (int i = 0; i < n; i++) {
 4dc:	85 ff                	test   %edi,%edi
 4de:	7e 55                	jle    535 <check_overlaps+0x65>
 4e0:	8b 75 08             	mov    0x8(%ebp),%esi
 4e3:	31 db                	xor    %ebx,%ebx
 4e5:	8d 76 00             	lea    0x0(%esi),%esi
        for (int j = 0; j < n; j++) {
 4e8:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 4eb:	31 c0                	xor    %eax,%eax
 4ed:	89 7d 10             	mov    %edi,0x10(%ebp)
 4f0:	eb 08                	jmp    4fa <check_overlaps+0x2a>
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4f8:	89 d0                	mov    %edx,%eax
            if (i == j)
 4fa:	39 d8                	cmp    %ebx,%eax
 4fc:	74 1b                	je     519 <check_overlaps+0x49>
                continue;
            if (maps[i] >= maps[j] && maps[i] < maps[j] + lengths[j]) {
 4fe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 501:	8b 4d 08             	mov    0x8(%ebp),%ecx
 504:	8b 17                	mov    (%edi),%edx
 506:	8b 0c 81             	mov    (%ecx,%eax,4),%ecx
 509:	39 ca                	cmp    %ecx,%edx
 50b:	72 0c                	jb     519 <check_overlaps+0x49>
 50d:	8b 7d 0c             	mov    0xc(%ebp),%edi
 510:	8b 34 87             	mov    (%edi,%eax,4),%esi
 513:	01 ce                	add    %ecx,%esi
 515:	39 f2                	cmp    %esi,%edx
 517:	72 24                	jb     53d <check_overlaps+0x6d>
        for (int j = 0; j < n; j++) {
 519:	8d 50 01             	lea    0x1(%eax),%edx
 51c:	39 55 10             	cmp    %edx,0x10(%ebp)
 51f:	75 d7                	jne    4f8 <check_overlaps+0x28>
    for (int i = 0; i < n; i++) {
 521:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 524:	8b 7d 10             	mov    0x10(%ebp),%edi
 527:	8d 53 01             	lea    0x1(%ebx),%edx
 52a:	83 c6 04             	add    $0x4,%esi
 52d:	39 d8                	cmp    %ebx,%eax
 52f:	74 04                	je     535 <check_overlaps+0x65>
 531:	89 d3                	mov    %edx,%ebx
 533:	eb b3                	jmp    4e8 <check_overlaps+0x18>
                         maps[j]);
                failed();
            }
        }
    }
}
 535:	8d 65 f4             	lea    -0xc(%ebp),%esp
 538:	5b                   	pop    %ebx
 539:	5e                   	pop    %esi
 53a:	5f                   	pop    %edi
 53b:	5d                   	pop    %ebp
 53c:	c3                   	ret    
                printerr("Map (addr 0x%x) overlaps with Map (addr 0x%x)\n", maps[i],
 53d:	51                   	push   %ecx
 53e:	52                   	push   %edx
 53f:	68 88 11 00 00       	push   $0x1188
 544:	6a 01                	push   $0x1
 546:	e8 55 06 00 00       	call   ba0 <printf>
                failed();
 54b:	e8 30 fc ff ff       	call   180 <failed>

00000550 <create_small_file>:

/**
 * Create a small file with 512 bytes of content
 */
int create_small_file(char *filename, char c) {
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	57                   	push   %edi
 554:	56                   	push   %esi
 555:	53                   	push   %ebx
 556:	83 ec 0c             	sub    $0xc,%esp
 559:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
    // create a file
    int bufflen = 512;
    char buff[bufflen];
 55d:	89 e0                	mov    %esp,%eax
 55f:	39 c4                	cmp    %eax,%esp
 561:	74 12                	je     575 <create_small_file+0x25>
 563:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 569:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 570:	00 
 571:	39 c4                	cmp    %eax,%esp
 573:	75 ee                	jne    563 <create_small_file+0x13>
 575:	81 ec 00 02 00 00    	sub    $0x200,%esp
 57b:	83 8c 24 fc 01 00 00 	orl    $0x0,0x1fc(%esp)
 582:	00 
 583:	89 e7                	mov    %esp,%edi
    int fd = open(filename, O_CREATE | O_RDWR);
 585:	83 ec 08             	sub    $0x8,%esp
 588:	68 02 02 00 00       	push   $0x202
 58d:	ff 75 08             	push   0x8(%ebp)
 590:	e8 ce 04 00 00       	call   a63 <open>
    if (fd < 0) {
 595:	89 fc                	mov    %edi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
 597:	89 c6                	mov    %eax,%esi
    if (fd < 0) {
 599:	85 c0                	test   %eax,%eax
 59b:	78 57                	js     5f4 <create_small_file+0xa4>
 59d:	89 f8                	mov    %edi,%eax
 59f:	8d 8f 00 02 00 00    	lea    0x200(%edi),%ecx
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
        printerr("Failed to create file %s\n", filename);
        failed();
    }
    // prepare the content to write
    for (int j = 0; j < bufflen; j++) {
        buff[j] = c;
 5a8:	88 18                	mov    %bl,(%eax)
    for (int j = 0; j < bufflen; j++) {
 5aa:	83 c0 01             	add    $0x1,%eax
 5ad:	39 c8                	cmp    %ecx,%eax
 5af:	75 f7                	jne    5a8 <create_small_file+0x58>
    }
    // write to file
    if (write(fd, buff, bufflen) != bufflen) {
 5b1:	83 ec 04             	sub    $0x4,%esp
 5b4:	68 00 02 00 00       	push   $0x200
 5b9:	57                   	push   %edi
 5ba:	56                   	push   %esi
 5bb:	e8 83 04 00 00       	call   a43 <write>
 5c0:	83 c4 10             	add    $0x10,%esp
 5c3:	3d 00 02 00 00       	cmp    $0x200,%eax
 5c8:	75 3f                	jne    609 <create_small_file+0xb9>
        printerr("Write to file FAILED\n");
        failed();
    }
    close(fd);
 5ca:	83 ec 0c             	sub    $0xc,%esp
 5cd:	56                   	push   %esi
 5ce:	e8 78 04 00 00       	call   a4b <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
 5d3:	68 00 02 00 00       	push   $0x200
 5d8:	ff 75 08             	push   0x8(%ebp)
 5db:	68 20 12 00 00       	push   $0x1220
 5e0:	6a 01                	push   $0x1
 5e2:	e8 b9 05 00 00       	call   ba0 <printf>
           bufflen);
    return bufflen;
}
 5e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ea:	b8 00 02 00 00       	mov    $0x200,%eax
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
        printerr("Failed to create file %s\n", filename);
 5f4:	52                   	push   %edx
 5f5:	ff 75 08             	push   0x8(%ebp)
 5f8:	68 cc 11 00 00       	push   $0x11cc
 5fd:	6a 01                	push   $0x1
 5ff:	e8 9c 05 00 00       	call   ba0 <printf>
        failed();
 604:	e8 77 fb ff ff       	call   180 <failed>
        printerr("Write to file FAILED\n");
 609:	50                   	push   %eax
 60a:	50                   	push   %eax
 60b:	68 f8 11 00 00       	push   $0x11f8
 610:	6a 01                	push   $0x1
 612:	e8 89 05 00 00       	call   ba0 <printf>
        failed();
 617:	e8 64 fb ff ff       	call   180 <failed>
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000620 <create_big_file>:

int create_big_file(char *filename, int N_PAGES, char c) {
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 1c             	sub    $0x1c,%esp
 629:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
 62d:	88 45 df             	mov    %al,-0x21(%ebp)
    // create a file
    int bufflen = 1024;
    char buff[bufflen];
 630:	89 e0                	mov    %esp,%eax
 632:	39 c4                	cmp    %eax,%esp
 634:	74 12                	je     648 <create_big_file+0x28>
 636:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 63c:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 643:	00 
 644:	39 c4                	cmp    %eax,%esp
 646:	75 ee                	jne    636 <create_big_file+0x16>
 648:	81 ec 00 04 00 00    	sub    $0x400,%esp
 64e:	83 8c 24 fc 03 00 00 	orl    $0x0,0x3fc(%esp)
 655:	00 
 656:	89 e6                	mov    %esp,%esi
    int fd = open(filename, O_CREATE | O_RDWR);
 658:	83 ec 08             	sub    $0x8,%esp
 65b:	68 02 02 00 00       	push   $0x202
 660:	ff 75 08             	push   0x8(%ebp)
 663:	e8 fb 03 00 00       	call   a63 <open>
    if (fd < 0) {
 668:	89 f4                	mov    %esi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
 66a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if (fd < 0) {
 66d:	85 c0                	test   %eax,%eax
 66f:	0f 88 a0 00 00 00    	js     715 <create_big_file+0xf5>
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
        failed();
    }
    // write in steps as we cannot have a buffer larger than PGSIZE
    for (int pg = 0; pg < N_PAGES; pg++) {
 675:	8b 55 0c             	mov    0xc(%ebp),%edx
 678:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 67f:	8d be 00 04 00 00    	lea    0x400(%esi),%edi
 685:	85 d2                	test   %edx,%edx
 687:	7e 61                	jle    6ea <create_big_file+0xca>
 689:	0f b6 5d df          	movzbl -0x21(%ebp),%ebx
 68d:	02 5d e4             	add    -0x1c(%ebp),%bl
        printf(1, "INFO: %d\n", c);
 690:	83 ec 04             	sub    $0x4,%esp
 693:	0f be c3             	movsbl %bl,%eax
 696:	50                   	push   %eax
 697:	68 ed 13 00 00       	push   $0x13ed
 69c:	6a 01                	push   $0x1
 69e:	e8 fd 04 00 00       	call   ba0 <printf>
        int nchunks = PGSIZE / bufflen;
        for (int i = 0; i < bufflen; i++)
 6a3:	89 f0                	mov    %esi,%eax
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
            buff[i] = c;
 6b0:	88 18                	mov    %bl,(%eax)
        for (int i = 0; i < bufflen; i++)
 6b2:	83 c0 01             	add    $0x1,%eax
 6b5:	39 c7                	cmp    %eax,%edi
 6b7:	75 f7                	jne    6b0 <create_big_file+0x90>
 6b9:	bb 04 00 00 00       	mov    $0x4,%ebx
        for (int k = 0; k < nchunks; k++) {
            // write to file
            if (write(fd, buff, bufflen) != bufflen) {
 6be:	83 ec 04             	sub    $0x4,%esp
 6c1:	68 00 04 00 00       	push   $0x400
 6c6:	56                   	push   %esi
 6c7:	ff 75 e0             	push   -0x20(%ebp)
 6ca:	e8 74 03 00 00       	call   a43 <write>
 6cf:	83 c4 10             	add    $0x10,%esp
 6d2:	3d 00 04 00 00       	cmp    $0x400,%eax
 6d7:	75 57                	jne    730 <create_big_file+0x110>
        for (int k = 0; k < nchunks; k++) {
 6d9:	83 eb 01             	sub    $0x1,%ebx
 6dc:	75 e0                	jne    6be <create_big_file+0x9e>
    for (int pg = 0; pg < N_PAGES; pg++) {
 6de:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 6e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e5:	39 45 0c             	cmp    %eax,0xc(%ebp)
 6e8:	75 9f                	jne    689 <create_big_file+0x69>
                failed();
            }
        }
        c++;
    }
    close(fd);
 6ea:	83 ec 0c             	sub    $0xc,%esp
 6ed:	ff 75 e0             	push   -0x20(%ebp)
 6f0:	e8 56 03 00 00       	call   a4b <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
 6f5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 6f8:	c1 e3 0c             	shl    $0xc,%ebx
 6fb:	53                   	push   %ebx
 6fc:	ff 75 08             	push   0x8(%ebp)
 6ff:	68 20 12 00 00       	push   $0x1220
 704:	6a 01                	push   $0x1
 706:	e8 95 04 00 00       	call   ba0 <printf>
           N_PAGES * PGSIZE);
    return N_PAGES * PGSIZE;
}
 70b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 70e:	89 d8                	mov    %ebx,%eax
 710:	5b                   	pop    %ebx
 711:	5e                   	pop    %esi
 712:	5f                   	pop    %edi
 713:	5d                   	pop    %ebp
 714:	c3                   	ret    
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
 715:	50                   	push   %eax
 716:	ff 75 08             	push   0x8(%ebp)
 719:	68 54 12 00 00       	push   $0x1254
 71e:	6a 01                	push   $0x1
 720:	e8 7b 04 00 00       	call   ba0 <printf>
        failed();
 725:	e8 56 fa ff ff       	call   180 <failed>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                printerr("Write to file FAILED %d\n", pg * bufflen);
 730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 733:	83 ec 04             	sub    $0x4,%esp
 736:	c1 e0 0a             	shl    $0xa,%eax
 739:	50                   	push   %eax
 73a:	68 78 12 00 00       	push   $0x1278
 73f:	6a 01                	push   $0x1
 741:	e8 5a 04 00 00       	call   ba0 <printf>
                failed();
 746:	e8 35 fa ff ff       	call   180 <failed>
 74b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 74f:	90                   	nop

00000750 <open_file>:

int open_file(char *filename, int filelength) {
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	56                   	push   %esi
 754:	53                   	push   %ebx
 755:	83 ec 28             	sub    $0x28,%esp
 758:	8b 75 08             	mov    0x8(%ebp),%esi
    int fd = open(filename, O_RDWR); // open in read-write mode
 75b:	6a 02                	push   $0x2
 75d:	56                   	push   %esi
 75e:	e8 00 03 00 00       	call   a63 <open>
    if (fd < 0) {
 763:	83 c4 10             	add    $0x10,%esp
 766:	85 c0                	test   %eax,%eax
 768:	78 27                	js     791 <open_file+0x41>
        printerr("Failed to open file %s\n", filename);
        failed();
    }
    struct stat st;
    if (fstat(fd, &st) < 0) {
 76a:	83 ec 08             	sub    $0x8,%esp
 76d:	89 c3                	mov    %eax,%ebx
 76f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 772:	50                   	push   %eax
 773:	53                   	push   %ebx
 774:	e8 02 03 00 00       	call   a7b <fstat>
 779:	83 c4 10             	add    $0x10,%esp
 77c:	85 c0                	test   %eax,%eax
 77e:	78 39                	js     7b9 <open_file+0x69>
        printerr("Failed to get file stat\n");
        failed();
    }
    if (st.size != filelength) {
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	3b 45 0c             	cmp    0xc(%ebp),%eax
 786:	75 1c                	jne    7a4 <open_file+0x54>
        printerr("File size = %d, expected %d\n", st.size, filelength);
        failed();
    }
    return fd;
}
 788:	8d 65 f8             	lea    -0x8(%ebp),%esp
 78b:	89 d8                	mov    %ebx,%eax
 78d:	5b                   	pop    %ebx
 78e:	5e                   	pop    %esi
 78f:	5d                   	pop    %ebp
 790:	c3                   	ret    
        printerr("Failed to open file %s\n", filename);
 791:	52                   	push   %edx
 792:	56                   	push   %esi
 793:	68 a4 12 00 00       	push   $0x12a4
 798:	6a 01                	push   $0x1
 79a:	e8 01 04 00 00       	call   ba0 <printf>
        failed();
 79f:	e8 dc f9 ff ff       	call   180 <failed>
        printerr("File size = %d, expected %d\n", st.size, filelength);
 7a4:	ff 75 0c             	push   0xc(%ebp)
 7a7:	50                   	push   %eax
 7a8:	68 fc 12 00 00       	push   $0x12fc
 7ad:	6a 01                	push   $0x1
 7af:	e8 ec 03 00 00       	call   ba0 <printf>
        failed();
 7b4:	e8 c7 f9 ff ff       	call   180 <failed>
        printerr("Failed to get file stat\n");
 7b9:	50                   	push   %eax
 7ba:	50                   	push   %eax
 7bb:	68 d0 12 00 00       	push   $0x12d0
 7c0:	6a 01                	push   $0x1
 7c2:	e8 d9 03 00 00       	call   ba0 <printf>
        failed();
 7c7:	e8 b4 f9 ff ff       	call   180 <failed>
 7cc:	66 90                	xchg   %ax,%ax
 7ce:	66 90                	xchg   %ax,%ax

000007d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 7d0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 7d1:	31 c0                	xor    %eax,%eax
{
 7d3:	89 e5                	mov    %esp,%ebp
 7d5:	53                   	push   %ebx
 7d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 7d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 7e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 7e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 7e7:	83 c0 01             	add    $0x1,%eax
 7ea:	84 d2                	test   %dl,%dl
 7ec:	75 f2                	jne    7e0 <strcpy+0x10>
    ;
  return os;
}
 7ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f1:	89 c8                	mov    %ecx,%eax
 7f3:	c9                   	leave  
 7f4:	c3                   	ret    
 7f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000800 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	53                   	push   %ebx
 804:	8b 55 08             	mov    0x8(%ebp),%edx
 807:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 80a:	0f b6 02             	movzbl (%edx),%eax
 80d:	84 c0                	test   %al,%al
 80f:	75 17                	jne    828 <strcmp+0x28>
 811:	eb 3a                	jmp    84d <strcmp+0x4d>
 813:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 817:	90                   	nop
 818:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 81c:	83 c2 01             	add    $0x1,%edx
 81f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 822:	84 c0                	test   %al,%al
 824:	74 1a                	je     840 <strcmp+0x40>
    p++, q++;
 826:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 828:	0f b6 19             	movzbl (%ecx),%ebx
 82b:	38 c3                	cmp    %al,%bl
 82d:	74 e9                	je     818 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 82f:	29 d8                	sub    %ebx,%eax
}
 831:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 834:	c9                   	leave  
 835:	c3                   	ret    
 836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 840:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 844:	31 c0                	xor    %eax,%eax
 846:	29 d8                	sub    %ebx,%eax
}
 848:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 84b:	c9                   	leave  
 84c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 84d:	0f b6 19             	movzbl (%ecx),%ebx
 850:	31 c0                	xor    %eax,%eax
 852:	eb db                	jmp    82f <strcmp+0x2f>
 854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 85b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 85f:	90                   	nop

00000860 <strlen>:

uint
strlen(const char *s)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 866:	80 3a 00             	cmpb   $0x0,(%edx)
 869:	74 15                	je     880 <strlen+0x20>
 86b:	31 c0                	xor    %eax,%eax
 86d:	8d 76 00             	lea    0x0(%esi),%esi
 870:	83 c0 01             	add    $0x1,%eax
 873:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 877:	89 c1                	mov    %eax,%ecx
 879:	75 f5                	jne    870 <strlen+0x10>
    ;
  return n;
}
 87b:	89 c8                	mov    %ecx,%eax
 87d:	5d                   	pop    %ebp
 87e:	c3                   	ret    
 87f:	90                   	nop
  for(n = 0; s[n]; n++)
 880:	31 c9                	xor    %ecx,%ecx
}
 882:	5d                   	pop    %ebp
 883:	89 c8                	mov    %ecx,%eax
 885:	c3                   	ret    
 886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 88d:	8d 76 00             	lea    0x0(%esi),%esi

00000890 <memset>:

void*
memset(void *dst, int c, uint n)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 897:	8b 4d 10             	mov    0x10(%ebp),%ecx
 89a:	8b 45 0c             	mov    0xc(%ebp),%eax
 89d:	89 d7                	mov    %edx,%edi
 89f:	fc                   	cld    
 8a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 8a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 8a5:	89 d0                	mov    %edx,%eax
 8a7:	c9                   	leave  
 8a8:	c3                   	ret    
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008b0 <strchr>:

char*
strchr(const char *s, char c)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	8b 45 08             	mov    0x8(%ebp),%eax
 8b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 8ba:	0f b6 10             	movzbl (%eax),%edx
 8bd:	84 d2                	test   %dl,%dl
 8bf:	75 12                	jne    8d3 <strchr+0x23>
 8c1:	eb 1d                	jmp    8e0 <strchr+0x30>
 8c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8c7:	90                   	nop
 8c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 8cc:	83 c0 01             	add    $0x1,%eax
 8cf:	84 d2                	test   %dl,%dl
 8d1:	74 0d                	je     8e0 <strchr+0x30>
    if(*s == c)
 8d3:	38 d1                	cmp    %dl,%cl
 8d5:	75 f1                	jne    8c8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 8d7:	5d                   	pop    %ebp
 8d8:	c3                   	ret    
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 8e0:	31 c0                	xor    %eax,%eax
}
 8e2:	5d                   	pop    %ebp
 8e3:	c3                   	ret    
 8e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop

000008f0 <gets>:

char*
gets(char *buf, int max)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	57                   	push   %edi
 8f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 8f5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 8f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 8f9:	31 db                	xor    %ebx,%ebx
{
 8fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 8fe:	eb 27                	jmp    927 <gets+0x37>
    cc = read(0, &c, 1);
 900:	83 ec 04             	sub    $0x4,%esp
 903:	6a 01                	push   $0x1
 905:	57                   	push   %edi
 906:	6a 00                	push   $0x0
 908:	e8 2e 01 00 00       	call   a3b <read>
    if(cc < 1)
 90d:	83 c4 10             	add    $0x10,%esp
 910:	85 c0                	test   %eax,%eax
 912:	7e 1d                	jle    931 <gets+0x41>
      break;
    buf[i++] = c;
 914:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 918:	8b 55 08             	mov    0x8(%ebp),%edx
 91b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 91f:	3c 0a                	cmp    $0xa,%al
 921:	74 1d                	je     940 <gets+0x50>
 923:	3c 0d                	cmp    $0xd,%al
 925:	74 19                	je     940 <gets+0x50>
  for(i=0; i+1 < max; ){
 927:	89 de                	mov    %ebx,%esi
 929:	83 c3 01             	add    $0x1,%ebx
 92c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 92f:	7c cf                	jl     900 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 931:	8b 45 08             	mov    0x8(%ebp),%eax
 934:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 938:	8d 65 f4             	lea    -0xc(%ebp),%esp
 93b:	5b                   	pop    %ebx
 93c:	5e                   	pop    %esi
 93d:	5f                   	pop    %edi
 93e:	5d                   	pop    %ebp
 93f:	c3                   	ret    
  buf[i] = '\0';
 940:	8b 45 08             	mov    0x8(%ebp),%eax
 943:	89 de                	mov    %ebx,%esi
 945:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 949:	8d 65 f4             	lea    -0xc(%ebp),%esp
 94c:	5b                   	pop    %ebx
 94d:	5e                   	pop    %esi
 94e:	5f                   	pop    %edi
 94f:	5d                   	pop    %ebp
 950:	c3                   	ret    
 951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 958:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 95f:	90                   	nop

00000960 <stat>:

int
stat(const char *n, struct stat *st)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	56                   	push   %esi
 964:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 965:	83 ec 08             	sub    $0x8,%esp
 968:	6a 00                	push   $0x0
 96a:	ff 75 08             	push   0x8(%ebp)
 96d:	e8 f1 00 00 00       	call   a63 <open>
  if(fd < 0)
 972:	83 c4 10             	add    $0x10,%esp
 975:	85 c0                	test   %eax,%eax
 977:	78 27                	js     9a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 979:	83 ec 08             	sub    $0x8,%esp
 97c:	ff 75 0c             	push   0xc(%ebp)
 97f:	89 c3                	mov    %eax,%ebx
 981:	50                   	push   %eax
 982:	e8 f4 00 00 00       	call   a7b <fstat>
  close(fd);
 987:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 98a:	89 c6                	mov    %eax,%esi
  close(fd);
 98c:	e8 ba 00 00 00       	call   a4b <close>
  return r;
 991:	83 c4 10             	add    $0x10,%esp
}
 994:	8d 65 f8             	lea    -0x8(%ebp),%esp
 997:	89 f0                	mov    %esi,%eax
 999:	5b                   	pop    %ebx
 99a:	5e                   	pop    %esi
 99b:	5d                   	pop    %ebp
 99c:	c3                   	ret    
 99d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 9a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 9a5:	eb ed                	jmp    994 <stat+0x34>
 9a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ae:	66 90                	xchg   %ax,%ax

000009b0 <atoi>:

int
atoi(const char *s)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	53                   	push   %ebx
 9b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 9b7:	0f be 02             	movsbl (%edx),%eax
 9ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 9bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 9c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 9c5:	77 1e                	ja     9e5 <atoi+0x35>
 9c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ce:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 9d0:	83 c2 01             	add    $0x1,%edx
 9d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 9d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 9da:	0f be 02             	movsbl (%edx),%eax
 9dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 9e0:	80 fb 09             	cmp    $0x9,%bl
 9e3:	76 eb                	jbe    9d0 <atoi+0x20>
  return n;
}
 9e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 9e8:	89 c8                	mov    %ecx,%eax
 9ea:	c9                   	leave  
 9eb:	c3                   	ret    
 9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	57                   	push   %edi
 9f4:	8b 45 10             	mov    0x10(%ebp),%eax
 9f7:	8b 55 08             	mov    0x8(%ebp),%edx
 9fa:	56                   	push   %esi
 9fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 9fe:	85 c0                	test   %eax,%eax
 a00:	7e 13                	jle    a15 <memmove+0x25>
 a02:	01 d0                	add    %edx,%eax
  dst = vdst;
 a04:	89 d7                	mov    %edx,%edi
 a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 a10:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 a11:	39 f8                	cmp    %edi,%eax
 a13:	75 fb                	jne    a10 <memmove+0x20>
  return vdst;
}
 a15:	5e                   	pop    %esi
 a16:	89 d0                	mov    %edx,%eax
 a18:	5f                   	pop    %edi
 a19:	5d                   	pop    %ebp
 a1a:	c3                   	ret    

00000a1b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 a1b:	b8 01 00 00 00       	mov    $0x1,%eax
 a20:	cd 40                	int    $0x40
 a22:	c3                   	ret    

00000a23 <exit>:
SYSCALL(exit)
 a23:	b8 02 00 00 00       	mov    $0x2,%eax
 a28:	cd 40                	int    $0x40
 a2a:	c3                   	ret    

00000a2b <wait>:
SYSCALL(wait)
 a2b:	b8 03 00 00 00       	mov    $0x3,%eax
 a30:	cd 40                	int    $0x40
 a32:	c3                   	ret    

00000a33 <pipe>:
SYSCALL(pipe)
 a33:	b8 04 00 00 00       	mov    $0x4,%eax
 a38:	cd 40                	int    $0x40
 a3a:	c3                   	ret    

00000a3b <read>:
SYSCALL(read)
 a3b:	b8 05 00 00 00       	mov    $0x5,%eax
 a40:	cd 40                	int    $0x40
 a42:	c3                   	ret    

00000a43 <write>:
SYSCALL(write)
 a43:	b8 10 00 00 00       	mov    $0x10,%eax
 a48:	cd 40                	int    $0x40
 a4a:	c3                   	ret    

00000a4b <close>:
SYSCALL(close)
 a4b:	b8 15 00 00 00       	mov    $0x15,%eax
 a50:	cd 40                	int    $0x40
 a52:	c3                   	ret    

00000a53 <kill>:
SYSCALL(kill)
 a53:	b8 06 00 00 00       	mov    $0x6,%eax
 a58:	cd 40                	int    $0x40
 a5a:	c3                   	ret    

00000a5b <exec>:
SYSCALL(exec)
 a5b:	b8 07 00 00 00       	mov    $0x7,%eax
 a60:	cd 40                	int    $0x40
 a62:	c3                   	ret    

00000a63 <open>:
SYSCALL(open)
 a63:	b8 0f 00 00 00       	mov    $0xf,%eax
 a68:	cd 40                	int    $0x40
 a6a:	c3                   	ret    

00000a6b <mknod>:
SYSCALL(mknod)
 a6b:	b8 11 00 00 00       	mov    $0x11,%eax
 a70:	cd 40                	int    $0x40
 a72:	c3                   	ret    

00000a73 <unlink>:
SYSCALL(unlink)
 a73:	b8 12 00 00 00       	mov    $0x12,%eax
 a78:	cd 40                	int    $0x40
 a7a:	c3                   	ret    

00000a7b <fstat>:
SYSCALL(fstat)
 a7b:	b8 08 00 00 00       	mov    $0x8,%eax
 a80:	cd 40                	int    $0x40
 a82:	c3                   	ret    

00000a83 <link>:
SYSCALL(link)
 a83:	b8 13 00 00 00       	mov    $0x13,%eax
 a88:	cd 40                	int    $0x40
 a8a:	c3                   	ret    

00000a8b <mkdir>:
SYSCALL(mkdir)
 a8b:	b8 14 00 00 00       	mov    $0x14,%eax
 a90:	cd 40                	int    $0x40
 a92:	c3                   	ret    

00000a93 <chdir>:
SYSCALL(chdir)
 a93:	b8 09 00 00 00       	mov    $0x9,%eax
 a98:	cd 40                	int    $0x40
 a9a:	c3                   	ret    

00000a9b <dup>:
SYSCALL(dup)
 a9b:	b8 0a 00 00 00       	mov    $0xa,%eax
 aa0:	cd 40                	int    $0x40
 aa2:	c3                   	ret    

00000aa3 <getpid>:
SYSCALL(getpid)
 aa3:	b8 0b 00 00 00       	mov    $0xb,%eax
 aa8:	cd 40                	int    $0x40
 aaa:	c3                   	ret    

00000aab <sbrk>:
SYSCALL(sbrk)
 aab:	b8 0c 00 00 00       	mov    $0xc,%eax
 ab0:	cd 40                	int    $0x40
 ab2:	c3                   	ret    

00000ab3 <sleep>:
SYSCALL(sleep)
 ab3:	b8 0d 00 00 00       	mov    $0xd,%eax
 ab8:	cd 40                	int    $0x40
 aba:	c3                   	ret    

00000abb <uptime>:
SYSCALL(uptime)
 abb:	b8 0e 00 00 00       	mov    $0xe,%eax
 ac0:	cd 40                	int    $0x40
 ac2:	c3                   	ret    

00000ac3 <wmap>:
SYSCALL(wmap)
 ac3:	b8 16 00 00 00       	mov    $0x16,%eax
 ac8:	cd 40                	int    $0x40
 aca:	c3                   	ret    

00000acb <va2pa>:
SYSCALL(va2pa)
 acb:	b8 17 00 00 00       	mov    $0x17,%eax
 ad0:	cd 40                	int    $0x40
 ad2:	c3                   	ret    

00000ad3 <wunmap>:
SYSCALL(wunmap)
 ad3:	b8 18 00 00 00       	mov    $0x18,%eax
 ad8:	cd 40                	int    $0x40
 ada:	c3                   	ret    

00000adb <getwmapinfo>:
SYSCALL(getwmapinfo)
 adb:	b8 19 00 00 00       	mov    $0x19,%eax
 ae0:	cd 40                	int    $0x40
 ae2:	c3                   	ret    
 ae3:	66 90                	xchg   %ax,%ax
 ae5:	66 90                	xchg   %ax,%ax
 ae7:	66 90                	xchg   %ax,%ax
 ae9:	66 90                	xchg   %ax,%ax
 aeb:	66 90                	xchg   %ax,%ax
 aed:	66 90                	xchg   %ax,%ax
 aef:	90                   	nop

00000af0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
 af6:	83 ec 3c             	sub    $0x3c,%esp
 af9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 afc:	89 d1                	mov    %edx,%ecx
{
 afe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 b01:	85 d2                	test   %edx,%edx
 b03:	0f 89 7f 00 00 00    	jns    b88 <printint+0x98>
 b09:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b0d:	74 79                	je     b88 <printint+0x98>
    neg = 1;
 b0f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 b16:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 b18:	31 db                	xor    %ebx,%ebx
 b1a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 b20:	89 c8                	mov    %ecx,%eax
 b22:	31 d2                	xor    %edx,%edx
 b24:	89 cf                	mov    %ecx,%edi
 b26:	f7 75 c4             	divl   -0x3c(%ebp)
 b29:	0f b6 92 64 14 00 00 	movzbl 0x1464(%edx),%edx
 b30:	89 45 c0             	mov    %eax,-0x40(%ebp)
 b33:	89 d8                	mov    %ebx,%eax
 b35:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 b38:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 b3b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 b3e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 b41:	76 dd                	jbe    b20 <printint+0x30>
  if(neg)
 b43:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 b46:	85 c9                	test   %ecx,%ecx
 b48:	74 0c                	je     b56 <printint+0x66>
    buf[i++] = '-';
 b4a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 b4f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 b51:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 b56:	8b 7d b8             	mov    -0x48(%ebp),%edi
 b59:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 b5d:	eb 07                	jmp    b66 <printint+0x76>
 b5f:	90                   	nop
    putc(fd, buf[i]);
 b60:	0f b6 13             	movzbl (%ebx),%edx
 b63:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 b66:	83 ec 04             	sub    $0x4,%esp
 b69:	88 55 d7             	mov    %dl,-0x29(%ebp)
 b6c:	6a 01                	push   $0x1
 b6e:	56                   	push   %esi
 b6f:	57                   	push   %edi
 b70:	e8 ce fe ff ff       	call   a43 <write>
  while(--i >= 0)
 b75:	83 c4 10             	add    $0x10,%esp
 b78:	39 de                	cmp    %ebx,%esi
 b7a:	75 e4                	jne    b60 <printint+0x70>
}
 b7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b7f:	5b                   	pop    %ebx
 b80:	5e                   	pop    %esi
 b81:	5f                   	pop    %edi
 b82:	5d                   	pop    %ebp
 b83:	c3                   	ret    
 b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 b88:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 b8f:	eb 87                	jmp    b18 <printint+0x28>
 b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b9f:	90                   	nop

00000ba0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	57                   	push   %edi
 ba4:	56                   	push   %esi
 ba5:	53                   	push   %ebx
 ba6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ba9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 bac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 baf:	0f b6 13             	movzbl (%ebx),%edx
 bb2:	84 d2                	test   %dl,%dl
 bb4:	74 6a                	je     c20 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 bb6:	8d 45 10             	lea    0x10(%ebp),%eax
 bb9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 bbc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 bbf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 bc1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 bc4:	eb 36                	jmp    bfc <printf+0x5c>
 bc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bcd:	8d 76 00             	lea    0x0(%esi),%esi
 bd0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 bd3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 bd8:	83 f8 25             	cmp    $0x25,%eax
 bdb:	74 15                	je     bf2 <printf+0x52>
  write(fd, &c, 1);
 bdd:	83 ec 04             	sub    $0x4,%esp
 be0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 be3:	6a 01                	push   $0x1
 be5:	57                   	push   %edi
 be6:	56                   	push   %esi
 be7:	e8 57 fe ff ff       	call   a43 <write>
 bec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 bef:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 bf2:	0f b6 13             	movzbl (%ebx),%edx
 bf5:	83 c3 01             	add    $0x1,%ebx
 bf8:	84 d2                	test   %dl,%dl
 bfa:	74 24                	je     c20 <printf+0x80>
    c = fmt[i] & 0xff;
 bfc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 bff:	85 c9                	test   %ecx,%ecx
 c01:	74 cd                	je     bd0 <printf+0x30>
      }
    } else if(state == '%'){
 c03:	83 f9 25             	cmp    $0x25,%ecx
 c06:	75 ea                	jne    bf2 <printf+0x52>
      if(c == 'd'){
 c08:	83 f8 25             	cmp    $0x25,%eax
 c0b:	0f 84 07 01 00 00    	je     d18 <printf+0x178>
 c11:	83 e8 63             	sub    $0x63,%eax
 c14:	83 f8 15             	cmp    $0x15,%eax
 c17:	77 17                	ja     c30 <printf+0x90>
 c19:	ff 24 85 0c 14 00 00 	jmp    *0x140c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 c20:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c23:	5b                   	pop    %ebx
 c24:	5e                   	pop    %esi
 c25:	5f                   	pop    %edi
 c26:	5d                   	pop    %ebp
 c27:	c3                   	ret    
 c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c2f:	90                   	nop
  write(fd, &c, 1);
 c30:	83 ec 04             	sub    $0x4,%esp
 c33:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 c36:	6a 01                	push   $0x1
 c38:	57                   	push   %edi
 c39:	56                   	push   %esi
 c3a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c3e:	e8 00 fe ff ff       	call   a43 <write>
        putc(fd, c);
 c43:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 c47:	83 c4 0c             	add    $0xc,%esp
 c4a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 c4d:	6a 01                	push   $0x1
 c4f:	57                   	push   %edi
 c50:	56                   	push   %esi
 c51:	e8 ed fd ff ff       	call   a43 <write>
        putc(fd, c);
 c56:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c59:	31 c9                	xor    %ecx,%ecx
 c5b:	eb 95                	jmp    bf2 <printf+0x52>
 c5d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 c60:	83 ec 0c             	sub    $0xc,%esp
 c63:	b9 10 00 00 00       	mov    $0x10,%ecx
 c68:	6a 00                	push   $0x0
 c6a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 c6d:	8b 10                	mov    (%eax),%edx
 c6f:	89 f0                	mov    %esi,%eax
 c71:	e8 7a fe ff ff       	call   af0 <printint>
        ap++;
 c76:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 c7a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c7d:	31 c9                	xor    %ecx,%ecx
 c7f:	e9 6e ff ff ff       	jmp    bf2 <printf+0x52>
 c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 c88:	8b 45 d0             	mov    -0x30(%ebp),%eax
 c8b:	8b 10                	mov    (%eax),%edx
        ap++;
 c8d:	83 c0 04             	add    $0x4,%eax
 c90:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 c93:	85 d2                	test   %edx,%edx
 c95:	0f 84 8d 00 00 00    	je     d28 <printf+0x188>
        while(*s != 0){
 c9b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 c9e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 ca0:	84 c0                	test   %al,%al
 ca2:	0f 84 4a ff ff ff    	je     bf2 <printf+0x52>
 ca8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 cab:	89 d3                	mov    %edx,%ebx
 cad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 cb0:	83 ec 04             	sub    $0x4,%esp
          s++;
 cb3:	83 c3 01             	add    $0x1,%ebx
 cb6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 cb9:	6a 01                	push   $0x1
 cbb:	57                   	push   %edi
 cbc:	56                   	push   %esi
 cbd:	e8 81 fd ff ff       	call   a43 <write>
        while(*s != 0){
 cc2:	0f b6 03             	movzbl (%ebx),%eax
 cc5:	83 c4 10             	add    $0x10,%esp
 cc8:	84 c0                	test   %al,%al
 cca:	75 e4                	jne    cb0 <printf+0x110>
      state = 0;
 ccc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 ccf:	31 c9                	xor    %ecx,%ecx
 cd1:	e9 1c ff ff ff       	jmp    bf2 <printf+0x52>
 cd6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 cdd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 ce0:	83 ec 0c             	sub    $0xc,%esp
 ce3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 ce8:	6a 01                	push   $0x1
 cea:	e9 7b ff ff ff       	jmp    c6a <printf+0xca>
 cef:	90                   	nop
        putc(fd, *ap);
 cf0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 cf3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 cf6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 cf8:	6a 01                	push   $0x1
 cfa:	57                   	push   %edi
 cfb:	56                   	push   %esi
        putc(fd, *ap);
 cfc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 cff:	e8 3f fd ff ff       	call   a43 <write>
        ap++;
 d04:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 d08:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d0b:	31 c9                	xor    %ecx,%ecx
 d0d:	e9 e0 fe ff ff       	jmp    bf2 <printf+0x52>
 d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 d18:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 d1b:	83 ec 04             	sub    $0x4,%esp
 d1e:	e9 2a ff ff ff       	jmp    c4d <printf+0xad>
 d23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 d27:	90                   	nop
          s = "(null)";
 d28:	ba 04 14 00 00       	mov    $0x1404,%edx
        while(*s != 0){
 d2d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 d30:	b8 28 00 00 00       	mov    $0x28,%eax
 d35:	89 d3                	mov    %edx,%ebx
 d37:	e9 74 ff ff ff       	jmp    cb0 <printf+0x110>
 d3c:	66 90                	xchg   %ax,%ax
 d3e:	66 90                	xchg   %ax,%ax

00000d40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d41:	a1 44 19 00 00       	mov    0x1944,%eax
{
 d46:	89 e5                	mov    %esp,%ebp
 d48:	57                   	push   %edi
 d49:	56                   	push   %esi
 d4a:	53                   	push   %ebx
 d4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 d4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 d58:	89 c2                	mov    %eax,%edx
 d5a:	8b 00                	mov    (%eax),%eax
 d5c:	39 ca                	cmp    %ecx,%edx
 d5e:	73 30                	jae    d90 <free+0x50>
 d60:	39 c1                	cmp    %eax,%ecx
 d62:	72 04                	jb     d68 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d64:	39 c2                	cmp    %eax,%edx
 d66:	72 f0                	jb     d58 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 d68:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d6b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d6e:	39 f8                	cmp    %edi,%eax
 d70:	74 30                	je     da2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 d72:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 d75:	8b 42 04             	mov    0x4(%edx),%eax
 d78:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 d7b:	39 f1                	cmp    %esi,%ecx
 d7d:	74 3a                	je     db9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 d7f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 d81:	5b                   	pop    %ebx
  freep = p;
 d82:	89 15 44 19 00 00    	mov    %edx,0x1944
}
 d88:	5e                   	pop    %esi
 d89:	5f                   	pop    %edi
 d8a:	5d                   	pop    %ebp
 d8b:	c3                   	ret    
 d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d90:	39 c2                	cmp    %eax,%edx
 d92:	72 c4                	jb     d58 <free+0x18>
 d94:	39 c1                	cmp    %eax,%ecx
 d96:	73 c0                	jae    d58 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 d98:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d9b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d9e:	39 f8                	cmp    %edi,%eax
 da0:	75 d0                	jne    d72 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 da2:	03 70 04             	add    0x4(%eax),%esi
 da5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 da8:	8b 02                	mov    (%edx),%eax
 daa:	8b 00                	mov    (%eax),%eax
 dac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 daf:	8b 42 04             	mov    0x4(%edx),%eax
 db2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 db5:	39 f1                	cmp    %esi,%ecx
 db7:	75 c6                	jne    d7f <free+0x3f>
    p->s.size += bp->s.size;
 db9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 dbc:	89 15 44 19 00 00    	mov    %edx,0x1944
    p->s.size += bp->s.size;
 dc2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 dc5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 dc8:	89 0a                	mov    %ecx,(%edx)
}
 dca:	5b                   	pop    %ebx
 dcb:	5e                   	pop    %esi
 dcc:	5f                   	pop    %edi
 dcd:	5d                   	pop    %ebp
 dce:	c3                   	ret    
 dcf:	90                   	nop

00000dd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 dd0:	55                   	push   %ebp
 dd1:	89 e5                	mov    %esp,%ebp
 dd3:	57                   	push   %edi
 dd4:	56                   	push   %esi
 dd5:	53                   	push   %ebx
 dd6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 ddc:	8b 3d 44 19 00 00    	mov    0x1944,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 de2:	8d 70 07             	lea    0x7(%eax),%esi
 de5:	c1 ee 03             	shr    $0x3,%esi
 de8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 deb:	85 ff                	test   %edi,%edi
 ded:	0f 84 9d 00 00 00    	je     e90 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 df5:	8b 4a 04             	mov    0x4(%edx),%ecx
 df8:	39 f1                	cmp    %esi,%ecx
 dfa:	73 6a                	jae    e66 <malloc+0x96>
 dfc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e01:	39 de                	cmp    %ebx,%esi
 e03:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 e06:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 e0d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 e10:	eb 17                	jmp    e29 <malloc+0x59>
 e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e1a:	8b 48 04             	mov    0x4(%eax),%ecx
 e1d:	39 f1                	cmp    %esi,%ecx
 e1f:	73 4f                	jae    e70 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e21:	8b 3d 44 19 00 00    	mov    0x1944,%edi
 e27:	89 c2                	mov    %eax,%edx
 e29:	39 d7                	cmp    %edx,%edi
 e2b:	75 eb                	jne    e18 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 e2d:	83 ec 0c             	sub    $0xc,%esp
 e30:	ff 75 e4             	push   -0x1c(%ebp)
 e33:	e8 73 fc ff ff       	call   aab <sbrk>
  if(p == (char*)-1)
 e38:	83 c4 10             	add    $0x10,%esp
 e3b:	83 f8 ff             	cmp    $0xffffffff,%eax
 e3e:	74 1c                	je     e5c <malloc+0x8c>
  hp->s.size = nu;
 e40:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e43:	83 ec 0c             	sub    $0xc,%esp
 e46:	83 c0 08             	add    $0x8,%eax
 e49:	50                   	push   %eax
 e4a:	e8 f1 fe ff ff       	call   d40 <free>
  return freep;
 e4f:	8b 15 44 19 00 00    	mov    0x1944,%edx
      if((p = morecore(nunits)) == 0)
 e55:	83 c4 10             	add    $0x10,%esp
 e58:	85 d2                	test   %edx,%edx
 e5a:	75 bc                	jne    e18 <malloc+0x48>
        return 0;
  }
}
 e5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 e5f:	31 c0                	xor    %eax,%eax
}
 e61:	5b                   	pop    %ebx
 e62:	5e                   	pop    %esi
 e63:	5f                   	pop    %edi
 e64:	5d                   	pop    %ebp
 e65:	c3                   	ret    
    if(p->s.size >= nunits){
 e66:	89 d0                	mov    %edx,%eax
 e68:	89 fa                	mov    %edi,%edx
 e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 e70:	39 ce                	cmp    %ecx,%esi
 e72:	74 4c                	je     ec0 <malloc+0xf0>
        p->s.size -= nunits;
 e74:	29 f1                	sub    %esi,%ecx
 e76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e7c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 e7f:	89 15 44 19 00 00    	mov    %edx,0x1944
}
 e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 e88:	83 c0 08             	add    $0x8,%eax
}
 e8b:	5b                   	pop    %ebx
 e8c:	5e                   	pop    %esi
 e8d:	5f                   	pop    %edi
 e8e:	5d                   	pop    %ebp
 e8f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 e90:	c7 05 44 19 00 00 48 	movl   $0x1948,0x1944
 e97:	19 00 00 
    base.s.size = 0;
 e9a:	bf 48 19 00 00       	mov    $0x1948,%edi
    base.s.ptr = freep = prevp = &base;
 e9f:	c7 05 48 19 00 00 48 	movl   $0x1948,0x1948
 ea6:	19 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 eab:	c7 05 4c 19 00 00 00 	movl   $0x0,0x194c
 eb2:	00 00 00 
    if(p->s.size >= nunits){
 eb5:	e9 42 ff ff ff       	jmp    dfc <malloc+0x2c>
 eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 ec0:	8b 08                	mov    (%eax),%ecx
 ec2:	89 0a                	mov    %ecx,(%edx)
 ec4:	eb b9                	jmp    e7f <malloc+0xaf>
