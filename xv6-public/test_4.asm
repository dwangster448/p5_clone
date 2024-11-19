
_test_4:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// Summary: MAP: Place one fixed filebacked map
// ====================================================================

char *test_name = "TEST_4";

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
  16:	ff 35 48 18 00 00    	push   0x1848
  1c:	68 f6 12 00 00       	push   $0x12f6
  21:	6a 01                	push   $0x1
  23:	e8 d8 0a 00 00       	call   b00 <printf>
    validate_initial_state();
  28:	e8 d3 03 00 00       	call   400 <validate_initial_state>

    // create and open a small file
    char *filename = "small.txt";
    char val = 101;
    int filelength = create_small_file(filename, val);
  2d:	5b                   	pop    %ebx
  2e:	5e                   	pop    %esi
  2f:	6a 65                	push   $0x65
  31:	68 fc 12 00 00       	push   $0x12fc
  36:	e8 75 04 00 00       	call   4b0 <create_small_file>
    int fd = open_file(filename, filelength);
  3b:	5a                   	pop    %edx
  3c:	59                   	pop    %ecx
  3d:	50                   	push   %eax
    int filelength = create_small_file(filename, val);
  3e:	89 c3                	mov    %eax,%ebx
    int fd = open_file(filename, filelength);
  40:	68 fc 12 00 00       	push   $0x12fc
  45:	e8 66 06 00 00       	call   6b0 <open_file>

    // place one map
    uint addr = MMAPBASE + PGSIZE * 47;
    uint length = filelength;
    int filebacked = MAP_FIXED | MAP_SHARED;
    uint map = wmap(addr, length, filebacked, fd);
  4a:	50                   	push   %eax
    int fd = open_file(filename, filelength);
  4b:	89 c6                	mov    %eax,%esi
    uint map = wmap(addr, length, filebacked, fd);
  4d:	6a 0a                	push   $0xa
  4f:	53                   	push   %ebx
  50:	68 00 f0 02 60       	push   $0x6002f000
  55:	e8 c9 09 00 00       	call   a23 <wmap>
    if (map != addr) {
  5a:	83 c4 20             	add    $0x20,%esp
  5d:	3d 00 f0 02 60       	cmp    $0x6002f000,%eax
  62:	74 13                	je     77 <main+0x77>
        printerr("wmap() returned %d\n", (int)map);
  64:	51                   	push   %ecx
  65:	50                   	push   %eax
  66:	68 8c 12 00 00       	push   $0x128c
  6b:	6a 01                	push   $0x1
  6d:	e8 8e 0a 00 00       	call   b00 <printf>
        failed();
  72:	e8 69 00 00 00       	call   e0 <failed>
    }
    close(fd);
  77:	83 ec 0c             	sub    $0xc,%esp
  7a:	56                   	push   %esi

    // validate final state
    struct wmapinfo winfo;
    get_n_validate_wmap_info(&winfo, 1);   // 1 map exists
  7b:	8d b5 24 ff ff ff    	lea    -0xdc(%ebp),%esi
    close(fd);
  81:	e8 25 09 00 00       	call   9ab <close>
    get_n_validate_wmap_info(&winfo, 1);   // 1 map exists
  86:	58                   	pop    %eax
  87:	5a                   	pop    %edx
  88:	6a 01                	push   $0x1
  8a:	56                   	push   %esi
  8b:	e8 c0 00 00 00       	call   150 <get_n_validate_wmap_info>
    map_exists(&winfo, map, length, TRUE); // the map exists
  90:	6a 01                	push   $0x1
  92:	53                   	push   %ebx
  93:	68 00 f0 02 60       	push   $0x6002f000
  98:	56                   	push   %esi
  99:	e8 32 01 00 00       	call   1d0 <map_exists>
  9e:	83 c4 10             	add    $0x10,%esp
    printf(1, "INFO: Map 1 at 0x%x with length 0x%x. \tOkay.\n", map, length);
  a1:	53                   	push   %ebx
  a2:	68 00 f0 02 60       	push   $0x6002f000
  a7:	68 b4 12 00 00       	push   $0x12b4
  ac:	6a 01                	push   $0x1
  ae:	e8 4d 0a 00 00       	call   b00 <printf>

    // test ends
    success();
  b3:	83 c4 20             	add    $0x20,%esp
  b6:	e8 05 00 00 00       	call   c0 <success>
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <success>:
           "\033[0m" fmt,                                                           \
           ##__VA_ARGS__)

extern char *test_name;

void success() {
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "\033[0;32mSUCCESS:\033[0m %s\t PASSED\n\n", test_name);
  c6:	ff 35 48 18 00 00    	push   0x1848
  cc:	68 28 0e 00 00       	push   $0xe28
  d1:	6a 01                	push   $0x1
  d3:	e8 28 0a 00 00       	call   b00 <printf>
    exit();
  d8:	e8 a6 08 00 00       	call   983 <exit>
  dd:	8d 76 00             	lea    0x0(%esi),%esi

000000e0 <failed>:
}

void failed() {
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	83 ec 08             	sub    $0x8,%esp
    printf(1, "\n\033[0;31mFAIL:\033[0m %s\t FAILED (pid %d)\n\n", test_name,
  e6:	e8 18 09 00 00       	call   a03 <getpid>
  eb:	50                   	push   %eax
  ec:	ff 35 48 18 00 00    	push   0x1848
  f2:	68 4c 0e 00 00       	push   $0xe4c
  f7:	6a 01                	push   $0x1
  f9:	e8 02 0a 00 00       	call   b00 <printf>
           getpid());
    exit();
  fe:	e8 80 08 00 00       	call   983 <exit>
 103:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000110 <reset_wmapinfo>:
}

void reset_wmapinfo(struct wmapinfo *info) {
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
    info->total_mmaps = -1;
 116:	c7 02 ff ff ff ff    	movl   $0xffffffff,(%edx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 11c:	8d 42 04             	lea    0x4(%edx),%eax
 11f:	83 c2 44             	add    $0x44,%edx
 122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        info->addr[i] = -1;
 128:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 12e:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
 131:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
 138:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 13f:	39 d0                	cmp    %edx,%eax
 141:	75 e5                	jne    128 <reset_wmapinfo+0x18>
    }
}
 143:	5d                   	pop    %ebp
 144:	c3                   	ret    
 145:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <get_n_validate_wmap_info>:

/**
 * Get the wmapinfo and validate the total number of maps
 */
void get_n_validate_wmap_info(struct wmapinfo *info, int expected_total_mmaps) {
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 04             	sub    $0x4,%esp
 157:	8b 5d 08             	mov    0x8(%ebp),%ebx
    info->total_mmaps = -1;
 15a:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 160:	8d 43 04             	lea    0x4(%ebx),%eax
 163:	8d 53 44             	lea    0x44(%ebx),%edx
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi
        info->addr[i] = -1;
 170:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 176:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
 179:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
 180:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
 187:	39 d0                	cmp    %edx,%eax
 189:	75 e5                	jne    170 <get_n_validate_wmap_info+0x20>
    reset_wmapinfo(info);
    int ret = getwmapinfo(info);
 18b:	83 ec 0c             	sub    $0xc,%esp
 18e:	53                   	push   %ebx
 18f:	e8 a7 08 00 00       	call   a3b <getwmapinfo>
    if (ret != SUCCESS) {
 194:	83 c4 10             	add    $0x10,%esp
 197:	85 c0                	test   %eax,%eax
 199:	75 0c                	jne    1a7 <get_n_validate_wmap_info+0x57>
        printerr("getwmapinfo() returned %d\n", ret);
        failed();
    }
    if (info->total_mmaps != expected_total_mmaps) {
 19b:	8b 03                	mov    (%ebx),%eax
 19d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1a0:	75 18                	jne    1ba <get_n_validate_wmap_info+0x6a>

        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
                 expected_total_mmaps);
        failed();
    }
}
 1a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a5:	c9                   	leave  
 1a6:	c3                   	ret    
        printerr("getwmapinfo() returned %d\n", ret);
 1a7:	52                   	push   %edx
 1a8:	50                   	push   %eax
 1a9:	68 74 0e 00 00       	push   $0xe74
 1ae:	6a 01                	push   $0x1
 1b0:	e8 4b 09 00 00       	call   b00 <printf>
        failed();
 1b5:	e8 26 ff ff ff       	call   e0 <failed>
        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
 1ba:	ff 75 0c             	push   0xc(%ebp)
 1bd:	50                   	push   %eax
 1be:	68 a4 0e 00 00       	push   $0xea4
 1c3:	6a 01                	push   $0x1
 1c5:	e8 36 09 00 00       	call   b00 <printf>
        failed();
 1ca:	e8 11 ff ff ff       	call   e0 <failed>
 1cf:	90                   	nop

000001d0 <map_exists>:

/**
 * Check if a map with the given address and length exists in the list of maps
 */
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 1d0:	55                   	push   %ebp
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
 1d1:	31 c0                	xor    %eax,%eax
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	56                   	push   %esi
 1d6:	8b 55 08             	mov    0x8(%ebp),%edx
 1d9:	8b 75 10             	mov    0x10(%ebp),%esi
 1dc:	53                   	push   %ebx
 1dd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    for (int i = 0; i < info->total_mmaps; i++) {
 1e0:	8b 0a                	mov    (%edx),%ecx
 1e2:	85 c9                	test   %ecx,%ecx
 1e4:	7f 11                	jg     1f7 <map_exists+0x27>
 1e6:	eb 20                	jmp    208 <map_exists+0x38>
 1e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop
 1f0:	83 c0 01             	add    $0x1,%eax
 1f3:	39 c8                	cmp    %ecx,%eax
 1f5:	74 21                	je     218 <map_exists+0x48>
        if (info->addr[i] == addr && info->length[i] == length) {
 1f7:	39 5c 82 04          	cmp    %ebx,0x4(%edx,%eax,4)
 1fb:	75 f3                	jne    1f0 <map_exists+0x20>
 1fd:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
 201:	75 ed                	jne    1f0 <map_exists+0x20>
            found = 1;
 203:	b8 01 00 00 00       	mov    $0x1,%eax
            break;
        }
    }
    if (found != expected) {
 208:	3b 45 14             	cmp    0x14(%ebp),%eax
 20b:	75 0f                	jne    21c <map_exists+0x4c>
            1,
            "ERROR: expected mmap 0x%x with length 0x%x to %s in the list of maps\n",
            addr, length, expected ? "exist" : "NOT exist");
        failed();
    }
}
 20d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int found = 0;
 218:	31 c0                	xor    %eax,%eax
 21a:	eb ec                	jmp    208 <map_exists+0x38>
        printf(
 21c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 220:	ba e2 12 00 00       	mov    $0x12e2,%edx
 225:	b8 e6 12 00 00       	mov    $0x12e6,%eax
 22a:	0f 44 c2             	cmove  %edx,%eax
 22d:	83 ec 0c             	sub    $0xc,%esp
 230:	50                   	push   %eax
 231:	56                   	push   %esi
 232:	53                   	push   %ebx
 233:	68 d8 0e 00 00       	push   $0xed8
 238:	6a 01                	push   $0x1
 23a:	e8 c1 08 00 00       	call   b00 <printf>
        failed();
 23f:	83 c4 20             	add    $0x20,%esp
 242:	e8 99 fe ff ff       	call   e0 <failed>
 247:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24e:	66 90                	xchg   %ax,%ax

00000250 <get_n_validate_va2pa>:

uint get_n_validate_va2pa(uint va) {
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	83 ec 10             	sub    $0x10,%esp
 257:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
 25a:	53                   	push   %ebx
 25b:	e8 cb 07 00 00       	call   a2b <va2pa>
    if (ret == FAILED) {
 260:	83 c4 10             	add    $0x10,%esp
 263:	83 f8 ff             	cmp    $0xffffffff,%eax
 266:	74 13                	je     27b <get_n_validate_va2pa+0x2b>
        printerr("va2pa(0x%x)` failed\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
 268:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
 26e:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
 274:	77 18                	ja     28e <get_n_validate_va2pa+0x3e>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
    return pa;
}
 276:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 279:	c9                   	leave  
 27a:	c3                   	ret    
        printerr("va2pa(0x%x)` failed\n", va);
 27b:	51                   	push   %ecx
 27c:	53                   	push   %ebx
 27d:	68 20 0f 00 00       	push   $0xf20
 282:	6a 01                	push   $0x1
 284:	e8 77 08 00 00       	call   b00 <printf>
        failed();
 289:	e8 52 fe ff ff       	call   e0 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
 28e:	52                   	push   %edx
 28f:	52                   	push   %edx
 290:	68 00 00 00 0e       	push   $0xe000000
 295:	68 00 00 10 00       	push   $0x100000
 29a:	50                   	push   %eax
 29b:	53                   	push   %ebx
 29c:	68 48 0f 00 00       	push   $0xf48
 2a1:	6a 01                	push   $0x1
 2a3:	e8 58 08 00 00       	call   b00 <printf>
        failed();
 2a8:	83 c4 20             	add    $0x20,%esp
 2ab:	e8 30 fe ff ff       	call   e0 <failed>

000002b0 <map_allocated>:

void map_allocated(struct wmapinfo *info, uint addr, int length,
                   int n_loaded_pages) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
 2b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2ba:	53                   	push   %ebx
 2bb:	8b 75 10             	mov    0x10(%ebp),%esi
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
 2be:	8b 1a                	mov    (%edx),%ebx
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	7e 32                	jle    2f6 <map_allocated+0x46>
 2c4:	31 c0                	xor    %eax,%eax
 2c6:	eb 0f                	jmp    2d7 <map_allocated+0x27>
 2c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cf:	90                   	nop
 2d0:	83 c0 01             	add    $0x1,%eax
 2d3:	39 d8                	cmp    %ebx,%eax
 2d5:	74 1f                	je     2f6 <map_allocated+0x46>
        if (info->addr[i] == addr && info->length[i] == length) {
 2d7:	39 4c 82 04          	cmp    %ecx,0x4(%edx,%eax,4)
 2db:	75 f3                	jne    2d0 <map_allocated+0x20>
 2dd:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
 2e1:	75 ed                	jne    2d0 <map_allocated+0x20>
            found = 1;
            if (info->n_loaded_pages[i] != n_loaded_pages) {
 2e3:	8b 84 82 84 00 00 00 	mov    0x84(%edx,%eax,4),%eax
 2ea:	3b 45 14             	cmp    0x14(%ebp),%eax
 2ed:	75 1a                	jne    309 <map_allocated+0x59>
        printf(1,
               "Cause: expected 0x%x with length %d to exist in the list of maps\n",
               addr, length);
        failed();
    }
}
 2ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2f2:	5b                   	pop    %ebx
 2f3:	5e                   	pop    %esi
 2f4:	5d                   	pop    %ebp
 2f5:	c3                   	ret    
        printf(1,
 2f6:	56                   	push   %esi
 2f7:	51                   	push   %ecx
 2f8:	68 cc 0f 00 00       	push   $0xfcc
 2fd:	6a 01                	push   $0x1
 2ff:	e8 fc 07 00 00       	call   b00 <printf>
        failed();
 304:	e8 d7 fd ff ff       	call   e0 <failed>
                printf(1, "Cause: expected %d pages to be loaded, but found %d\n",
 309:	50                   	push   %eax
 30a:	ff 75 14             	push   0x14(%ebp)
 30d:	68 94 0f 00 00       	push   $0xf94
 312:	6a 01                	push   $0x1
 314:	e8 e7 07 00 00       	call   b00 <printf>
                failed();
 319:	e8 c2 fd ff ff       	call   e0 <failed>
 31e:	66 90                	xchg   %ax,%ax

00000320 <va_exists>:

void va_exists(uint va, int expected) {
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	83 ec 10             	sub    $0x10,%esp
 327:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
 32a:	53                   	push   %ebx
 32b:	e8 fb 06 00 00       	call   a2b <va2pa>
    if (ret == FAILED) { // va is not allocated
 330:	83 c4 10             	add    $0x10,%esp
 333:	83 f8 ff             	cmp    $0xffffffff,%eax
 336:	74 20                	je     358 <va_exists+0x38>
            failed();
        }
        return;
    }
    // va is allocated
    if (!expected) {
 338:	8b 55 0c             	mov    0xc(%ebp),%edx
 33b:	85 d2                	test   %edx,%edx
 33d:	74 55                	je     394 <va_exists+0x74>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
 33f:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
 345:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
 34b:	77 25                	ja     372 <va_exists+0x52>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
}
 34d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 350:	c9                   	leave  
 351:	c3                   	ret    
 352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (expected) {
 358:	8b 45 0c             	mov    0xc(%ebp),%eax
 35b:	85 c0                	test   %eax,%eax
 35d:	74 ee                	je     34d <va_exists+0x2d>
            printerr("expected va 0x%x to be allocated\n", va);
 35f:	51                   	push   %ecx
 360:	53                   	push   %ebx
 361:	68 10 10 00 00       	push   $0x1010
 366:	6a 01                	push   $0x1
 368:	e8 93 07 00 00       	call   b00 <printf>
            failed();
 36d:	e8 6e fd ff ff       	call   e0 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
 372:	52                   	push   %edx
 373:	52                   	push   %edx
 374:	68 00 00 00 0e       	push   $0xe000000
 379:	68 00 00 10 00       	push   $0x100000
 37e:	50                   	push   %eax
 37f:	53                   	push   %ebx
 380:	68 48 0f 00 00       	push   $0xf48
 385:	6a 01                	push   $0x1
 387:	e8 74 07 00 00       	call   b00 <printf>
        failed();
 38c:	83 c4 20             	add    $0x20,%esp
 38f:	e8 4c fd ff ff       	call   e0 <failed>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
 394:	51                   	push   %ecx
 395:	53                   	push   %ebx
 396:	68 44 10 00 00       	push   $0x1044
 39b:	6a 01                	push   $0x1
 39d:	e8 5e 07 00 00       	call   b00 <printf>
        failed();
 3a2:	e8 39 fd ff ff       	call   e0 <failed>
 3a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <no_mmaps_in_pgdir>:

void no_mmaps_in_pgdir() {
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
 3b4:	bb 00 00 00 60       	mov    $0x60000000,%ebx
void no_mmaps_in_pgdir() {
 3b9:	83 ec 04             	sub    $0x4,%esp
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int pa = va2pa(va);
 3c0:	83 ec 0c             	sub    $0xc,%esp
 3c3:	53                   	push   %ebx
 3c4:	e8 62 06 00 00       	call   a2b <va2pa>
        if (pa != FAILED) {
 3c9:	83 c4 10             	add    $0x10,%esp
 3cc:	83 f8 ff             	cmp    $0xffffffff,%eax
 3cf:	75 0d                	jne    3de <no_mmaps_in_pgdir+0x2e>
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
 3d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
 3d7:	79 e7                	jns    3c0 <no_mmaps_in_pgdir+0x10>
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
            failed();
        }
    }
}
 3d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3dc:	c9                   	leave  
 3dd:	c3                   	ret    
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
 3de:	50                   	push   %eax
 3df:	53                   	push   %ebx
 3e0:	68 88 10 00 00       	push   $0x1088
 3e5:	6a 01                	push   $0x1
 3e7:	e8 14 07 00 00       	call   b00 <printf>
            failed();
 3ec:	e8 ef fc ff ff       	call   e0 <failed>
 3f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ff:	90                   	nop

00000400 <validate_initial_state>:

void validate_initial_state() {
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	81 ec e0 00 00 00    	sub    $0xe0,%esp
    struct wmapinfo winfo;
    get_n_validate_wmap_info(&winfo, 0); // no maps exist
 409:	8d 85 34 ff ff ff    	lea    -0xcc(%ebp),%eax
 40f:	6a 00                	push   $0x0
 411:	50                   	push   %eax
 412:	e8 39 fd ff ff       	call   150 <get_n_validate_wmap_info>
    // no_mmaps_in_pgdir();                 // no maps in the mmap range in pgdir
    printf(1, "INFO: Initially 0 maps. \tOkay.\n");
 417:	58                   	pop    %eax
 418:	5a                   	pop    %edx
 419:	68 c8 10 00 00       	push   $0x10c8
 41e:	6a 01                	push   $0x1
 420:	e8 db 06 00 00       	call   b00 <printf>
}
 425:	83 c4 10             	add    $0x10,%esp
 428:	c9                   	leave  
 429:	c3                   	ret    
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <check_overlaps>:

void check_overlaps(uint *maps, uint *lengths, int n) {
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	83 ec 1c             	sub    $0x1c,%esp
 439:	8b 7d 10             	mov    0x10(%ebp),%edi
    for (int i = 0; i < n; i++) {
 43c:	85 ff                	test   %edi,%edi
 43e:	7e 55                	jle    495 <check_overlaps+0x65>
 440:	8b 75 08             	mov    0x8(%ebp),%esi
 443:	31 db                	xor    %ebx,%ebx
 445:	8d 76 00             	lea    0x0(%esi),%esi
        for (int j = 0; j < n; j++) {
 448:	89 75 e4             	mov    %esi,-0x1c(%ebp)
 44b:	31 c0                	xor    %eax,%eax
 44d:	89 7d 10             	mov    %edi,0x10(%ebp)
 450:	eb 08                	jmp    45a <check_overlaps+0x2a>
 452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 458:	89 d0                	mov    %edx,%eax
            if (i == j)
 45a:	39 d8                	cmp    %ebx,%eax
 45c:	74 1b                	je     479 <check_overlaps+0x49>
                continue;
            if (maps[i] >= maps[j] && maps[i] < maps[j] + lengths[j]) {
 45e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
 461:	8b 4d 08             	mov    0x8(%ebp),%ecx
 464:	8b 17                	mov    (%edi),%edx
 466:	8b 0c 81             	mov    (%ecx,%eax,4),%ecx
 469:	39 ca                	cmp    %ecx,%edx
 46b:	72 0c                	jb     479 <check_overlaps+0x49>
 46d:	8b 7d 0c             	mov    0xc(%ebp),%edi
 470:	8b 34 87             	mov    (%edi,%eax,4),%esi
 473:	01 ce                	add    %ecx,%esi
 475:	39 f2                	cmp    %esi,%edx
 477:	72 24                	jb     49d <check_overlaps+0x6d>
        for (int j = 0; j < n; j++) {
 479:	8d 50 01             	lea    0x1(%eax),%edx
 47c:	39 55 10             	cmp    %edx,0x10(%ebp)
 47f:	75 d7                	jne    458 <check_overlaps+0x28>
    for (int i = 0; i < n; i++) {
 481:	8b 75 e4             	mov    -0x1c(%ebp),%esi
 484:	8b 7d 10             	mov    0x10(%ebp),%edi
 487:	8d 53 01             	lea    0x1(%ebx),%edx
 48a:	83 c6 04             	add    $0x4,%esi
 48d:	39 d8                	cmp    %ebx,%eax
 48f:	74 04                	je     495 <check_overlaps+0x65>
 491:	89 d3                	mov    %edx,%ebx
 493:	eb b3                	jmp    448 <check_overlaps+0x18>
                         maps[j]);
                failed();
            }
        }
    }
}
 495:	8d 65 f4             	lea    -0xc(%ebp),%esp
 498:	5b                   	pop    %ebx
 499:	5e                   	pop    %esi
 49a:	5f                   	pop    %edi
 49b:	5d                   	pop    %ebp
 49c:	c3                   	ret    
                printerr("Map (addr 0x%x) overlaps with Map (addr 0x%x)\n", maps[i],
 49d:	51                   	push   %ecx
 49e:	52                   	push   %edx
 49f:	68 e8 10 00 00       	push   $0x10e8
 4a4:	6a 01                	push   $0x1
 4a6:	e8 55 06 00 00       	call   b00 <printf>
                failed();
 4ab:	e8 30 fc ff ff       	call   e0 <failed>

000004b0 <create_small_file>:

/**
 * Create a small file with 512 bytes of content
 */
int create_small_file(char *filename, char c) {
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 0c             	sub    $0xc,%esp
 4b9:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
    // create a file
    int bufflen = 512;
    char buff[bufflen];
 4bd:	89 e0                	mov    %esp,%eax
 4bf:	39 c4                	cmp    %eax,%esp
 4c1:	74 12                	je     4d5 <create_small_file+0x25>
 4c3:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 4c9:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 4d0:	00 
 4d1:	39 c4                	cmp    %eax,%esp
 4d3:	75 ee                	jne    4c3 <create_small_file+0x13>
 4d5:	81 ec 00 02 00 00    	sub    $0x200,%esp
 4db:	83 8c 24 fc 01 00 00 	orl    $0x0,0x1fc(%esp)
 4e2:	00 
 4e3:	89 e7                	mov    %esp,%edi
    int fd = open(filename, O_CREATE | O_RDWR);
 4e5:	83 ec 08             	sub    $0x8,%esp
 4e8:	68 02 02 00 00       	push   $0x202
 4ed:	ff 75 08             	push   0x8(%ebp)
 4f0:	e8 ce 04 00 00       	call   9c3 <open>
    if (fd < 0) {
 4f5:	89 fc                	mov    %edi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
 4f7:	89 c6                	mov    %eax,%esi
    if (fd < 0) {
 4f9:	85 c0                	test   %eax,%eax
 4fb:	78 57                	js     554 <create_small_file+0xa4>
 4fd:	89 f8                	mov    %edi,%eax
 4ff:	8d 8f 00 02 00 00    	lea    0x200(%edi),%ecx
 505:	8d 76 00             	lea    0x0(%esi),%esi
        printerr("Failed to create file %s\n", filename);
        failed();
    }
    // prepare the content to write
    for (int j = 0; j < bufflen; j++) {
        buff[j] = c;
 508:	88 18                	mov    %bl,(%eax)
    for (int j = 0; j < bufflen; j++) {
 50a:	83 c0 01             	add    $0x1,%eax
 50d:	39 c8                	cmp    %ecx,%eax
 50f:	75 f7                	jne    508 <create_small_file+0x58>
    }
    // write to file
    if (write(fd, buff, bufflen) != bufflen) {
 511:	83 ec 04             	sub    $0x4,%esp
 514:	68 00 02 00 00       	push   $0x200
 519:	57                   	push   %edi
 51a:	56                   	push   %esi
 51b:	e8 83 04 00 00       	call   9a3 <write>
 520:	83 c4 10             	add    $0x10,%esp
 523:	3d 00 02 00 00       	cmp    $0x200,%eax
 528:	75 3f                	jne    569 <create_small_file+0xb9>
        printerr("Write to file FAILED\n");
        failed();
    }
    close(fd);
 52a:	83 ec 0c             	sub    $0xc,%esp
 52d:	56                   	push   %esi
 52e:	e8 78 04 00 00       	call   9ab <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
 533:	68 00 02 00 00       	push   $0x200
 538:	ff 75 08             	push   0x8(%ebp)
 53b:	68 80 11 00 00       	push   $0x1180
 540:	6a 01                	push   $0x1
 542:	e8 b9 05 00 00       	call   b00 <printf>
           bufflen);
    return bufflen;
}
 547:	8d 65 f4             	lea    -0xc(%ebp),%esp
 54a:	b8 00 02 00 00       	mov    $0x200,%eax
 54f:	5b                   	pop    %ebx
 550:	5e                   	pop    %esi
 551:	5f                   	pop    %edi
 552:	5d                   	pop    %ebp
 553:	c3                   	ret    
        printerr("Failed to create file %s\n", filename);
 554:	52                   	push   %edx
 555:	ff 75 08             	push   0x8(%ebp)
 558:	68 2c 11 00 00       	push   $0x112c
 55d:	6a 01                	push   $0x1
 55f:	e8 9c 05 00 00       	call   b00 <printf>
        failed();
 564:	e8 77 fb ff ff       	call   e0 <failed>
        printerr("Write to file FAILED\n");
 569:	50                   	push   %eax
 56a:	50                   	push   %eax
 56b:	68 58 11 00 00       	push   $0x1158
 570:	6a 01                	push   $0x1
 572:	e8 89 05 00 00       	call   b00 <printf>
        failed();
 577:	e8 64 fb ff ff       	call   e0 <failed>
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000580 <create_big_file>:

int create_big_file(char *filename, int N_PAGES, char c) {
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
 586:	83 ec 1c             	sub    $0x1c,%esp
 589:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
 58d:	88 45 df             	mov    %al,-0x21(%ebp)
    // create a file
    int bufflen = 1024;
    char buff[bufflen];
 590:	89 e0                	mov    %esp,%eax
 592:	39 c4                	cmp    %eax,%esp
 594:	74 12                	je     5a8 <create_big_file+0x28>
 596:	81 ec 00 10 00 00    	sub    $0x1000,%esp
 59c:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
 5a3:	00 
 5a4:	39 c4                	cmp    %eax,%esp
 5a6:	75 ee                	jne    596 <create_big_file+0x16>
 5a8:	81 ec 00 04 00 00    	sub    $0x400,%esp
 5ae:	83 8c 24 fc 03 00 00 	orl    $0x0,0x3fc(%esp)
 5b5:	00 
 5b6:	89 e6                	mov    %esp,%esi
    int fd = open(filename, O_CREATE | O_RDWR);
 5b8:	83 ec 08             	sub    $0x8,%esp
 5bb:	68 02 02 00 00       	push   $0x202
 5c0:	ff 75 08             	push   0x8(%ebp)
 5c3:	e8 fb 03 00 00       	call   9c3 <open>
    if (fd < 0) {
 5c8:	89 f4                	mov    %esi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
 5ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if (fd < 0) {
 5cd:	85 c0                	test   %eax,%eax
 5cf:	0f 88 a0 00 00 00    	js     675 <create_big_file+0xf5>
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
        failed();
    }
    // write in steps as we cannot have a buffer larger than PGSIZE
    for (int pg = 0; pg < N_PAGES; pg++) {
 5d5:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 5df:	8d be 00 04 00 00    	lea    0x400(%esi),%edi
 5e5:	85 d2                	test   %edx,%edx
 5e7:	7e 61                	jle    64a <create_big_file+0xca>
 5e9:	0f b6 5d df          	movzbl -0x21(%ebp),%ebx
 5ed:	02 5d e4             	add    -0x1c(%ebp),%bl
        printf(1, "INFO: %d\n", c);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	0f be c3             	movsbl %bl,%eax
 5f6:	50                   	push   %eax
 5f7:	68 ec 12 00 00       	push   $0x12ec
 5fc:	6a 01                	push   $0x1
 5fe:	e8 fd 04 00 00       	call   b00 <printf>
        int nchunks = PGSIZE / bufflen;
        for (int i = 0; i < bufflen; i++)
 603:	89 f0                	mov    %esi,%eax
 605:	83 c4 10             	add    $0x10,%esp
 608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop
            buff[i] = c;
 610:	88 18                	mov    %bl,(%eax)
        for (int i = 0; i < bufflen; i++)
 612:	83 c0 01             	add    $0x1,%eax
 615:	39 c7                	cmp    %eax,%edi
 617:	75 f7                	jne    610 <create_big_file+0x90>
 619:	bb 04 00 00 00       	mov    $0x4,%ebx
        for (int k = 0; k < nchunks; k++) {
            // write to file
            if (write(fd, buff, bufflen) != bufflen) {
 61e:	83 ec 04             	sub    $0x4,%esp
 621:	68 00 04 00 00       	push   $0x400
 626:	56                   	push   %esi
 627:	ff 75 e0             	push   -0x20(%ebp)
 62a:	e8 74 03 00 00       	call   9a3 <write>
 62f:	83 c4 10             	add    $0x10,%esp
 632:	3d 00 04 00 00       	cmp    $0x400,%eax
 637:	75 57                	jne    690 <create_big_file+0x110>
        for (int k = 0; k < nchunks; k++) {
 639:	83 eb 01             	sub    $0x1,%ebx
 63c:	75 e0                	jne    61e <create_big_file+0x9e>
    for (int pg = 0; pg < N_PAGES; pg++) {
 63e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 642:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 645:	39 45 0c             	cmp    %eax,0xc(%ebp)
 648:	75 9f                	jne    5e9 <create_big_file+0x69>
                failed();
            }
        }
        c++;
    }
    close(fd);
 64a:	83 ec 0c             	sub    $0xc,%esp
 64d:	ff 75 e0             	push   -0x20(%ebp)
 650:	e8 56 03 00 00       	call   9ab <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
 655:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 658:	c1 e3 0c             	shl    $0xc,%ebx
 65b:	53                   	push   %ebx
 65c:	ff 75 08             	push   0x8(%ebp)
 65f:	68 80 11 00 00       	push   $0x1180
 664:	6a 01                	push   $0x1
 666:	e8 95 04 00 00       	call   b00 <printf>
           N_PAGES * PGSIZE);
    return N_PAGES * PGSIZE;
}
 66b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 66e:	89 d8                	mov    %ebx,%eax
 670:	5b                   	pop    %ebx
 671:	5e                   	pop    %esi
 672:	5f                   	pop    %edi
 673:	5d                   	pop    %ebp
 674:	c3                   	ret    
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
 675:	50                   	push   %eax
 676:	ff 75 08             	push   0x8(%ebp)
 679:	68 b4 11 00 00       	push   $0x11b4
 67e:	6a 01                	push   $0x1
 680:	e8 7b 04 00 00       	call   b00 <printf>
        failed();
 685:	e8 56 fa ff ff       	call   e0 <failed>
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                printerr("Write to file FAILED %d\n", pg * bufflen);
 690:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 693:	83 ec 04             	sub    $0x4,%esp
 696:	c1 e0 0a             	shl    $0xa,%eax
 699:	50                   	push   %eax
 69a:	68 d8 11 00 00       	push   $0x11d8
 69f:	6a 01                	push   $0x1
 6a1:	e8 5a 04 00 00       	call   b00 <printf>
                failed();
 6a6:	e8 35 fa ff ff       	call   e0 <failed>
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop

000006b0 <open_file>:

int open_file(char *filename, int filelength) {
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	56                   	push   %esi
 6b4:	53                   	push   %ebx
 6b5:	83 ec 28             	sub    $0x28,%esp
 6b8:	8b 75 08             	mov    0x8(%ebp),%esi
    int fd = open(filename, O_RDWR); // open in read-write mode
 6bb:	6a 02                	push   $0x2
 6bd:	56                   	push   %esi
 6be:	e8 00 03 00 00       	call   9c3 <open>
    if (fd < 0) {
 6c3:	83 c4 10             	add    $0x10,%esp
 6c6:	85 c0                	test   %eax,%eax
 6c8:	78 27                	js     6f1 <open_file+0x41>
        printerr("Failed to open file %s\n", filename);
        failed();
    }
    struct stat st;
    if (fstat(fd, &st) < 0) {
 6ca:	83 ec 08             	sub    $0x8,%esp
 6cd:	89 c3                	mov    %eax,%ebx
 6cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6d2:	50                   	push   %eax
 6d3:	53                   	push   %ebx
 6d4:	e8 02 03 00 00       	call   9db <fstat>
 6d9:	83 c4 10             	add    $0x10,%esp
 6dc:	85 c0                	test   %eax,%eax
 6de:	78 39                	js     719 <open_file+0x69>
        printerr("Failed to get file stat\n");
        failed();
    }
    if (st.size != filelength) {
 6e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 6e6:	75 1c                	jne    704 <open_file+0x54>
        printerr("File size = %d, expected %d\n", st.size, filelength);
        failed();
    }
    return fd;
}
 6e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6eb:	89 d8                	mov    %ebx,%eax
 6ed:	5b                   	pop    %ebx
 6ee:	5e                   	pop    %esi
 6ef:	5d                   	pop    %ebp
 6f0:	c3                   	ret    
        printerr("Failed to open file %s\n", filename);
 6f1:	52                   	push   %edx
 6f2:	56                   	push   %esi
 6f3:	68 04 12 00 00       	push   $0x1204
 6f8:	6a 01                	push   $0x1
 6fa:	e8 01 04 00 00       	call   b00 <printf>
        failed();
 6ff:	e8 dc f9 ff ff       	call   e0 <failed>
        printerr("File size = %d, expected %d\n", st.size, filelength);
 704:	ff 75 0c             	push   0xc(%ebp)
 707:	50                   	push   %eax
 708:	68 5c 12 00 00       	push   $0x125c
 70d:	6a 01                	push   $0x1
 70f:	e8 ec 03 00 00       	call   b00 <printf>
        failed();
 714:	e8 c7 f9 ff ff       	call   e0 <failed>
        printerr("Failed to get file stat\n");
 719:	50                   	push   %eax
 71a:	50                   	push   %eax
 71b:	68 30 12 00 00       	push   $0x1230
 720:	6a 01                	push   $0x1
 722:	e8 d9 03 00 00       	call   b00 <printf>
        failed();
 727:	e8 b4 f9 ff ff       	call   e0 <failed>
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 730:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 731:	31 c0                	xor    %eax,%eax
{
 733:	89 e5                	mov    %esp,%ebp
 735:	53                   	push   %ebx
 736:	8b 4d 08             	mov    0x8(%ebp),%ecx
 739:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 740:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 744:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 747:	83 c0 01             	add    $0x1,%eax
 74a:	84 d2                	test   %dl,%dl
 74c:	75 f2                	jne    740 <strcpy+0x10>
    ;
  return os;
}
 74e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 751:	89 c8                	mov    %ecx,%eax
 753:	c9                   	leave  
 754:	c3                   	ret    
 755:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000760 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	53                   	push   %ebx
 764:	8b 55 08             	mov    0x8(%ebp),%edx
 767:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 76a:	0f b6 02             	movzbl (%edx),%eax
 76d:	84 c0                	test   %al,%al
 76f:	75 17                	jne    788 <strcmp+0x28>
 771:	eb 3a                	jmp    7ad <strcmp+0x4d>
 773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 777:	90                   	nop
 778:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 77c:	83 c2 01             	add    $0x1,%edx
 77f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 782:	84 c0                	test   %al,%al
 784:	74 1a                	je     7a0 <strcmp+0x40>
    p++, q++;
 786:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 788:	0f b6 19             	movzbl (%ecx),%ebx
 78b:	38 c3                	cmp    %al,%bl
 78d:	74 e9                	je     778 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 78f:	29 d8                	sub    %ebx,%eax
}
 791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 794:	c9                   	leave  
 795:	c3                   	ret    
 796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 7a0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 7a4:	31 c0                	xor    %eax,%eax
 7a6:	29 d8                	sub    %ebx,%eax
}
 7a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7ab:	c9                   	leave  
 7ac:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 7ad:	0f b6 19             	movzbl (%ecx),%ebx
 7b0:	31 c0                	xor    %eax,%eax
 7b2:	eb db                	jmp    78f <strcmp+0x2f>
 7b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7bf:	90                   	nop

000007c0 <strlen>:

uint
strlen(const char *s)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 7c6:	80 3a 00             	cmpb   $0x0,(%edx)
 7c9:	74 15                	je     7e0 <strlen+0x20>
 7cb:	31 c0                	xor    %eax,%eax
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
 7d0:	83 c0 01             	add    $0x1,%eax
 7d3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 7d7:	89 c1                	mov    %eax,%ecx
 7d9:	75 f5                	jne    7d0 <strlen+0x10>
    ;
  return n;
}
 7db:	89 c8                	mov    %ecx,%eax
 7dd:	5d                   	pop    %ebp
 7de:	c3                   	ret    
 7df:	90                   	nop
  for(n = 0; s[n]; n++)
 7e0:	31 c9                	xor    %ecx,%ecx
}
 7e2:	5d                   	pop    %ebp
 7e3:	89 c8                	mov    %ecx,%eax
 7e5:	c3                   	ret    
 7e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ed:	8d 76 00             	lea    0x0(%esi),%esi

000007f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 7f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 7fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 7fd:	89 d7                	mov    %edx,%edi
 7ff:	fc                   	cld    
 800:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 802:	8b 7d fc             	mov    -0x4(%ebp),%edi
 805:	89 d0                	mov    %edx,%eax
 807:	c9                   	leave  
 808:	c3                   	ret    
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000810 <strchr>:

char*
strchr(const char *s, char c)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	8b 45 08             	mov    0x8(%ebp),%eax
 816:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 81a:	0f b6 10             	movzbl (%eax),%edx
 81d:	84 d2                	test   %dl,%dl
 81f:	75 12                	jne    833 <strchr+0x23>
 821:	eb 1d                	jmp    840 <strchr+0x30>
 823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 827:	90                   	nop
 828:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 82c:	83 c0 01             	add    $0x1,%eax
 82f:	84 d2                	test   %dl,%dl
 831:	74 0d                	je     840 <strchr+0x30>
    if(*s == c)
 833:	38 d1                	cmp    %dl,%cl
 835:	75 f1                	jne    828 <strchr+0x18>
      return (char*)s;
  return 0;
}
 837:	5d                   	pop    %ebp
 838:	c3                   	ret    
 839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 840:	31 c0                	xor    %eax,%eax
}
 842:	5d                   	pop    %ebp
 843:	c3                   	ret    
 844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 84f:	90                   	nop

00000850 <gets>:

char*
gets(char *buf, int max)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	57                   	push   %edi
 854:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 855:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 858:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 859:	31 db                	xor    %ebx,%ebx
{
 85b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 85e:	eb 27                	jmp    887 <gets+0x37>
    cc = read(0, &c, 1);
 860:	83 ec 04             	sub    $0x4,%esp
 863:	6a 01                	push   $0x1
 865:	57                   	push   %edi
 866:	6a 00                	push   $0x0
 868:	e8 2e 01 00 00       	call   99b <read>
    if(cc < 1)
 86d:	83 c4 10             	add    $0x10,%esp
 870:	85 c0                	test   %eax,%eax
 872:	7e 1d                	jle    891 <gets+0x41>
      break;
    buf[i++] = c;
 874:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 878:	8b 55 08             	mov    0x8(%ebp),%edx
 87b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 87f:	3c 0a                	cmp    $0xa,%al
 881:	74 1d                	je     8a0 <gets+0x50>
 883:	3c 0d                	cmp    $0xd,%al
 885:	74 19                	je     8a0 <gets+0x50>
  for(i=0; i+1 < max; ){
 887:	89 de                	mov    %ebx,%esi
 889:	83 c3 01             	add    $0x1,%ebx
 88c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 88f:	7c cf                	jl     860 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 891:	8b 45 08             	mov    0x8(%ebp),%eax
 894:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 898:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89b:	5b                   	pop    %ebx
 89c:	5e                   	pop    %esi
 89d:	5f                   	pop    %edi
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret    
  buf[i] = '\0';
 8a0:	8b 45 08             	mov    0x8(%ebp),%eax
 8a3:	89 de                	mov    %ebx,%esi
 8a5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 8a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ac:	5b                   	pop    %ebx
 8ad:	5e                   	pop    %esi
 8ae:	5f                   	pop    %edi
 8af:	5d                   	pop    %ebp
 8b0:	c3                   	ret    
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop

000008c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	56                   	push   %esi
 8c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 8c5:	83 ec 08             	sub    $0x8,%esp
 8c8:	6a 00                	push   $0x0
 8ca:	ff 75 08             	push   0x8(%ebp)
 8cd:	e8 f1 00 00 00       	call   9c3 <open>
  if(fd < 0)
 8d2:	83 c4 10             	add    $0x10,%esp
 8d5:	85 c0                	test   %eax,%eax
 8d7:	78 27                	js     900 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 8d9:	83 ec 08             	sub    $0x8,%esp
 8dc:	ff 75 0c             	push   0xc(%ebp)
 8df:	89 c3                	mov    %eax,%ebx
 8e1:	50                   	push   %eax
 8e2:	e8 f4 00 00 00       	call   9db <fstat>
  close(fd);
 8e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 8ea:	89 c6                	mov    %eax,%esi
  close(fd);
 8ec:	e8 ba 00 00 00       	call   9ab <close>
  return r;
 8f1:	83 c4 10             	add    $0x10,%esp
}
 8f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 8f7:	89 f0                	mov    %esi,%eax
 8f9:	5b                   	pop    %ebx
 8fa:	5e                   	pop    %esi
 8fb:	5d                   	pop    %ebp
 8fc:	c3                   	ret    
 8fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 900:	be ff ff ff ff       	mov    $0xffffffff,%esi
 905:	eb ed                	jmp    8f4 <stat+0x34>
 907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 90e:	66 90                	xchg   %ax,%ax

00000910 <atoi>:

int
atoi(const char *s)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	53                   	push   %ebx
 914:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 917:	0f be 02             	movsbl (%edx),%eax
 91a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 91d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 920:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 925:	77 1e                	ja     945 <atoi+0x35>
 927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 92e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 930:	83 c2 01             	add    $0x1,%edx
 933:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 936:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 93a:	0f be 02             	movsbl (%edx),%eax
 93d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 940:	80 fb 09             	cmp    $0x9,%bl
 943:	76 eb                	jbe    930 <atoi+0x20>
  return n;
}
 945:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 948:	89 c8                	mov    %ecx,%eax
 94a:	c9                   	leave  
 94b:	c3                   	ret    
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000950 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	57                   	push   %edi
 954:	8b 45 10             	mov    0x10(%ebp),%eax
 957:	8b 55 08             	mov    0x8(%ebp),%edx
 95a:	56                   	push   %esi
 95b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 95e:	85 c0                	test   %eax,%eax
 960:	7e 13                	jle    975 <memmove+0x25>
 962:	01 d0                	add    %edx,%eax
  dst = vdst;
 964:	89 d7                	mov    %edx,%edi
 966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 96d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 970:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 971:	39 f8                	cmp    %edi,%eax
 973:	75 fb                	jne    970 <memmove+0x20>
  return vdst;
}
 975:	5e                   	pop    %esi
 976:	89 d0                	mov    %edx,%eax
 978:	5f                   	pop    %edi
 979:	5d                   	pop    %ebp
 97a:	c3                   	ret    

0000097b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 97b:	b8 01 00 00 00       	mov    $0x1,%eax
 980:	cd 40                	int    $0x40
 982:	c3                   	ret    

00000983 <exit>:
SYSCALL(exit)
 983:	b8 02 00 00 00       	mov    $0x2,%eax
 988:	cd 40                	int    $0x40
 98a:	c3                   	ret    

0000098b <wait>:
SYSCALL(wait)
 98b:	b8 03 00 00 00       	mov    $0x3,%eax
 990:	cd 40                	int    $0x40
 992:	c3                   	ret    

00000993 <pipe>:
SYSCALL(pipe)
 993:	b8 04 00 00 00       	mov    $0x4,%eax
 998:	cd 40                	int    $0x40
 99a:	c3                   	ret    

0000099b <read>:
SYSCALL(read)
 99b:	b8 05 00 00 00       	mov    $0x5,%eax
 9a0:	cd 40                	int    $0x40
 9a2:	c3                   	ret    

000009a3 <write>:
SYSCALL(write)
 9a3:	b8 10 00 00 00       	mov    $0x10,%eax
 9a8:	cd 40                	int    $0x40
 9aa:	c3                   	ret    

000009ab <close>:
SYSCALL(close)
 9ab:	b8 15 00 00 00       	mov    $0x15,%eax
 9b0:	cd 40                	int    $0x40
 9b2:	c3                   	ret    

000009b3 <kill>:
SYSCALL(kill)
 9b3:	b8 06 00 00 00       	mov    $0x6,%eax
 9b8:	cd 40                	int    $0x40
 9ba:	c3                   	ret    

000009bb <exec>:
SYSCALL(exec)
 9bb:	b8 07 00 00 00       	mov    $0x7,%eax
 9c0:	cd 40                	int    $0x40
 9c2:	c3                   	ret    

000009c3 <open>:
SYSCALL(open)
 9c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 9c8:	cd 40                	int    $0x40
 9ca:	c3                   	ret    

000009cb <mknod>:
SYSCALL(mknod)
 9cb:	b8 11 00 00 00       	mov    $0x11,%eax
 9d0:	cd 40                	int    $0x40
 9d2:	c3                   	ret    

000009d3 <unlink>:
SYSCALL(unlink)
 9d3:	b8 12 00 00 00       	mov    $0x12,%eax
 9d8:	cd 40                	int    $0x40
 9da:	c3                   	ret    

000009db <fstat>:
SYSCALL(fstat)
 9db:	b8 08 00 00 00       	mov    $0x8,%eax
 9e0:	cd 40                	int    $0x40
 9e2:	c3                   	ret    

000009e3 <link>:
SYSCALL(link)
 9e3:	b8 13 00 00 00       	mov    $0x13,%eax
 9e8:	cd 40                	int    $0x40
 9ea:	c3                   	ret    

000009eb <mkdir>:
SYSCALL(mkdir)
 9eb:	b8 14 00 00 00       	mov    $0x14,%eax
 9f0:	cd 40                	int    $0x40
 9f2:	c3                   	ret    

000009f3 <chdir>:
SYSCALL(chdir)
 9f3:	b8 09 00 00 00       	mov    $0x9,%eax
 9f8:	cd 40                	int    $0x40
 9fa:	c3                   	ret    

000009fb <dup>:
SYSCALL(dup)
 9fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 a00:	cd 40                	int    $0x40
 a02:	c3                   	ret    

00000a03 <getpid>:
SYSCALL(getpid)
 a03:	b8 0b 00 00 00       	mov    $0xb,%eax
 a08:	cd 40                	int    $0x40
 a0a:	c3                   	ret    

00000a0b <sbrk>:
SYSCALL(sbrk)
 a0b:	b8 0c 00 00 00       	mov    $0xc,%eax
 a10:	cd 40                	int    $0x40
 a12:	c3                   	ret    

00000a13 <sleep>:
SYSCALL(sleep)
 a13:	b8 0d 00 00 00       	mov    $0xd,%eax
 a18:	cd 40                	int    $0x40
 a1a:	c3                   	ret    

00000a1b <uptime>:
SYSCALL(uptime)
 a1b:	b8 0e 00 00 00       	mov    $0xe,%eax
 a20:	cd 40                	int    $0x40
 a22:	c3                   	ret    

00000a23 <wmap>:
SYSCALL(wmap)
 a23:	b8 16 00 00 00       	mov    $0x16,%eax
 a28:	cd 40                	int    $0x40
 a2a:	c3                   	ret    

00000a2b <va2pa>:
SYSCALL(va2pa)
 a2b:	b8 17 00 00 00       	mov    $0x17,%eax
 a30:	cd 40                	int    $0x40
 a32:	c3                   	ret    

00000a33 <wunmap>:
SYSCALL(wunmap)
 a33:	b8 18 00 00 00       	mov    $0x18,%eax
 a38:	cd 40                	int    $0x40
 a3a:	c3                   	ret    

00000a3b <getwmapinfo>:
SYSCALL(getwmapinfo)
 a3b:	b8 19 00 00 00       	mov    $0x19,%eax
 a40:	cd 40                	int    $0x40
 a42:	c3                   	ret    
 a43:	66 90                	xchg   %ax,%ax
 a45:	66 90                	xchg   %ax,%ax
 a47:	66 90                	xchg   %ax,%ax
 a49:	66 90                	xchg   %ax,%ax
 a4b:	66 90                	xchg   %ax,%ax
 a4d:	66 90                	xchg   %ax,%ax
 a4f:	90                   	nop

00000a50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 3c             	sub    $0x3c,%esp
 a59:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 a5c:	89 d1                	mov    %edx,%ecx
{
 a5e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 a61:	85 d2                	test   %edx,%edx
 a63:	0f 89 7f 00 00 00    	jns    ae8 <printint+0x98>
 a69:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 a6d:	74 79                	je     ae8 <printint+0x98>
    neg = 1;
 a6f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 a76:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 a78:	31 db                	xor    %ebx,%ebx
 a7a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 a7d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 a80:	89 c8                	mov    %ecx,%eax
 a82:	31 d2                	xor    %edx,%edx
 a84:	89 cf                	mov    %ecx,%edi
 a86:	f7 75 c4             	divl   -0x3c(%ebp)
 a89:	0f b6 92 6c 13 00 00 	movzbl 0x136c(%edx),%edx
 a90:	89 45 c0             	mov    %eax,-0x40(%ebp)
 a93:	89 d8                	mov    %ebx,%eax
 a95:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 a98:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 a9b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 a9e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 aa1:	76 dd                	jbe    a80 <printint+0x30>
  if(neg)
 aa3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 aa6:	85 c9                	test   %ecx,%ecx
 aa8:	74 0c                	je     ab6 <printint+0x66>
    buf[i++] = '-';
 aaa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 aaf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 ab1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 ab6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 ab9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 abd:	eb 07                	jmp    ac6 <printint+0x76>
 abf:	90                   	nop
    putc(fd, buf[i]);
 ac0:	0f b6 13             	movzbl (%ebx),%edx
 ac3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 ac6:	83 ec 04             	sub    $0x4,%esp
 ac9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 acc:	6a 01                	push   $0x1
 ace:	56                   	push   %esi
 acf:	57                   	push   %edi
 ad0:	e8 ce fe ff ff       	call   9a3 <write>
  while(--i >= 0)
 ad5:	83 c4 10             	add    $0x10,%esp
 ad8:	39 de                	cmp    %ebx,%esi
 ada:	75 e4                	jne    ac0 <printint+0x70>
}
 adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 adf:	5b                   	pop    %ebx
 ae0:	5e                   	pop    %esi
 ae1:	5f                   	pop    %edi
 ae2:	5d                   	pop    %ebp
 ae3:	c3                   	ret    
 ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 ae8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 aef:	eb 87                	jmp    a78 <printint+0x28>
 af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 aff:	90                   	nop

00000b00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	57                   	push   %edi
 b04:	56                   	push   %esi
 b05:	53                   	push   %ebx
 b06:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 b09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 b0c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 b0f:	0f b6 13             	movzbl (%ebx),%edx
 b12:	84 d2                	test   %dl,%dl
 b14:	74 6a                	je     b80 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 b16:	8d 45 10             	lea    0x10(%ebp),%eax
 b19:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 b1c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 b1f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 b21:	89 45 d0             	mov    %eax,-0x30(%ebp)
 b24:	eb 36                	jmp    b5c <printf+0x5c>
 b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b2d:	8d 76 00             	lea    0x0(%esi),%esi
 b30:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 b33:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 b38:	83 f8 25             	cmp    $0x25,%eax
 b3b:	74 15                	je     b52 <printf+0x52>
  write(fd, &c, 1);
 b3d:	83 ec 04             	sub    $0x4,%esp
 b40:	88 55 e7             	mov    %dl,-0x19(%ebp)
 b43:	6a 01                	push   $0x1
 b45:	57                   	push   %edi
 b46:	56                   	push   %esi
 b47:	e8 57 fe ff ff       	call   9a3 <write>
 b4c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 b4f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 b52:	0f b6 13             	movzbl (%ebx),%edx
 b55:	83 c3 01             	add    $0x1,%ebx
 b58:	84 d2                	test   %dl,%dl
 b5a:	74 24                	je     b80 <printf+0x80>
    c = fmt[i] & 0xff;
 b5c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 b5f:	85 c9                	test   %ecx,%ecx
 b61:	74 cd                	je     b30 <printf+0x30>
      }
    } else if(state == '%'){
 b63:	83 f9 25             	cmp    $0x25,%ecx
 b66:	75 ea                	jne    b52 <printf+0x52>
      if(c == 'd'){
 b68:	83 f8 25             	cmp    $0x25,%eax
 b6b:	0f 84 07 01 00 00    	je     c78 <printf+0x178>
 b71:	83 e8 63             	sub    $0x63,%eax
 b74:	83 f8 15             	cmp    $0x15,%eax
 b77:	77 17                	ja     b90 <printf+0x90>
 b79:	ff 24 85 14 13 00 00 	jmp    *0x1314(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 b80:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b83:	5b                   	pop    %ebx
 b84:	5e                   	pop    %esi
 b85:	5f                   	pop    %edi
 b86:	5d                   	pop    %ebp
 b87:	c3                   	ret    
 b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b8f:	90                   	nop
  write(fd, &c, 1);
 b90:	83 ec 04             	sub    $0x4,%esp
 b93:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 b96:	6a 01                	push   $0x1
 b98:	57                   	push   %edi
 b99:	56                   	push   %esi
 b9a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 b9e:	e8 00 fe ff ff       	call   9a3 <write>
        putc(fd, c);
 ba3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 ba7:	83 c4 0c             	add    $0xc,%esp
 baa:	88 55 e7             	mov    %dl,-0x19(%ebp)
 bad:	6a 01                	push   $0x1
 baf:	57                   	push   %edi
 bb0:	56                   	push   %esi
 bb1:	e8 ed fd ff ff       	call   9a3 <write>
        putc(fd, c);
 bb6:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bb9:	31 c9                	xor    %ecx,%ecx
 bbb:	eb 95                	jmp    b52 <printf+0x52>
 bbd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 bc0:	83 ec 0c             	sub    $0xc,%esp
 bc3:	b9 10 00 00 00       	mov    $0x10,%ecx
 bc8:	6a 00                	push   $0x0
 bca:	8b 45 d0             	mov    -0x30(%ebp),%eax
 bcd:	8b 10                	mov    (%eax),%edx
 bcf:	89 f0                	mov    %esi,%eax
 bd1:	e8 7a fe ff ff       	call   a50 <printint>
        ap++;
 bd6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 bda:	83 c4 10             	add    $0x10,%esp
      state = 0;
 bdd:	31 c9                	xor    %ecx,%ecx
 bdf:	e9 6e ff ff ff       	jmp    b52 <printf+0x52>
 be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 be8:	8b 45 d0             	mov    -0x30(%ebp),%eax
 beb:	8b 10                	mov    (%eax),%edx
        ap++;
 bed:	83 c0 04             	add    $0x4,%eax
 bf0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 bf3:	85 d2                	test   %edx,%edx
 bf5:	0f 84 8d 00 00 00    	je     c88 <printf+0x188>
        while(*s != 0){
 bfb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 bfe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 c00:	84 c0                	test   %al,%al
 c02:	0f 84 4a ff ff ff    	je     b52 <printf+0x52>
 c08:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 c0b:	89 d3                	mov    %edx,%ebx
 c0d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 c10:	83 ec 04             	sub    $0x4,%esp
          s++;
 c13:	83 c3 01             	add    $0x1,%ebx
 c16:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 c19:	6a 01                	push   $0x1
 c1b:	57                   	push   %edi
 c1c:	56                   	push   %esi
 c1d:	e8 81 fd ff ff       	call   9a3 <write>
        while(*s != 0){
 c22:	0f b6 03             	movzbl (%ebx),%eax
 c25:	83 c4 10             	add    $0x10,%esp
 c28:	84 c0                	test   %al,%al
 c2a:	75 e4                	jne    c10 <printf+0x110>
      state = 0;
 c2c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 c2f:	31 c9                	xor    %ecx,%ecx
 c31:	e9 1c ff ff ff       	jmp    b52 <printf+0x52>
 c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c3d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 c40:	83 ec 0c             	sub    $0xc,%esp
 c43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 c48:	6a 01                	push   $0x1
 c4a:	e9 7b ff ff ff       	jmp    bca <printf+0xca>
 c4f:	90                   	nop
        putc(fd, *ap);
 c50:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 c53:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 c56:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 c58:	6a 01                	push   $0x1
 c5a:	57                   	push   %edi
 c5b:	56                   	push   %esi
        putc(fd, *ap);
 c5c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 c5f:	e8 3f fd ff ff       	call   9a3 <write>
        ap++;
 c64:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 c68:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c6b:	31 c9                	xor    %ecx,%ecx
 c6d:	e9 e0 fe ff ff       	jmp    b52 <printf+0x52>
 c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 c78:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 c7b:	83 ec 04             	sub    $0x4,%esp
 c7e:	e9 2a ff ff ff       	jmp    bad <printf+0xad>
 c83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 c87:	90                   	nop
          s = "(null)";
 c88:	ba 0d 13 00 00       	mov    $0x130d,%edx
        while(*s != 0){
 c8d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 c90:	b8 28 00 00 00       	mov    $0x28,%eax
 c95:	89 d3                	mov    %edx,%ebx
 c97:	e9 74 ff ff ff       	jmp    c10 <printf+0x110>
 c9c:	66 90                	xchg   %ax,%ax
 c9e:	66 90                	xchg   %ax,%ax

00000ca0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ca0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ca1:	a1 4c 18 00 00       	mov    0x184c,%eax
{
 ca6:	89 e5                	mov    %esp,%ebp
 ca8:	57                   	push   %edi
 ca9:	56                   	push   %esi
 caa:	53                   	push   %ebx
 cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 cae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 cb8:	89 c2                	mov    %eax,%edx
 cba:	8b 00                	mov    (%eax),%eax
 cbc:	39 ca                	cmp    %ecx,%edx
 cbe:	73 30                	jae    cf0 <free+0x50>
 cc0:	39 c1                	cmp    %eax,%ecx
 cc2:	72 04                	jb     cc8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cc4:	39 c2                	cmp    %eax,%edx
 cc6:	72 f0                	jb     cb8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 cc8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ccb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 cce:	39 f8                	cmp    %edi,%eax
 cd0:	74 30                	je     d02 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 cd2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 cd5:	8b 42 04             	mov    0x4(%edx),%eax
 cd8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 cdb:	39 f1                	cmp    %esi,%ecx
 cdd:	74 3a                	je     d19 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 cdf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 ce1:	5b                   	pop    %ebx
  freep = p;
 ce2:	89 15 4c 18 00 00    	mov    %edx,0x184c
}
 ce8:	5e                   	pop    %esi
 ce9:	5f                   	pop    %edi
 cea:	5d                   	pop    %ebp
 ceb:	c3                   	ret    
 cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 cf0:	39 c2                	cmp    %eax,%edx
 cf2:	72 c4                	jb     cb8 <free+0x18>
 cf4:	39 c1                	cmp    %eax,%ecx
 cf6:	73 c0                	jae    cb8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 cf8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 cfb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 cfe:	39 f8                	cmp    %edi,%eax
 d00:	75 d0                	jne    cd2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 d02:	03 70 04             	add    0x4(%eax),%esi
 d05:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 d08:	8b 02                	mov    (%edx),%eax
 d0a:	8b 00                	mov    (%eax),%eax
 d0c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 d0f:	8b 42 04             	mov    0x4(%edx),%eax
 d12:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 d15:	39 f1                	cmp    %esi,%ecx
 d17:	75 c6                	jne    cdf <free+0x3f>
    p->s.size += bp->s.size;
 d19:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 d1c:	89 15 4c 18 00 00    	mov    %edx,0x184c
    p->s.size += bp->s.size;
 d22:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 d25:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 d28:	89 0a                	mov    %ecx,(%edx)
}
 d2a:	5b                   	pop    %ebx
 d2b:	5e                   	pop    %esi
 d2c:	5f                   	pop    %edi
 d2d:	5d                   	pop    %ebp
 d2e:	c3                   	ret    
 d2f:	90                   	nop

00000d30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 d30:	55                   	push   %ebp
 d31:	89 e5                	mov    %esp,%ebp
 d33:	57                   	push   %edi
 d34:	56                   	push   %esi
 d35:	53                   	push   %ebx
 d36:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 d3c:	8b 3d 4c 18 00 00    	mov    0x184c,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d42:	8d 70 07             	lea    0x7(%eax),%esi
 d45:	c1 ee 03             	shr    $0x3,%esi
 d48:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 d4b:	85 ff                	test   %edi,%edi
 d4d:	0f 84 9d 00 00 00    	je     df0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d53:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 d55:	8b 4a 04             	mov    0x4(%edx),%ecx
 d58:	39 f1                	cmp    %esi,%ecx
 d5a:	73 6a                	jae    dc6 <malloc+0x96>
 d5c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 d61:	39 de                	cmp    %ebx,%esi
 d63:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 d66:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 d6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 d70:	eb 17                	jmp    d89 <malloc+0x59>
 d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 d7a:	8b 48 04             	mov    0x4(%eax),%ecx
 d7d:	39 f1                	cmp    %esi,%ecx
 d7f:	73 4f                	jae    dd0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d81:	8b 3d 4c 18 00 00    	mov    0x184c,%edi
 d87:	89 c2                	mov    %eax,%edx
 d89:	39 d7                	cmp    %edx,%edi
 d8b:	75 eb                	jne    d78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 d8d:	83 ec 0c             	sub    $0xc,%esp
 d90:	ff 75 e4             	push   -0x1c(%ebp)
 d93:	e8 73 fc ff ff       	call   a0b <sbrk>
  if(p == (char*)-1)
 d98:	83 c4 10             	add    $0x10,%esp
 d9b:	83 f8 ff             	cmp    $0xffffffff,%eax
 d9e:	74 1c                	je     dbc <malloc+0x8c>
  hp->s.size = nu;
 da0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 da3:	83 ec 0c             	sub    $0xc,%esp
 da6:	83 c0 08             	add    $0x8,%eax
 da9:	50                   	push   %eax
 daa:	e8 f1 fe ff ff       	call   ca0 <free>
  return freep;
 daf:	8b 15 4c 18 00 00    	mov    0x184c,%edx
      if((p = morecore(nunits)) == 0)
 db5:	83 c4 10             	add    $0x10,%esp
 db8:	85 d2                	test   %edx,%edx
 dba:	75 bc                	jne    d78 <malloc+0x48>
        return 0;
  }
}
 dbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 dbf:	31 c0                	xor    %eax,%eax
}
 dc1:	5b                   	pop    %ebx
 dc2:	5e                   	pop    %esi
 dc3:	5f                   	pop    %edi
 dc4:	5d                   	pop    %ebp
 dc5:	c3                   	ret    
    if(p->s.size >= nunits){
 dc6:	89 d0                	mov    %edx,%eax
 dc8:	89 fa                	mov    %edi,%edx
 dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 dd0:	39 ce                	cmp    %ecx,%esi
 dd2:	74 4c                	je     e20 <malloc+0xf0>
        p->s.size -= nunits;
 dd4:	29 f1                	sub    %esi,%ecx
 dd6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 dd9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ddc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 ddf:	89 15 4c 18 00 00    	mov    %edx,0x184c
}
 de5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 de8:	83 c0 08             	add    $0x8,%eax
}
 deb:	5b                   	pop    %ebx
 dec:	5e                   	pop    %esi
 ded:	5f                   	pop    %edi
 dee:	5d                   	pop    %ebp
 def:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 df0:	c7 05 4c 18 00 00 50 	movl   $0x1850,0x184c
 df7:	18 00 00 
    base.s.size = 0;
 dfa:	bf 50 18 00 00       	mov    $0x1850,%edi
    base.s.ptr = freep = prevp = &base;
 dff:	c7 05 50 18 00 00 50 	movl   $0x1850,0x1850
 e06:	18 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e09:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 e0b:	c7 05 54 18 00 00 00 	movl   $0x0,0x1854
 e12:	00 00 00 
    if(p->s.size >= nunits){
 e15:	e9 42 ff ff ff       	jmp    d5c <malloc+0x2c>
 e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 e20:	8b 08                	mov    (%eax),%ecx
 e22:	89 0a                	mov    %ecx,(%edx)
 e24:	eb b9                	jmp    ddf <malloc+0xaf>
