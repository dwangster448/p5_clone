
_test_5:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// Summary: MAP: Place multiple maps, verify that overlapping maps are not allowed
// ====================================================================

char *test_name = "TEST_5";

int main() {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	57                   	push   %edi
       e:	56                   	push   %esi
       f:	53                   	push   %ebx
      10:	51                   	push   %ecx
      11:	81 ec ac 01 00 00    	sub    $0x1ac,%esp
    printf(1, "\n\n%s\n", test_name);
      17:	ff 35 d0 1a 00 00    	push   0x1ad0
      1d:	68 78 15 00 00       	push   $0x1578
      22:	6a 01                	push   $0x1
      24:	e8 b7 0c 00 00       	call   ce0 <printf>
    validate_initial_state();
      29:	e8 b2 05 00 00       	call   5e0 <validate_initial_state>

    int anon = MAP_FIXED | MAP_ANONYMOUS | MAP_SHARED;
    int filebacked = MAP_FIXED | MAP_SHARED;
    uint *maps = (uint *)malloc(MAX_WMMAP_INFO * sizeof(uint));
      2e:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
      35:	e8 d6 0e 00 00       	call   f10 <malloc>
    uint *lengths = (uint *)malloc(MAX_WMMAP_INFO * sizeof(uint));
      3a:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
    uint *maps = (uint *)malloc(MAX_WMMAP_INFO * sizeof(uint));
      41:	89 85 54 fe ff ff    	mov    %eax,-0x1ac(%ebp)
    uint *lengths = (uint *)malloc(MAX_WMMAP_INFO * sizeof(uint));
      47:	e8 c4 0e 00 00       	call   f10 <malloc>
      4c:	89 85 50 fe ff ff    	mov    %eax,-0x1b0(%ebp)
    int idx = 0;

    char *filename = "small.txt";
    char val = 101;
    int filelength = create_small_file(filename, val);
      52:	58                   	pop    %eax
      53:	5a                   	pop    %edx
      54:	6a 65                	push   $0x65
      56:	68 7e 15 00 00       	push   $0x157e
      5b:	e8 30 06 00 00       	call   690 <create_small_file>
    //
    // place map 1 (filebacked) at MMABASE
    //
    uint addr = MMAPBASE;
    uint length = filelength;
    int fd = open_file(filename, filelength);
      60:	59                   	pop    %ecx
      61:	5e                   	pop    %esi
      62:	50                   	push   %eax
    int filelength = create_small_file(filename, val);
      63:	89 c3                	mov    %eax,%ebx
    int fd = open_file(filename, filelength);
      65:	68 7e 15 00 00       	push   $0x157e
      6a:	e8 21 08 00 00       	call   890 <open_file>
    uint map = wmap(addr, length, filebacked, fd);
      6f:	50                   	push   %eax
    int fd = open_file(filename, filelength);
      70:	89 c6                	mov    %eax,%esi
    uint map = wmap(addr, length, filebacked, fd);
      72:	6a 0a                	push   $0xa
      74:	53                   	push   %ebx
      75:	68 00 00 00 60       	push   $0x60000000
      7a:	e8 84 0b 00 00       	call   c03 <wmap>
    if (map != addr) {
      7f:	83 c4 20             	add    $0x20,%esp
      82:	3d 00 00 00 60       	cmp    $0x60000000,%eax
      87:	74 15                	je     9e <main+0x9e>
    // place another anon map
    int addr4 = PGROUNDUP(addr2 + length2);
    int length4 = PGSIZE * 200;
    uint map4 = wmap(addr4, length4, anon, fd);
    if (map4 != addr4) {
        printerr("wmap() returned %d\n", (int)map4);
      89:	83 ec 04             	sub    $0x4,%esp
      8c:	50                   	push   %eax
      8d:	68 6c 14 00 00       	push   $0x146c
      92:	6a 01                	push   $0x1
      94:	e8 47 0c 00 00       	call   ce0 <printf>
        failed();
      99:	e8 22 02 00 00       	call   2c0 <failed>
    get_n_validate_wmap_info(&winfo, 1);   // 1 map exists
      9e:	8d bd 60 fe ff ff    	lea    -0x1a0(%ebp),%edi
      a4:	50                   	push   %eax
      a5:	50                   	push   %eax
      a6:	6a 01                	push   $0x1
      a8:	57                   	push   %edi
      a9:	e8 82 02 00 00       	call   330 <get_n_validate_wmap_info>
    map_exists(&winfo, map, length, TRUE); // map 1 exists
      ae:	6a 01                	push   $0x1
      b0:	53                   	push   %ebx
      b1:	68 00 00 00 60       	push   $0x60000000
      b6:	57                   	push   %edi
      b7:	e8 f4 02 00 00       	call   3b0 <map_exists>
      bc:	83 c4 10             	add    $0x10,%esp
    printf(1, "INFO: Map 1 at 0x%x with length %d. \tOkay.\n", map, length);
      bf:	53                   	push   %ebx
      c0:	68 00 00 00 60       	push   $0x60000000
      c5:	68 94 14 00 00       	push   $0x1494
      ca:	6a 01                	push   $0x1
      cc:	e8 0f 0c 00 00       	call   ce0 <printf>
    maps[idx] = map;
      d1:	8b 85 54 fe ff ff    	mov    -0x1ac(%ebp),%eax
    uint map2 = wmap(addr2, length2, anon, fd);
      d7:	83 c4 20             	add    $0x20,%esp
    maps[idx] = map;
      da:	c7 00 00 00 00 60    	movl   $0x60000000,(%eax)
    lengths[idx] = length;
      e0:	8b 85 50 fe ff ff    	mov    -0x1b0(%ebp),%eax
      e6:	89 18                	mov    %ebx,(%eax)
    uint map2 = wmap(addr2, length2, anon, fd);
      e8:	56                   	push   %esi
      e9:	6a 0e                	push   $0xe
      eb:	68 00 20 00 00       	push   $0x2000
      f0:	68 00 20 00 60       	push   $0x60002000
      f5:	e8 09 0b 00 00       	call   c03 <wmap>
    if (map2 != addr2) {
      fa:	83 c4 10             	add    $0x10,%esp
      fd:	3d 00 20 00 60       	cmp    $0x60002000,%eax
     102:	75 85                	jne    89 <main+0x89>
    get_n_validate_wmap_info(&winfo, 2);     // 2 maps exist
     104:	50                   	push   %eax
     105:	50                   	push   %eax
     106:	6a 02                	push   $0x2
     108:	57                   	push   %edi
     109:	e8 22 02 00 00       	call   330 <get_n_validate_wmap_info>
    map_exists(&winfo, map, length, TRUE);   // map 1 exists
     10e:	6a 01                	push   $0x1
     110:	53                   	push   %ebx
     111:	68 00 00 00 60       	push   $0x60000000
     116:	57                   	push   %edi
     117:	e8 94 02 00 00       	call   3b0 <map_exists>
     11c:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo, map2, length2, TRUE); // map 2 exists
     11f:	6a 01                	push   $0x1
     121:	68 00 20 00 00       	push   $0x2000
     126:	68 00 20 00 60       	push   $0x60002000
     12b:	57                   	push   %edi
     12c:	e8 7f 02 00 00       	call   3b0 <map_exists>
     131:	83 c4 10             	add    $0x10,%esp
    printf(1, "INFO: Map 2 at 0x%x with length %d. \tOkay.\n", map2, length2);
     134:	68 00 20 00 00       	push   $0x2000
     139:	68 00 20 00 60       	push   $0x60002000
     13e:	68 c0 14 00 00       	push   $0x14c0
     143:	6a 01                	push   $0x1
     145:	e8 96 0b 00 00       	call   ce0 <printf>
    maps[idx] = map2;
     14a:	8b 85 54 fe ff ff    	mov    -0x1ac(%ebp),%eax
    int map3 = wmap(addr3, length3, anon, fd);
     150:	83 c4 20             	add    $0x20,%esp
    maps[idx] = map2;
     153:	c7 40 04 00 20 00 60 	movl   $0x60002000,0x4(%eax)
    lengths[idx] = length2;
     15a:	8b 85 50 fe ff ff    	mov    -0x1b0(%ebp),%eax
     160:	c7 40 04 00 20 00 00 	movl   $0x2000,0x4(%eax)
    int map3 = wmap(addr3, length3, anon, fd);
     167:	56                   	push   %esi
     168:	6a 0e                	push   $0xe
     16a:	68 08 30 00 00       	push   $0x3008
     16f:	68 00 30 00 60       	push   $0x60003000
     174:	e8 8a 0a 00 00       	call   c03 <wmap>
    if (map3 != FAILED) {
     179:	83 c4 10             	add    $0x10,%esp
     17c:	83 f8 ff             	cmp    $0xffffffff,%eax
     17f:	74 13                	je     194 <main+0x194>
        printerr("wmap() does not fail\n", map3);
     181:	51                   	push   %ecx
     182:	50                   	push   %eax
     183:	68 ec 14 00 00       	push   $0x14ec
     188:	6a 01                	push   $0x1
     18a:	e8 51 0b 00 00       	call   ce0 <printf>
        failed();
     18f:	e8 2c 01 00 00       	call   2c0 <failed>
    get_n_validate_wmap_info(&winfo, 2);      // 2 maps exist
     194:	52                   	push   %edx
     195:	52                   	push   %edx
     196:	6a 02                	push   $0x2
     198:	57                   	push   %edi
     199:	e8 92 01 00 00       	call   330 <get_n_validate_wmap_info>
    map_exists(&winfo, map, length, TRUE);    // map 1 exists
     19e:	6a 01                	push   $0x1
     1a0:	53                   	push   %ebx
     1a1:	68 00 00 00 60       	push   $0x60000000
     1a6:	57                   	push   %edi
     1a7:	e8 04 02 00 00       	call   3b0 <map_exists>
     1ac:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo, map2, length2, TRUE);  // map 2 exists
     1af:	6a 01                	push   $0x1
     1b1:	68 00 20 00 00       	push   $0x2000
     1b6:	68 00 20 00 60       	push   $0x60002000
     1bb:	57                   	push   %edi
     1bc:	e8 ef 01 00 00       	call   3b0 <map_exists>
     1c1:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo, map3, length3, FALSE); // map 3 does not exist
     1c4:	6a 00                	push   $0x0
     1c6:	68 08 30 00 00       	push   $0x3008
     1cb:	6a ff                	push   $0xffffffff
     1cd:	57                   	push   %edi
     1ce:	e8 dd 01 00 00       	call   3b0 <map_exists>
    printf(1, "INFO: Map 3 does not exist. \tOkay.\n");
     1d3:	83 c4 18             	add    $0x18,%esp
     1d6:	68 14 15 00 00       	push   $0x1514
     1db:	6a 01                	push   $0x1
     1dd:	e8 fe 0a 00 00       	call   ce0 <printf>
    uint map4 = wmap(addr4, length4, anon, fd);
     1e2:	56                   	push   %esi
     1e3:	6a 0e                	push   $0xe
     1e5:	68 00 80 0c 00       	push   $0xc8000
     1ea:	68 00 40 00 60       	push   $0x60004000
     1ef:	e8 0f 0a 00 00       	call   c03 <wmap>
    if (map4 != addr4) {
     1f4:	83 c4 20             	add    $0x20,%esp
     1f7:	3d 00 40 00 60       	cmp    $0x60004000,%eax
     1fc:	0f 85 87 fe ff ff    	jne    89 <main+0x89>
    }
    // validate final state
    struct wmapinfo winfo5;
    get_n_validate_wmap_info(&winfo5, 3);      // 3 maps exist
     202:	8d b5 24 ff ff ff    	lea    -0xdc(%ebp),%esi
     208:	50                   	push   %eax
     209:	50                   	push   %eax
     20a:	6a 03                	push   $0x3
     20c:	56                   	push   %esi
     20d:	e8 1e 01 00 00       	call   330 <get_n_validate_wmap_info>
    map_exists(&winfo5, map, length, TRUE);    // map 1 exists
     212:	6a 01                	push   $0x1
     214:	53                   	push   %ebx
     215:	68 00 00 00 60       	push   $0x60000000
     21a:	56                   	push   %esi
     21b:	e8 90 01 00 00       	call   3b0 <map_exists>
     220:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo5, map2, length2, TRUE);  // map 2 exists
     223:	6a 01                	push   $0x1
     225:	68 00 20 00 00       	push   $0x2000
     22a:	68 00 20 00 60       	push   $0x60002000
     22f:	56                   	push   %esi
     230:	e8 7b 01 00 00       	call   3b0 <map_exists>
     235:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo5, map3, length3, FALSE); // map 3 does not exist
     238:	6a 00                	push   $0x0
     23a:	68 08 30 00 00       	push   $0x3008
     23f:	6a ff                	push   $0xffffffff
     241:	56                   	push   %esi
     242:	e8 69 01 00 00       	call   3b0 <map_exists>
     247:	83 c4 10             	add    $0x10,%esp
    map_exists(&winfo5, map4, length4, TRUE);  // map 4 exists
     24a:	6a 01                	push   $0x1
     24c:	68 00 80 0c 00       	push   $0xc8000
     251:	68 00 40 00 60       	push   $0x60004000
     256:	56                   	push   %esi
     257:	e8 54 01 00 00       	call   3b0 <map_exists>
     25c:	83 c4 10             	add    $0x10,%esp
    printf(1, "INFO: Map 4 at 0x%x with length %d. \tOkay.\n", map4, length4);
     25f:	68 00 80 0c 00       	push   $0xc8000
     264:	68 00 40 00 60       	push   $0x60004000
     269:	68 38 15 00 00       	push   $0x1538
     26e:	6a 01                	push   $0x1
     270:	e8 6b 0a 00 00       	call   ce0 <printf>
    maps[idx] = map4;
     275:	8b 85 54 fe ff ff    	mov    -0x1ac(%ebp),%eax
    lengths[idx] = length4;
     27b:	8b 95 50 fe ff ff    	mov    -0x1b0(%ebp),%edx
    idx++;

    // check for overlap among maps
    check_overlaps(maps, lengths, idx);
     281:	83 c4 1c             	add    $0x1c,%esp
    maps[idx] = map4;
     284:	c7 40 08 00 40 00 60 	movl   $0x60004000,0x8(%eax)
    lengths[idx] = length4;
     28b:	c7 42 08 00 80 0c 00 	movl   $0xc8000,0x8(%edx)
    check_overlaps(maps, lengths, idx);
     292:	6a 03                	push   $0x3
     294:	52                   	push   %edx
     295:	50                   	push   %eax
     296:	e8 75 03 00 00       	call   610 <check_overlaps>

    // test ends
    success();
     29b:	e8 00 00 00 00       	call   2a0 <success>

000002a0 <success>:
           "\033[0m" fmt,                                                           \
           ##__VA_ARGS__)

extern char *test_name;

void success() {
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "\033[0;32mSUCCESS:\033[0m %s\t PASSED\n\n", test_name);
     2a6:	ff 35 d0 1a 00 00    	push   0x1ad0
     2ac:	68 08 10 00 00       	push   $0x1008
     2b1:	6a 01                	push   $0x1
     2b3:	e8 28 0a 00 00       	call   ce0 <printf>
    exit();
     2b8:	e8 a6 08 00 00       	call   b63 <exit>
     2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <failed>:
}

void failed() {
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 08             	sub    $0x8,%esp
    printf(1, "\n\033[0;31mFAIL:\033[0m %s\t FAILED (pid %d)\n\n", test_name,
     2c6:	e8 18 09 00 00       	call   be3 <getpid>
     2cb:	50                   	push   %eax
     2cc:	ff 35 d0 1a 00 00    	push   0x1ad0
     2d2:	68 2c 10 00 00       	push   $0x102c
     2d7:	6a 01                	push   $0x1
     2d9:	e8 02 0a 00 00       	call   ce0 <printf>
           getpid());
    exit();
     2de:	e8 80 08 00 00       	call   b63 <exit>
     2e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <reset_wmapinfo>:
}

void reset_wmapinfo(struct wmapinfo *info) {
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	8b 55 08             	mov    0x8(%ebp),%edx
    info->total_mmaps = -1;
     2f6:	c7 02 ff ff ff ff    	movl   $0xffffffff,(%edx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     2fc:	8d 42 04             	lea    0x4(%edx),%eax
     2ff:	83 c2 44             	add    $0x44,%edx
     302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        info->addr[i] = -1;
     308:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     30e:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
     311:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
     318:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     31f:	39 d0                	cmp    %edx,%eax
     321:	75 e5                	jne    308 <reset_wmapinfo+0x18>
    }
}
     323:	5d                   	pop    %ebp
     324:	c3                   	ret    
     325:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <get_n_validate_wmap_info>:

/**
 * Get the wmapinfo and validate the total number of maps
 */
void get_n_validate_wmap_info(struct wmapinfo *info, int expected_total_mmaps) {
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	53                   	push   %ebx
     334:	83 ec 04             	sub    $0x4,%esp
     337:	8b 5d 08             	mov    0x8(%ebp),%ebx
    info->total_mmaps = -1;
     33a:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     340:	8d 43 04             	lea    0x4(%ebx),%eax
     343:	8d 53 44             	lea    0x44(%ebx),%edx
     346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     34d:	8d 76 00             	lea    0x0(%esi),%esi
        info->addr[i] = -1;
     350:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     356:	83 c0 04             	add    $0x4,%eax
        info->length[i] = -1;
     359:	c7 40 3c ff ff ff ff 	movl   $0xffffffff,0x3c(%eax)
        info->n_loaded_pages[i] = -1;
     360:	c7 40 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%eax)
    for (int i = 0; i < MAX_WMMAP_INFO; i++) {
     367:	39 d0                	cmp    %edx,%eax
     369:	75 e5                	jne    350 <get_n_validate_wmap_info+0x20>
    reset_wmapinfo(info);
    int ret = getwmapinfo(info);
     36b:	83 ec 0c             	sub    $0xc,%esp
     36e:	53                   	push   %ebx
     36f:	e8 a7 08 00 00       	call   c1b <getwmapinfo>
    if (ret != SUCCESS) {
     374:	83 c4 10             	add    $0x10,%esp
     377:	85 c0                	test   %eax,%eax
     379:	75 0c                	jne    387 <get_n_validate_wmap_info+0x57>
        printerr("getwmapinfo() returned %d\n", ret);
        failed();
    }
    if (info->total_mmaps != expected_total_mmaps) {
     37b:	8b 03                	mov    (%ebx),%eax
     37d:	3b 45 0c             	cmp    0xc(%ebp),%eax
     380:	75 18                	jne    39a <get_n_validate_wmap_info+0x6a>

        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
                 expected_total_mmaps);
        failed();
    }
}
     382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     385:	c9                   	leave  
     386:	c3                   	ret    
        printerr("getwmapinfo() returned %d\n", ret);
     387:	52                   	push   %edx
     388:	50                   	push   %eax
     389:	68 54 10 00 00       	push   $0x1054
     38e:	6a 01                	push   $0x1
     390:	e8 4b 09 00 00       	call   ce0 <printf>
        failed();
     395:	e8 26 ff ff ff       	call   2c0 <failed>
        printerr("total_mmaps = %d, expected %d.\n", info->total_mmaps,
     39a:	ff 75 0c             	push   0xc(%ebp)
     39d:	50                   	push   %eax
     39e:	68 84 10 00 00       	push   $0x1084
     3a3:	6a 01                	push   $0x1
     3a5:	e8 36 09 00 00       	call   ce0 <printf>
        failed();
     3aa:	e8 11 ff ff ff       	call   2c0 <failed>
     3af:	90                   	nop

000003b0 <map_exists>:

/**
 * Check if a map with the given address and length exists in the list of maps
 */
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
     3b0:	55                   	push   %ebp
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
     3b1:	31 c0                	xor    %eax,%eax
void map_exists(struct wmapinfo *info, uint addr, int length, int expected) {
     3b3:	89 e5                	mov    %esp,%ebp
     3b5:	56                   	push   %esi
     3b6:	8b 55 08             	mov    0x8(%ebp),%edx
     3b9:	8b 75 10             	mov    0x10(%ebp),%esi
     3bc:	53                   	push   %ebx
     3bd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    for (int i = 0; i < info->total_mmaps; i++) {
     3c0:	8b 0a                	mov    (%edx),%ecx
     3c2:	85 c9                	test   %ecx,%ecx
     3c4:	7f 11                	jg     3d7 <map_exists+0x27>
     3c6:	eb 20                	jmp    3e8 <map_exists+0x38>
     3c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3cf:	90                   	nop
     3d0:	83 c0 01             	add    $0x1,%eax
     3d3:	39 c8                	cmp    %ecx,%eax
     3d5:	74 21                	je     3f8 <map_exists+0x48>
        if (info->addr[i] == addr && info->length[i] == length) {
     3d7:	39 5c 82 04          	cmp    %ebx,0x4(%edx,%eax,4)
     3db:	75 f3                	jne    3d0 <map_exists+0x20>
     3dd:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
     3e1:	75 ed                	jne    3d0 <map_exists+0x20>
            found = 1;
     3e3:	b8 01 00 00 00       	mov    $0x1,%eax
            break;
        }
    }
    if (found != expected) {
     3e8:	3b 45 14             	cmp    0x14(%ebp),%eax
     3eb:	75 0f                	jne    3fc <map_exists+0x4c>
            1,
            "ERROR: expected mmap 0x%x with length 0x%x to %s in the list of maps\n",
            addr, length, expected ? "exist" : "NOT exist");
        failed();
    }
}
     3ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
     3f0:	5b                   	pop    %ebx
     3f1:	5e                   	pop    %esi
     3f2:	5d                   	pop    %ebp
     3f3:	c3                   	ret    
     3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int found = 0;
     3f8:	31 c0                	xor    %eax,%eax
     3fa:	eb ec                	jmp    3e8 <map_exists+0x38>
        printf(
     3fc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     400:	ba 64 15 00 00       	mov    $0x1564,%edx
     405:	b8 68 15 00 00       	mov    $0x1568,%eax
     40a:	0f 44 c2             	cmove  %edx,%eax
     40d:	83 ec 0c             	sub    $0xc,%esp
     410:	50                   	push   %eax
     411:	56                   	push   %esi
     412:	53                   	push   %ebx
     413:	68 b8 10 00 00       	push   $0x10b8
     418:	6a 01                	push   $0x1
     41a:	e8 c1 08 00 00       	call   ce0 <printf>
        failed();
     41f:	83 c4 20             	add    $0x20,%esp
     422:	e8 99 fe ff ff       	call   2c0 <failed>
     427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     42e:	66 90                	xchg   %ax,%ax

00000430 <get_n_validate_va2pa>:

uint get_n_validate_va2pa(uint va) {
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
     437:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
     43a:	53                   	push   %ebx
     43b:	e8 cb 07 00 00       	call   c0b <va2pa>
    if (ret == FAILED) {
     440:	83 c4 10             	add    $0x10,%esp
     443:	83 f8 ff             	cmp    $0xffffffff,%eax
     446:	74 13                	je     45b <get_n_validate_va2pa+0x2b>
        printerr("va2pa(0x%x)` failed\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
     448:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
     44e:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
     454:	77 18                	ja     46e <get_n_validate_va2pa+0x3e>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
    return pa;
}
     456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     459:	c9                   	leave  
     45a:	c3                   	ret    
        printerr("va2pa(0x%x)` failed\n", va);
     45b:	51                   	push   %ecx
     45c:	53                   	push   %ebx
     45d:	68 00 11 00 00       	push   $0x1100
     462:	6a 01                	push   $0x1
     464:	e8 77 08 00 00       	call   ce0 <printf>
        failed();
     469:	e8 52 fe ff ff       	call   2c0 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
     46e:	52                   	push   %edx
     46f:	52                   	push   %edx
     470:	68 00 00 00 0e       	push   $0xe000000
     475:	68 00 00 10 00       	push   $0x100000
     47a:	50                   	push   %eax
     47b:	53                   	push   %ebx
     47c:	68 28 11 00 00       	push   $0x1128
     481:	6a 01                	push   $0x1
     483:	e8 58 08 00 00       	call   ce0 <printf>
        failed();
     488:	83 c4 20             	add    $0x20,%esp
     48b:	e8 30 fe ff ff       	call   2c0 <failed>

00000490 <map_allocated>:

void map_allocated(struct wmapinfo *info, uint addr, int length,
                   int n_loaded_pages) {
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	56                   	push   %esi
     494:	8b 55 08             	mov    0x8(%ebp),%edx
     497:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     49a:	53                   	push   %ebx
     49b:	8b 75 10             	mov    0x10(%ebp),%esi
    int found = 0;
    for (int i = 0; i < info->total_mmaps; i++) {
     49e:	8b 1a                	mov    (%edx),%ebx
     4a0:	85 db                	test   %ebx,%ebx
     4a2:	7e 32                	jle    4d6 <map_allocated+0x46>
     4a4:	31 c0                	xor    %eax,%eax
     4a6:	eb 0f                	jmp    4b7 <map_allocated+0x27>
     4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4af:	90                   	nop
     4b0:	83 c0 01             	add    $0x1,%eax
     4b3:	39 d8                	cmp    %ebx,%eax
     4b5:	74 1f                	je     4d6 <map_allocated+0x46>
        if (info->addr[i] == addr && info->length[i] == length) {
     4b7:	39 4c 82 04          	cmp    %ecx,0x4(%edx,%eax,4)
     4bb:	75 f3                	jne    4b0 <map_allocated+0x20>
     4bd:	39 74 82 44          	cmp    %esi,0x44(%edx,%eax,4)
     4c1:	75 ed                	jne    4b0 <map_allocated+0x20>
            found = 1;
            if (info->n_loaded_pages[i] != n_loaded_pages) {
     4c3:	8b 84 82 84 00 00 00 	mov    0x84(%edx,%eax,4),%eax
     4ca:	3b 45 14             	cmp    0x14(%ebp),%eax
     4cd:	75 1a                	jne    4e9 <map_allocated+0x59>
        printf(1,
               "Cause: expected 0x%x with length %d to exist in the list of maps\n",
               addr, length);
        failed();
    }
}
     4cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
     4d2:	5b                   	pop    %ebx
     4d3:	5e                   	pop    %esi
     4d4:	5d                   	pop    %ebp
     4d5:	c3                   	ret    
        printf(1,
     4d6:	56                   	push   %esi
     4d7:	51                   	push   %ecx
     4d8:	68 ac 11 00 00       	push   $0x11ac
     4dd:	6a 01                	push   $0x1
     4df:	e8 fc 07 00 00       	call   ce0 <printf>
        failed();
     4e4:	e8 d7 fd ff ff       	call   2c0 <failed>
                printf(1, "Cause: expected %d pages to be loaded, but found %d\n",
     4e9:	50                   	push   %eax
     4ea:	ff 75 14             	push   0x14(%ebp)
     4ed:	68 74 11 00 00       	push   $0x1174
     4f2:	6a 01                	push   $0x1
     4f4:	e8 e7 07 00 00       	call   ce0 <printf>
                failed();
     4f9:	e8 c2 fd ff ff       	call   2c0 <failed>
     4fe:	66 90                	xchg   %ax,%ax

00000500 <va_exists>:

void va_exists(uint va, int expected) {
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	53                   	push   %ebx
     504:	83 ec 10             	sub    $0x10,%esp
     507:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int ret = va2pa(va);
     50a:	53                   	push   %ebx
     50b:	e8 fb 06 00 00       	call   c0b <va2pa>
    if (ret == FAILED) { // va is not allocated
     510:	83 c4 10             	add    $0x10,%esp
     513:	83 f8 ff             	cmp    $0xffffffff,%eax
     516:	74 20                	je     538 <va_exists+0x38>
            failed();
        }
        return;
    }
    // va is allocated
    if (!expected) {
     518:	8b 55 0c             	mov    0xc(%ebp),%edx
     51b:	85 d2                	test   %edx,%edx
     51d:	74 55                	je     574 <va_exists+0x74>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
        failed();
    }
    uint pa = (uint)ret;
    if (pa < KERNCODE || pa >= PHYSTOP) {
     51f:	8d 90 00 00 f0 ff    	lea    -0x100000(%eax),%edx
     525:	81 fa ff ff ef 0d    	cmp    $0xdefffff,%edx
     52b:	77 25                	ja     552 <va_exists+0x52>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
                 KERNCODE, PHYSTOP);
        failed();
    }
}
     52d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     530:	c9                   	leave  
     531:	c3                   	ret    
     532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (expected) {
     538:	8b 45 0c             	mov    0xc(%ebp),%eax
     53b:	85 c0                	test   %eax,%eax
     53d:	74 ee                	je     52d <va_exists+0x2d>
            printerr("expected va 0x%x to be allocated\n", va);
     53f:	51                   	push   %ecx
     540:	53                   	push   %ebx
     541:	68 f0 11 00 00       	push   $0x11f0
     546:	6a 01                	push   $0x1
     548:	e8 93 07 00 00       	call   ce0 <printf>
            failed();
     54d:	e8 6e fd ff ff       	call   2c0 <failed>
        printerr("va2pa(0x%x) returned 0x%x, expected range [0x%x, 0x%x]\n", va, pa,
     552:	52                   	push   %edx
     553:	52                   	push   %edx
     554:	68 00 00 00 0e       	push   $0xe000000
     559:	68 00 00 10 00       	push   $0x100000
     55e:	50                   	push   %eax
     55f:	53                   	push   %ebx
     560:	68 28 11 00 00       	push   $0x1128
     565:	6a 01                	push   $0x1
     567:	e8 74 07 00 00       	call   ce0 <printf>
        failed();
     56c:	83 c4 20             	add    $0x20,%esp
     56f:	e8 4c fd ff ff       	call   2c0 <failed>
        printerr("va 0x%x has pa, expected it to be not allocated\n", va);
     574:	51                   	push   %ecx
     575:	53                   	push   %ebx
     576:	68 24 12 00 00       	push   $0x1224
     57b:	6a 01                	push   $0x1
     57d:	e8 5e 07 00 00       	call   ce0 <printf>
        failed();
     582:	e8 39 fd ff ff       	call   2c0 <failed>
     587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     58e:	66 90                	xchg   %ax,%ax

00000590 <no_mmaps_in_pgdir>:

void no_mmaps_in_pgdir() {
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	53                   	push   %ebx
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
     594:	bb 00 00 00 60       	mov    $0x60000000,%ebx
void no_mmaps_in_pgdir() {
     599:	83 ec 04             	sub    $0x4,%esp
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        int pa = va2pa(va);
     5a0:	83 ec 0c             	sub    $0xc,%esp
     5a3:	53                   	push   %ebx
     5a4:	e8 62 06 00 00       	call   c0b <va2pa>
        if (pa != FAILED) {
     5a9:	83 c4 10             	add    $0x10,%esp
     5ac:	83 f8 ff             	cmp    $0xffffffff,%eax
     5af:	75 0d                	jne    5be <no_mmaps_in_pgdir+0x2e>
    for (uint va = MMAPBASE; va < KERNBASE; va += PGSIZE) {
     5b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
     5b7:	79 e7                	jns    5a0 <no_mmaps_in_pgdir+0x10>
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
            failed();
        }
    }
}
     5b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5bc:	c9                   	leave  
     5bd:	c3                   	ret    
            printerr("va2pa(0x%x) returned 0x%x, expected FAILED\n", va, pa);
     5be:	50                   	push   %eax
     5bf:	53                   	push   %ebx
     5c0:	68 68 12 00 00       	push   $0x1268
     5c5:	6a 01                	push   $0x1
     5c7:	e8 14 07 00 00       	call   ce0 <printf>
            failed();
     5cc:	e8 ef fc ff ff       	call   2c0 <failed>
     5d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5df:	90                   	nop

000005e0 <validate_initial_state>:

void validate_initial_state() {
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	81 ec e0 00 00 00    	sub    $0xe0,%esp
    struct wmapinfo winfo;
    get_n_validate_wmap_info(&winfo, 0); // no maps exist
     5e9:	8d 85 34 ff ff ff    	lea    -0xcc(%ebp),%eax
     5ef:	6a 00                	push   $0x0
     5f1:	50                   	push   %eax
     5f2:	e8 39 fd ff ff       	call   330 <get_n_validate_wmap_info>
    // no_mmaps_in_pgdir();                 // no maps in the mmap range in pgdir
    printf(1, "INFO: Initially 0 maps. \tOkay.\n");
     5f7:	58                   	pop    %eax
     5f8:	5a                   	pop    %edx
     5f9:	68 a8 12 00 00       	push   $0x12a8
     5fe:	6a 01                	push   $0x1
     600:	e8 db 06 00 00       	call   ce0 <printf>
}
     605:	83 c4 10             	add    $0x10,%esp
     608:	c9                   	leave  
     609:	c3                   	ret    
     60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <check_overlaps>:

void check_overlaps(uint *maps, uint *lengths, int n) {
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	57                   	push   %edi
     614:	56                   	push   %esi
     615:	53                   	push   %ebx
     616:	83 ec 1c             	sub    $0x1c,%esp
     619:	8b 7d 10             	mov    0x10(%ebp),%edi
    for (int i = 0; i < n; i++) {
     61c:	85 ff                	test   %edi,%edi
     61e:	7e 55                	jle    675 <check_overlaps+0x65>
     620:	8b 75 08             	mov    0x8(%ebp),%esi
     623:	31 db                	xor    %ebx,%ebx
     625:	8d 76 00             	lea    0x0(%esi),%esi
        for (int j = 0; j < n; j++) {
     628:	89 75 e4             	mov    %esi,-0x1c(%ebp)
     62b:	31 c0                	xor    %eax,%eax
     62d:	89 7d 10             	mov    %edi,0x10(%ebp)
     630:	eb 08                	jmp    63a <check_overlaps+0x2a>
     632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     638:	89 d0                	mov    %edx,%eax
            if (i == j)
     63a:	39 d8                	cmp    %ebx,%eax
     63c:	74 1b                	je     659 <check_overlaps+0x49>
                continue;
            if (maps[i] >= maps[j] && maps[i] < maps[j] + lengths[j]) {
     63e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
     641:	8b 4d 08             	mov    0x8(%ebp),%ecx
     644:	8b 17                	mov    (%edi),%edx
     646:	8b 0c 81             	mov    (%ecx,%eax,4),%ecx
     649:	39 ca                	cmp    %ecx,%edx
     64b:	72 0c                	jb     659 <check_overlaps+0x49>
     64d:	8b 7d 0c             	mov    0xc(%ebp),%edi
     650:	8b 34 87             	mov    (%edi,%eax,4),%esi
     653:	01 ce                	add    %ecx,%esi
     655:	39 f2                	cmp    %esi,%edx
     657:	72 24                	jb     67d <check_overlaps+0x6d>
        for (int j = 0; j < n; j++) {
     659:	8d 50 01             	lea    0x1(%eax),%edx
     65c:	39 55 10             	cmp    %edx,0x10(%ebp)
     65f:	75 d7                	jne    638 <check_overlaps+0x28>
    for (int i = 0; i < n; i++) {
     661:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     664:	8b 7d 10             	mov    0x10(%ebp),%edi
     667:	8d 53 01             	lea    0x1(%ebx),%edx
     66a:	83 c6 04             	add    $0x4,%esi
     66d:	39 d8                	cmp    %ebx,%eax
     66f:	74 04                	je     675 <check_overlaps+0x65>
     671:	89 d3                	mov    %edx,%ebx
     673:	eb b3                	jmp    628 <check_overlaps+0x18>
                         maps[j]);
                failed();
            }
        }
    }
}
     675:	8d 65 f4             	lea    -0xc(%ebp),%esp
     678:	5b                   	pop    %ebx
     679:	5e                   	pop    %esi
     67a:	5f                   	pop    %edi
     67b:	5d                   	pop    %ebp
     67c:	c3                   	ret    
                printerr("Map (addr 0x%x) overlaps with Map (addr 0x%x)\n", maps[i],
     67d:	51                   	push   %ecx
     67e:	52                   	push   %edx
     67f:	68 c8 12 00 00       	push   $0x12c8
     684:	6a 01                	push   $0x1
     686:	e8 55 06 00 00       	call   ce0 <printf>
                failed();
     68b:	e8 30 fc ff ff       	call   2c0 <failed>

00000690 <create_small_file>:

/**
 * Create a small file with 512 bytes of content
 */
int create_small_file(char *filename, char c) {
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	83 ec 0c             	sub    $0xc,%esp
     699:	0f b6 5d 0c          	movzbl 0xc(%ebp),%ebx
    // create a file
    int bufflen = 512;
    char buff[bufflen];
     69d:	89 e0                	mov    %esp,%eax
     69f:	39 c4                	cmp    %eax,%esp
     6a1:	74 12                	je     6b5 <create_small_file+0x25>
     6a3:	81 ec 00 10 00 00    	sub    $0x1000,%esp
     6a9:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
     6b0:	00 
     6b1:	39 c4                	cmp    %eax,%esp
     6b3:	75 ee                	jne    6a3 <create_small_file+0x13>
     6b5:	81 ec 00 02 00 00    	sub    $0x200,%esp
     6bb:	83 8c 24 fc 01 00 00 	orl    $0x0,0x1fc(%esp)
     6c2:	00 
     6c3:	89 e7                	mov    %esp,%edi
    int fd = open(filename, O_CREATE | O_RDWR);
     6c5:	83 ec 08             	sub    $0x8,%esp
     6c8:	68 02 02 00 00       	push   $0x202
     6cd:	ff 75 08             	push   0x8(%ebp)
     6d0:	e8 ce 04 00 00       	call   ba3 <open>
    if (fd < 0) {
     6d5:	89 fc                	mov    %edi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
     6d7:	89 c6                	mov    %eax,%esi
    if (fd < 0) {
     6d9:	85 c0                	test   %eax,%eax
     6db:	78 57                	js     734 <create_small_file+0xa4>
     6dd:	89 f8                	mov    %edi,%eax
     6df:	8d 8f 00 02 00 00    	lea    0x200(%edi),%ecx
     6e5:	8d 76 00             	lea    0x0(%esi),%esi
        printerr("Failed to create file %s\n", filename);
        failed();
    }
    // prepare the content to write
    for (int j = 0; j < bufflen; j++) {
        buff[j] = c;
     6e8:	88 18                	mov    %bl,(%eax)
    for (int j = 0; j < bufflen; j++) {
     6ea:	83 c0 01             	add    $0x1,%eax
     6ed:	39 c8                	cmp    %ecx,%eax
     6ef:	75 f7                	jne    6e8 <create_small_file+0x58>
    }
    // write to file
    if (write(fd, buff, bufflen) != bufflen) {
     6f1:	83 ec 04             	sub    $0x4,%esp
     6f4:	68 00 02 00 00       	push   $0x200
     6f9:	57                   	push   %edi
     6fa:	56                   	push   %esi
     6fb:	e8 83 04 00 00       	call   b83 <write>
     700:	83 c4 10             	add    $0x10,%esp
     703:	3d 00 02 00 00       	cmp    $0x200,%eax
     708:	75 3f                	jne    749 <create_small_file+0xb9>
        printerr("Write to file FAILED\n");
        failed();
    }
    close(fd);
     70a:	83 ec 0c             	sub    $0xc,%esp
     70d:	56                   	push   %esi
     70e:	e8 78 04 00 00       	call   b8b <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
     713:	68 00 02 00 00       	push   $0x200
     718:	ff 75 08             	push   0x8(%ebp)
     71b:	68 60 13 00 00       	push   $0x1360
     720:	6a 01                	push   $0x1
     722:	e8 b9 05 00 00       	call   ce0 <printf>
           bufflen);
    return bufflen;
}
     727:	8d 65 f4             	lea    -0xc(%ebp),%esp
     72a:	b8 00 02 00 00       	mov    $0x200,%eax
     72f:	5b                   	pop    %ebx
     730:	5e                   	pop    %esi
     731:	5f                   	pop    %edi
     732:	5d                   	pop    %ebp
     733:	c3                   	ret    
        printerr("Failed to create file %s\n", filename);
     734:	52                   	push   %edx
     735:	ff 75 08             	push   0x8(%ebp)
     738:	68 0c 13 00 00       	push   $0x130c
     73d:	6a 01                	push   $0x1
     73f:	e8 9c 05 00 00       	call   ce0 <printf>
        failed();
     744:	e8 77 fb ff ff       	call   2c0 <failed>
        printerr("Write to file FAILED\n");
     749:	50                   	push   %eax
     74a:	50                   	push   %eax
     74b:	68 38 13 00 00       	push   $0x1338
     750:	6a 01                	push   $0x1
     752:	e8 89 05 00 00       	call   ce0 <printf>
        failed();
     757:	e8 64 fb ff ff       	call   2c0 <failed>
     75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000760 <create_big_file>:

int create_big_file(char *filename, int N_PAGES, char c) {
     760:	55                   	push   %ebp
     761:	89 e5                	mov    %esp,%ebp
     763:	57                   	push   %edi
     764:	56                   	push   %esi
     765:	53                   	push   %ebx
     766:	83 ec 1c             	sub    $0x1c,%esp
     769:	0f b6 45 10          	movzbl 0x10(%ebp),%eax
     76d:	88 45 df             	mov    %al,-0x21(%ebp)
    // create a file
    int bufflen = 1024;
    char buff[bufflen];
     770:	89 e0                	mov    %esp,%eax
     772:	39 c4                	cmp    %eax,%esp
     774:	74 12                	je     788 <create_big_file+0x28>
     776:	81 ec 00 10 00 00    	sub    $0x1000,%esp
     77c:	83 8c 24 fc 0f 00 00 	orl    $0x0,0xffc(%esp)
     783:	00 
     784:	39 c4                	cmp    %eax,%esp
     786:	75 ee                	jne    776 <create_big_file+0x16>
     788:	81 ec 00 04 00 00    	sub    $0x400,%esp
     78e:	83 8c 24 fc 03 00 00 	orl    $0x0,0x3fc(%esp)
     795:	00 
     796:	89 e6                	mov    %esp,%esi
    int fd = open(filename, O_CREATE | O_RDWR);
     798:	83 ec 08             	sub    $0x8,%esp
     79b:	68 02 02 00 00       	push   $0x202
     7a0:	ff 75 08             	push   0x8(%ebp)
     7a3:	e8 fb 03 00 00       	call   ba3 <open>
    if (fd < 0) {
     7a8:	89 f4                	mov    %esi,%esp
    int fd = open(filename, O_CREATE | O_RDWR);
     7aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if (fd < 0) {
     7ad:	85 c0                	test   %eax,%eax
     7af:	0f 88 a0 00 00 00    	js     855 <create_big_file+0xf5>
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
        failed();
    }
    // write in steps as we cannot have a buffer larger than PGSIZE
    for (int pg = 0; pg < N_PAGES; pg++) {
     7b5:	8b 55 0c             	mov    0xc(%ebp),%edx
     7b8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
     7bf:	8d be 00 04 00 00    	lea    0x400(%esi),%edi
     7c5:	85 d2                	test   %edx,%edx
     7c7:	7e 61                	jle    82a <create_big_file+0xca>
     7c9:	0f b6 5d df          	movzbl -0x21(%ebp),%ebx
     7cd:	02 5d e4             	add    -0x1c(%ebp),%bl
        printf(1, "INFO: %d\n", c);
     7d0:	83 ec 04             	sub    $0x4,%esp
     7d3:	0f be c3             	movsbl %bl,%eax
     7d6:	50                   	push   %eax
     7d7:	68 6e 15 00 00       	push   $0x156e
     7dc:	6a 01                	push   $0x1
     7de:	e8 fd 04 00 00       	call   ce0 <printf>
        int nchunks = PGSIZE / bufflen;
        for (int i = 0; i < bufflen; i++)
     7e3:	89 f0                	mov    %esi,%eax
     7e5:	83 c4 10             	add    $0x10,%esp
     7e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7ef:	90                   	nop
            buff[i] = c;
     7f0:	88 18                	mov    %bl,(%eax)
        for (int i = 0; i < bufflen; i++)
     7f2:	83 c0 01             	add    $0x1,%eax
     7f5:	39 c7                	cmp    %eax,%edi
     7f7:	75 f7                	jne    7f0 <create_big_file+0x90>
     7f9:	bb 04 00 00 00       	mov    $0x4,%ebx
        for (int k = 0; k < nchunks; k++) {
            // write to file
            if (write(fd, buff, bufflen) != bufflen) {
     7fe:	83 ec 04             	sub    $0x4,%esp
     801:	68 00 04 00 00       	push   $0x400
     806:	56                   	push   %esi
     807:	ff 75 e0             	push   -0x20(%ebp)
     80a:	e8 74 03 00 00       	call   b83 <write>
     80f:	83 c4 10             	add    $0x10,%esp
     812:	3d 00 04 00 00       	cmp    $0x400,%eax
     817:	75 57                	jne    870 <create_big_file+0x110>
        for (int k = 0; k < nchunks; k++) {
     819:	83 eb 01             	sub    $0x1,%ebx
     81c:	75 e0                	jne    7fe <create_big_file+0x9e>
    for (int pg = 0; pg < N_PAGES; pg++) {
     81e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
     822:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     825:	39 45 0c             	cmp    %eax,0xc(%ebp)
     828:	75 9f                	jne    7c9 <create_big_file+0x69>
                failed();
            }
        }
        c++;
    }
    close(fd);
     82a:	83 ec 0c             	sub    $0xc,%esp
     82d:	ff 75 e0             	push   -0x20(%ebp)
     830:	e8 56 03 00 00       	call   b8b <close>
    printf(1, "INFO: Created file %s with length %d bytes. \tOkay.\n", filename,
     835:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     838:	c1 e3 0c             	shl    $0xc,%ebx
     83b:	53                   	push   %ebx
     83c:	ff 75 08             	push   0x8(%ebp)
     83f:	68 60 13 00 00       	push   $0x1360
     844:	6a 01                	push   $0x1
     846:	e8 95 04 00 00       	call   ce0 <printf>
           N_PAGES * PGSIZE);
    return N_PAGES * PGSIZE;
}
     84b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     84e:	89 d8                	mov    %ebx,%eax
     850:	5b                   	pop    %ebx
     851:	5e                   	pop    %esi
     852:	5f                   	pop    %edi
     853:	5d                   	pop    %ebp
     854:	c3                   	ret    
        printf(1, "\tCause:\tFailed to create file %s\n", filename);
     855:	50                   	push   %eax
     856:	ff 75 08             	push   0x8(%ebp)
     859:	68 94 13 00 00       	push   $0x1394
     85e:	6a 01                	push   $0x1
     860:	e8 7b 04 00 00       	call   ce0 <printf>
        failed();
     865:	e8 56 fa ff ff       	call   2c0 <failed>
     86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                printerr("Write to file FAILED %d\n", pg * bufflen);
     870:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     873:	83 ec 04             	sub    $0x4,%esp
     876:	c1 e0 0a             	shl    $0xa,%eax
     879:	50                   	push   %eax
     87a:	68 b8 13 00 00       	push   $0x13b8
     87f:	6a 01                	push   $0x1
     881:	e8 5a 04 00 00       	call   ce0 <printf>
                failed();
     886:	e8 35 fa ff ff       	call   2c0 <failed>
     88b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     88f:	90                   	nop

00000890 <open_file>:

int open_file(char *filename, int filelength) {
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	56                   	push   %esi
     894:	53                   	push   %ebx
     895:	83 ec 28             	sub    $0x28,%esp
     898:	8b 75 08             	mov    0x8(%ebp),%esi
    int fd = open(filename, O_RDWR); // open in read-write mode
     89b:	6a 02                	push   $0x2
     89d:	56                   	push   %esi
     89e:	e8 00 03 00 00       	call   ba3 <open>
    if (fd < 0) {
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	85 c0                	test   %eax,%eax
     8a8:	78 27                	js     8d1 <open_file+0x41>
        printerr("Failed to open file %s\n", filename);
        failed();
    }
    struct stat st;
    if (fstat(fd, &st) < 0) {
     8aa:	83 ec 08             	sub    $0x8,%esp
     8ad:	89 c3                	mov    %eax,%ebx
     8af:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8b2:	50                   	push   %eax
     8b3:	53                   	push   %ebx
     8b4:	e8 02 03 00 00       	call   bbb <fstat>
     8b9:	83 c4 10             	add    $0x10,%esp
     8bc:	85 c0                	test   %eax,%eax
     8be:	78 39                	js     8f9 <open_file+0x69>
        printerr("Failed to get file stat\n");
        failed();
    }
    if (st.size != filelength) {
     8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
     8c6:	75 1c                	jne    8e4 <open_file+0x54>
        printerr("File size = %d, expected %d\n", st.size, filelength);
        failed();
    }
    return fd;
}
     8c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
     8cb:	89 d8                	mov    %ebx,%eax
     8cd:	5b                   	pop    %ebx
     8ce:	5e                   	pop    %esi
     8cf:	5d                   	pop    %ebp
     8d0:	c3                   	ret    
        printerr("Failed to open file %s\n", filename);
     8d1:	52                   	push   %edx
     8d2:	56                   	push   %esi
     8d3:	68 e4 13 00 00       	push   $0x13e4
     8d8:	6a 01                	push   $0x1
     8da:	e8 01 04 00 00       	call   ce0 <printf>
        failed();
     8df:	e8 dc f9 ff ff       	call   2c0 <failed>
        printerr("File size = %d, expected %d\n", st.size, filelength);
     8e4:	ff 75 0c             	push   0xc(%ebp)
     8e7:	50                   	push   %eax
     8e8:	68 3c 14 00 00       	push   $0x143c
     8ed:	6a 01                	push   $0x1
     8ef:	e8 ec 03 00 00       	call   ce0 <printf>
        failed();
     8f4:	e8 c7 f9 ff ff       	call   2c0 <failed>
        printerr("Failed to get file stat\n");
     8f9:	50                   	push   %eax
     8fa:	50                   	push   %eax
     8fb:	68 10 14 00 00       	push   $0x1410
     900:	6a 01                	push   $0x1
     902:	e8 d9 03 00 00       	call   ce0 <printf>
        failed();
     907:	e8 b4 f9 ff ff       	call   2c0 <failed>
     90c:	66 90                	xchg   %ax,%ax
     90e:	66 90                	xchg   %ax,%ax

00000910 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     910:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     911:	31 c0                	xor    %eax,%eax
{
     913:	89 e5                	mov    %esp,%ebp
     915:	53                   	push   %ebx
     916:	8b 4d 08             	mov    0x8(%ebp),%ecx
     919:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     920:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     924:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     927:	83 c0 01             	add    $0x1,%eax
     92a:	84 d2                	test   %dl,%dl
     92c:	75 f2                	jne    920 <strcpy+0x10>
    ;
  return os;
}
     92e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     931:	89 c8                	mov    %ecx,%eax
     933:	c9                   	leave  
     934:	c3                   	ret    
     935:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     93c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000940 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     940:	55                   	push   %ebp
     941:	89 e5                	mov    %esp,%ebp
     943:	53                   	push   %ebx
     944:	8b 55 08             	mov    0x8(%ebp),%edx
     947:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     94a:	0f b6 02             	movzbl (%edx),%eax
     94d:	84 c0                	test   %al,%al
     94f:	75 17                	jne    968 <strcmp+0x28>
     951:	eb 3a                	jmp    98d <strcmp+0x4d>
     953:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     957:	90                   	nop
     958:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     95c:	83 c2 01             	add    $0x1,%edx
     95f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     962:	84 c0                	test   %al,%al
     964:	74 1a                	je     980 <strcmp+0x40>
    p++, q++;
     966:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     968:	0f b6 19             	movzbl (%ecx),%ebx
     96b:	38 c3                	cmp    %al,%bl
     96d:	74 e9                	je     958 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     96f:	29 d8                	sub    %ebx,%eax
}
     971:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     974:	c9                   	leave  
     975:	c3                   	ret    
     976:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     97d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     980:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     984:	31 c0                	xor    %eax,%eax
     986:	29 d8                	sub    %ebx,%eax
}
     988:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     98b:	c9                   	leave  
     98c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
     98d:	0f b6 19             	movzbl (%ecx),%ebx
     990:	31 c0                	xor    %eax,%eax
     992:	eb db                	jmp    96f <strcmp+0x2f>
     994:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     99b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     99f:	90                   	nop

000009a0 <strlen>:

uint
strlen(const char *s)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     9a6:	80 3a 00             	cmpb   $0x0,(%edx)
     9a9:	74 15                	je     9c0 <strlen+0x20>
     9ab:	31 c0                	xor    %eax,%eax
     9ad:	8d 76 00             	lea    0x0(%esi),%esi
     9b0:	83 c0 01             	add    $0x1,%eax
     9b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     9b7:	89 c1                	mov    %eax,%ecx
     9b9:	75 f5                	jne    9b0 <strlen+0x10>
    ;
  return n;
}
     9bb:	89 c8                	mov    %ecx,%eax
     9bd:	5d                   	pop    %ebp
     9be:	c3                   	ret    
     9bf:	90                   	nop
  for(n = 0; s[n]; n++)
     9c0:	31 c9                	xor    %ecx,%ecx
}
     9c2:	5d                   	pop    %ebp
     9c3:	89 c8                	mov    %ecx,%eax
     9c5:	c3                   	ret    
     9c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9cd:	8d 76 00             	lea    0x0(%esi),%esi

000009d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	57                   	push   %edi
     9d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     9d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     9da:	8b 45 0c             	mov    0xc(%ebp),%eax
     9dd:	89 d7                	mov    %edx,%edi
     9df:	fc                   	cld    
     9e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     9e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     9e5:	89 d0                	mov    %edx,%eax
     9e7:	c9                   	leave  
     9e8:	c3                   	ret    
     9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009f0 <strchr>:

char*
strchr(const char *s, char c)
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	8b 45 08             	mov    0x8(%ebp),%eax
     9f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     9fa:	0f b6 10             	movzbl (%eax),%edx
     9fd:	84 d2                	test   %dl,%dl
     9ff:	75 12                	jne    a13 <strchr+0x23>
     a01:	eb 1d                	jmp    a20 <strchr+0x30>
     a03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a07:	90                   	nop
     a08:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     a0c:	83 c0 01             	add    $0x1,%eax
     a0f:	84 d2                	test   %dl,%dl
     a11:	74 0d                	je     a20 <strchr+0x30>
    if(*s == c)
     a13:	38 d1                	cmp    %dl,%cl
     a15:	75 f1                	jne    a08 <strchr+0x18>
      return (char*)s;
  return 0;
}
     a17:	5d                   	pop    %ebp
     a18:	c3                   	ret    
     a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     a20:	31 c0                	xor    %eax,%eax
}
     a22:	5d                   	pop    %ebp
     a23:	c3                   	ret    
     a24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a2f:	90                   	nop

00000a30 <gets>:

char*
gets(char *buf, int max)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     a35:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
     a38:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     a39:	31 db                	xor    %ebx,%ebx
{
     a3b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     a3e:	eb 27                	jmp    a67 <gets+0x37>
    cc = read(0, &c, 1);
     a40:	83 ec 04             	sub    $0x4,%esp
     a43:	6a 01                	push   $0x1
     a45:	57                   	push   %edi
     a46:	6a 00                	push   $0x0
     a48:	e8 2e 01 00 00       	call   b7b <read>
    if(cc < 1)
     a4d:	83 c4 10             	add    $0x10,%esp
     a50:	85 c0                	test   %eax,%eax
     a52:	7e 1d                	jle    a71 <gets+0x41>
      break;
    buf[i++] = c;
     a54:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     a58:	8b 55 08             	mov    0x8(%ebp),%edx
     a5b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     a5f:	3c 0a                	cmp    $0xa,%al
     a61:	74 1d                	je     a80 <gets+0x50>
     a63:	3c 0d                	cmp    $0xd,%al
     a65:	74 19                	je     a80 <gets+0x50>
  for(i=0; i+1 < max; ){
     a67:	89 de                	mov    %ebx,%esi
     a69:	83 c3 01             	add    $0x1,%ebx
     a6c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     a6f:	7c cf                	jl     a40 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     a71:	8b 45 08             	mov    0x8(%ebp),%eax
     a74:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a7b:	5b                   	pop    %ebx
     a7c:	5e                   	pop    %esi
     a7d:	5f                   	pop    %edi
     a7e:	5d                   	pop    %ebp
     a7f:	c3                   	ret    
  buf[i] = '\0';
     a80:	8b 45 08             	mov    0x8(%ebp),%eax
     a83:	89 de                	mov    %ebx,%esi
     a85:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
     a89:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a8c:	5b                   	pop    %ebx
     a8d:	5e                   	pop    %esi
     a8e:	5f                   	pop    %edi
     a8f:	5d                   	pop    %ebp
     a90:	c3                   	ret    
     a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a9f:	90                   	nop

00000aa0 <stat>:

int
stat(const char *n, struct stat *st)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	56                   	push   %esi
     aa4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     aa5:	83 ec 08             	sub    $0x8,%esp
     aa8:	6a 00                	push   $0x0
     aaa:	ff 75 08             	push   0x8(%ebp)
     aad:	e8 f1 00 00 00       	call   ba3 <open>
  if(fd < 0)
     ab2:	83 c4 10             	add    $0x10,%esp
     ab5:	85 c0                	test   %eax,%eax
     ab7:	78 27                	js     ae0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     ab9:	83 ec 08             	sub    $0x8,%esp
     abc:	ff 75 0c             	push   0xc(%ebp)
     abf:	89 c3                	mov    %eax,%ebx
     ac1:	50                   	push   %eax
     ac2:	e8 f4 00 00 00       	call   bbb <fstat>
  close(fd);
     ac7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     aca:	89 c6                	mov    %eax,%esi
  close(fd);
     acc:	e8 ba 00 00 00       	call   b8b <close>
  return r;
     ad1:	83 c4 10             	add    $0x10,%esp
}
     ad4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ad7:	89 f0                	mov    %esi,%eax
     ad9:	5b                   	pop    %ebx
     ada:	5e                   	pop    %esi
     adb:	5d                   	pop    %ebp
     adc:	c3                   	ret    
     add:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     ae0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ae5:	eb ed                	jmp    ad4 <stat+0x34>
     ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aee:	66 90                	xchg   %ax,%ax

00000af0 <atoi>:

int
atoi(const char *s)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     af7:	0f be 02             	movsbl (%edx),%eax
     afa:	8d 48 d0             	lea    -0x30(%eax),%ecx
     afd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     b00:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     b05:	77 1e                	ja     b25 <atoi+0x35>
     b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b0e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     b10:	83 c2 01             	add    $0x1,%edx
     b13:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     b16:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     b1a:	0f be 02             	movsbl (%edx),%eax
     b1d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     b20:	80 fb 09             	cmp    $0x9,%bl
     b23:	76 eb                	jbe    b10 <atoi+0x20>
  return n;
}
     b25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b28:	89 c8                	mov    %ecx,%eax
     b2a:	c9                   	leave  
     b2b:	c3                   	ret    
     b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b30 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	57                   	push   %edi
     b34:	8b 45 10             	mov    0x10(%ebp),%eax
     b37:	8b 55 08             	mov    0x8(%ebp),%edx
     b3a:	56                   	push   %esi
     b3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     b3e:	85 c0                	test   %eax,%eax
     b40:	7e 13                	jle    b55 <memmove+0x25>
     b42:	01 d0                	add    %edx,%eax
  dst = vdst;
     b44:	89 d7                	mov    %edx,%edi
     b46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b4d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     b50:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     b51:	39 f8                	cmp    %edi,%eax
     b53:	75 fb                	jne    b50 <memmove+0x20>
  return vdst;
}
     b55:	5e                   	pop    %esi
     b56:	89 d0                	mov    %edx,%eax
     b58:	5f                   	pop    %edi
     b59:	5d                   	pop    %ebp
     b5a:	c3                   	ret    

00000b5b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     b5b:	b8 01 00 00 00       	mov    $0x1,%eax
     b60:	cd 40                	int    $0x40
     b62:	c3                   	ret    

00000b63 <exit>:
SYSCALL(exit)
     b63:	b8 02 00 00 00       	mov    $0x2,%eax
     b68:	cd 40                	int    $0x40
     b6a:	c3                   	ret    

00000b6b <wait>:
SYSCALL(wait)
     b6b:	b8 03 00 00 00       	mov    $0x3,%eax
     b70:	cd 40                	int    $0x40
     b72:	c3                   	ret    

00000b73 <pipe>:
SYSCALL(pipe)
     b73:	b8 04 00 00 00       	mov    $0x4,%eax
     b78:	cd 40                	int    $0x40
     b7a:	c3                   	ret    

00000b7b <read>:
SYSCALL(read)
     b7b:	b8 05 00 00 00       	mov    $0x5,%eax
     b80:	cd 40                	int    $0x40
     b82:	c3                   	ret    

00000b83 <write>:
SYSCALL(write)
     b83:	b8 10 00 00 00       	mov    $0x10,%eax
     b88:	cd 40                	int    $0x40
     b8a:	c3                   	ret    

00000b8b <close>:
SYSCALL(close)
     b8b:	b8 15 00 00 00       	mov    $0x15,%eax
     b90:	cd 40                	int    $0x40
     b92:	c3                   	ret    

00000b93 <kill>:
SYSCALL(kill)
     b93:	b8 06 00 00 00       	mov    $0x6,%eax
     b98:	cd 40                	int    $0x40
     b9a:	c3                   	ret    

00000b9b <exec>:
SYSCALL(exec)
     b9b:	b8 07 00 00 00       	mov    $0x7,%eax
     ba0:	cd 40                	int    $0x40
     ba2:	c3                   	ret    

00000ba3 <open>:
SYSCALL(open)
     ba3:	b8 0f 00 00 00       	mov    $0xf,%eax
     ba8:	cd 40                	int    $0x40
     baa:	c3                   	ret    

00000bab <mknod>:
SYSCALL(mknod)
     bab:	b8 11 00 00 00       	mov    $0x11,%eax
     bb0:	cd 40                	int    $0x40
     bb2:	c3                   	ret    

00000bb3 <unlink>:
SYSCALL(unlink)
     bb3:	b8 12 00 00 00       	mov    $0x12,%eax
     bb8:	cd 40                	int    $0x40
     bba:	c3                   	ret    

00000bbb <fstat>:
SYSCALL(fstat)
     bbb:	b8 08 00 00 00       	mov    $0x8,%eax
     bc0:	cd 40                	int    $0x40
     bc2:	c3                   	ret    

00000bc3 <link>:
SYSCALL(link)
     bc3:	b8 13 00 00 00       	mov    $0x13,%eax
     bc8:	cd 40                	int    $0x40
     bca:	c3                   	ret    

00000bcb <mkdir>:
SYSCALL(mkdir)
     bcb:	b8 14 00 00 00       	mov    $0x14,%eax
     bd0:	cd 40                	int    $0x40
     bd2:	c3                   	ret    

00000bd3 <chdir>:
SYSCALL(chdir)
     bd3:	b8 09 00 00 00       	mov    $0x9,%eax
     bd8:	cd 40                	int    $0x40
     bda:	c3                   	ret    

00000bdb <dup>:
SYSCALL(dup)
     bdb:	b8 0a 00 00 00       	mov    $0xa,%eax
     be0:	cd 40                	int    $0x40
     be2:	c3                   	ret    

00000be3 <getpid>:
SYSCALL(getpid)
     be3:	b8 0b 00 00 00       	mov    $0xb,%eax
     be8:	cd 40                	int    $0x40
     bea:	c3                   	ret    

00000beb <sbrk>:
SYSCALL(sbrk)
     beb:	b8 0c 00 00 00       	mov    $0xc,%eax
     bf0:	cd 40                	int    $0x40
     bf2:	c3                   	ret    

00000bf3 <sleep>:
SYSCALL(sleep)
     bf3:	b8 0d 00 00 00       	mov    $0xd,%eax
     bf8:	cd 40                	int    $0x40
     bfa:	c3                   	ret    

00000bfb <uptime>:
SYSCALL(uptime)
     bfb:	b8 0e 00 00 00       	mov    $0xe,%eax
     c00:	cd 40                	int    $0x40
     c02:	c3                   	ret    

00000c03 <wmap>:
SYSCALL(wmap)
     c03:	b8 16 00 00 00       	mov    $0x16,%eax
     c08:	cd 40                	int    $0x40
     c0a:	c3                   	ret    

00000c0b <va2pa>:
SYSCALL(va2pa)
     c0b:	b8 17 00 00 00       	mov    $0x17,%eax
     c10:	cd 40                	int    $0x40
     c12:	c3                   	ret    

00000c13 <wunmap>:
SYSCALL(wunmap)
     c13:	b8 18 00 00 00       	mov    $0x18,%eax
     c18:	cd 40                	int    $0x40
     c1a:	c3                   	ret    

00000c1b <getwmapinfo>:
SYSCALL(getwmapinfo)
     c1b:	b8 19 00 00 00       	mov    $0x19,%eax
     c20:	cd 40                	int    $0x40
     c22:	c3                   	ret    
     c23:	66 90                	xchg   %ax,%ax
     c25:	66 90                	xchg   %ax,%ax
     c27:	66 90                	xchg   %ax,%ax
     c29:	66 90                	xchg   %ax,%ax
     c2b:	66 90                	xchg   %ax,%ax
     c2d:	66 90                	xchg   %ax,%ax
     c2f:	90                   	nop

00000c30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	57                   	push   %edi
     c34:	56                   	push   %esi
     c35:	53                   	push   %ebx
     c36:	83 ec 3c             	sub    $0x3c,%esp
     c39:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     c3c:	89 d1                	mov    %edx,%ecx
{
     c3e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
     c41:	85 d2                	test   %edx,%edx
     c43:	0f 89 7f 00 00 00    	jns    cc8 <printint+0x98>
     c49:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     c4d:	74 79                	je     cc8 <printint+0x98>
    neg = 1;
     c4f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     c56:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
     c58:	31 db                	xor    %ebx,%ebx
     c5a:	8d 75 d7             	lea    -0x29(%ebp),%esi
     c5d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     c60:	89 c8                	mov    %ecx,%eax
     c62:	31 d2                	xor    %edx,%edx
     c64:	89 cf                	mov    %ecx,%edi
     c66:	f7 75 c4             	divl   -0x3c(%ebp)
     c69:	0f b6 92 f0 15 00 00 	movzbl 0x15f0(%edx),%edx
     c70:	89 45 c0             	mov    %eax,-0x40(%ebp)
     c73:	89 d8                	mov    %ebx,%eax
     c75:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
     c78:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
     c7b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
     c7e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
     c81:	76 dd                	jbe    c60 <printint+0x30>
  if(neg)
     c83:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     c86:	85 c9                	test   %ecx,%ecx
     c88:	74 0c                	je     c96 <printint+0x66>
    buf[i++] = '-';
     c8a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
     c8f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
     c91:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
     c96:	8b 7d b8             	mov    -0x48(%ebp),%edi
     c99:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     c9d:	eb 07                	jmp    ca6 <printint+0x76>
     c9f:	90                   	nop
    putc(fd, buf[i]);
     ca0:	0f b6 13             	movzbl (%ebx),%edx
     ca3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
     ca6:	83 ec 04             	sub    $0x4,%esp
     ca9:	88 55 d7             	mov    %dl,-0x29(%ebp)
     cac:	6a 01                	push   $0x1
     cae:	56                   	push   %esi
     caf:	57                   	push   %edi
     cb0:	e8 ce fe ff ff       	call   b83 <write>
  while(--i >= 0)
     cb5:	83 c4 10             	add    $0x10,%esp
     cb8:	39 de                	cmp    %ebx,%esi
     cba:	75 e4                	jne    ca0 <printint+0x70>
}
     cbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cbf:	5b                   	pop    %ebx
     cc0:	5e                   	pop    %esi
     cc1:	5f                   	pop    %edi
     cc2:	5d                   	pop    %ebp
     cc3:	c3                   	ret    
     cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     cc8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     ccf:	eb 87                	jmp    c58 <printint+0x28>
     cd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cd8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cdf:	90                   	nop

00000ce0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ce9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
     cec:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
     cef:	0f b6 13             	movzbl (%ebx),%edx
     cf2:	84 d2                	test   %dl,%dl
     cf4:	74 6a                	je     d60 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
     cf6:	8d 45 10             	lea    0x10(%ebp),%eax
     cf9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
     cfc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
     cff:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
     d01:	89 45 d0             	mov    %eax,-0x30(%ebp)
     d04:	eb 36                	jmp    d3c <printf+0x5c>
     d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d0d:	8d 76 00             	lea    0x0(%esi),%esi
     d10:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     d13:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
     d18:	83 f8 25             	cmp    $0x25,%eax
     d1b:	74 15                	je     d32 <printf+0x52>
  write(fd, &c, 1);
     d1d:	83 ec 04             	sub    $0x4,%esp
     d20:	88 55 e7             	mov    %dl,-0x19(%ebp)
     d23:	6a 01                	push   $0x1
     d25:	57                   	push   %edi
     d26:	56                   	push   %esi
     d27:	e8 57 fe ff ff       	call   b83 <write>
     d2c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
     d2f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     d32:	0f b6 13             	movzbl (%ebx),%edx
     d35:	83 c3 01             	add    $0x1,%ebx
     d38:	84 d2                	test   %dl,%dl
     d3a:	74 24                	je     d60 <printf+0x80>
    c = fmt[i] & 0xff;
     d3c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
     d3f:	85 c9                	test   %ecx,%ecx
     d41:	74 cd                	je     d10 <printf+0x30>
      }
    } else if(state == '%'){
     d43:	83 f9 25             	cmp    $0x25,%ecx
     d46:	75 ea                	jne    d32 <printf+0x52>
      if(c == 'd'){
     d48:	83 f8 25             	cmp    $0x25,%eax
     d4b:	0f 84 07 01 00 00    	je     e58 <printf+0x178>
     d51:	83 e8 63             	sub    $0x63,%eax
     d54:	83 f8 15             	cmp    $0x15,%eax
     d57:	77 17                	ja     d70 <printf+0x90>
     d59:	ff 24 85 98 15 00 00 	jmp    *0x1598(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     d60:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d63:	5b                   	pop    %ebx
     d64:	5e                   	pop    %esi
     d65:	5f                   	pop    %edi
     d66:	5d                   	pop    %ebp
     d67:	c3                   	ret    
     d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d6f:	90                   	nop
  write(fd, &c, 1);
     d70:	83 ec 04             	sub    $0x4,%esp
     d73:	88 55 d4             	mov    %dl,-0x2c(%ebp)
     d76:	6a 01                	push   $0x1
     d78:	57                   	push   %edi
     d79:	56                   	push   %esi
     d7a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     d7e:	e8 00 fe ff ff       	call   b83 <write>
        putc(fd, c);
     d83:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
     d87:	83 c4 0c             	add    $0xc,%esp
     d8a:	88 55 e7             	mov    %dl,-0x19(%ebp)
     d8d:	6a 01                	push   $0x1
     d8f:	57                   	push   %edi
     d90:	56                   	push   %esi
     d91:	e8 ed fd ff ff       	call   b83 <write>
        putc(fd, c);
     d96:	83 c4 10             	add    $0x10,%esp
      state = 0;
     d99:	31 c9                	xor    %ecx,%ecx
     d9b:	eb 95                	jmp    d32 <printf+0x52>
     d9d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     da0:	83 ec 0c             	sub    $0xc,%esp
     da3:	b9 10 00 00 00       	mov    $0x10,%ecx
     da8:	6a 00                	push   $0x0
     daa:	8b 45 d0             	mov    -0x30(%ebp),%eax
     dad:	8b 10                	mov    (%eax),%edx
     daf:	89 f0                	mov    %esi,%eax
     db1:	e8 7a fe ff ff       	call   c30 <printint>
        ap++;
     db6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
     dba:	83 c4 10             	add    $0x10,%esp
      state = 0;
     dbd:	31 c9                	xor    %ecx,%ecx
     dbf:	e9 6e ff ff ff       	jmp    d32 <printf+0x52>
     dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     dc8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     dcb:	8b 10                	mov    (%eax),%edx
        ap++;
     dcd:	83 c0 04             	add    $0x4,%eax
     dd0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     dd3:	85 d2                	test   %edx,%edx
     dd5:	0f 84 8d 00 00 00    	je     e68 <printf+0x188>
        while(*s != 0){
     ddb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
     dde:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
     de0:	84 c0                	test   %al,%al
     de2:	0f 84 4a ff ff ff    	je     d32 <printf+0x52>
     de8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     deb:	89 d3                	mov    %edx,%ebx
     ded:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     df0:	83 ec 04             	sub    $0x4,%esp
          s++;
     df3:	83 c3 01             	add    $0x1,%ebx
     df6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     df9:	6a 01                	push   $0x1
     dfb:	57                   	push   %edi
     dfc:	56                   	push   %esi
     dfd:	e8 81 fd ff ff       	call   b83 <write>
        while(*s != 0){
     e02:	0f b6 03             	movzbl (%ebx),%eax
     e05:	83 c4 10             	add    $0x10,%esp
     e08:	84 c0                	test   %al,%al
     e0a:	75 e4                	jne    df0 <printf+0x110>
      state = 0;
     e0c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
     e0f:	31 c9                	xor    %ecx,%ecx
     e11:	e9 1c ff ff ff       	jmp    d32 <printf+0x52>
     e16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     e20:	83 ec 0c             	sub    $0xc,%esp
     e23:	b9 0a 00 00 00       	mov    $0xa,%ecx
     e28:	6a 01                	push   $0x1
     e2a:	e9 7b ff ff ff       	jmp    daa <printf+0xca>
     e2f:	90                   	nop
        putc(fd, *ap);
     e30:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
     e33:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     e36:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
     e38:	6a 01                	push   $0x1
     e3a:	57                   	push   %edi
     e3b:	56                   	push   %esi
        putc(fd, *ap);
     e3c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     e3f:	e8 3f fd ff ff       	call   b83 <write>
        ap++;
     e44:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
     e48:	83 c4 10             	add    $0x10,%esp
      state = 0;
     e4b:	31 c9                	xor    %ecx,%ecx
     e4d:	e9 e0 fe ff ff       	jmp    d32 <printf+0x52>
     e52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
     e58:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e5b:	83 ec 04             	sub    $0x4,%esp
     e5e:	e9 2a ff ff ff       	jmp    d8d <printf+0xad>
     e63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e67:	90                   	nop
          s = "(null)";
     e68:	ba 8f 15 00 00       	mov    $0x158f,%edx
        while(*s != 0){
     e6d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
     e70:	b8 28 00 00 00       	mov    $0x28,%eax
     e75:	89 d3                	mov    %edx,%ebx
     e77:	e9 74 ff ff ff       	jmp    df0 <printf+0x110>
     e7c:	66 90                	xchg   %ax,%ax
     e7e:	66 90                	xchg   %ax,%ax

00000e80 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e80:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e81:	a1 d4 1a 00 00       	mov    0x1ad4,%eax
{
     e86:	89 e5                	mov    %esp,%ebp
     e88:	57                   	push   %edi
     e89:	56                   	push   %esi
     e8a:	53                   	push   %ebx
     e8b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     e8e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e98:	89 c2                	mov    %eax,%edx
     e9a:	8b 00                	mov    (%eax),%eax
     e9c:	39 ca                	cmp    %ecx,%edx
     e9e:	73 30                	jae    ed0 <free+0x50>
     ea0:	39 c1                	cmp    %eax,%ecx
     ea2:	72 04                	jb     ea8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ea4:	39 c2                	cmp    %eax,%edx
     ea6:	72 f0                	jb     e98 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ea8:	8b 73 fc             	mov    -0x4(%ebx),%esi
     eab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     eae:	39 f8                	cmp    %edi,%eax
     eb0:	74 30                	je     ee2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
     eb2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
     eb5:	8b 42 04             	mov    0x4(%edx),%eax
     eb8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
     ebb:	39 f1                	cmp    %esi,%ecx
     ebd:	74 3a                	je     ef9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
     ebf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
     ec1:	5b                   	pop    %ebx
  freep = p;
     ec2:	89 15 d4 1a 00 00    	mov    %edx,0x1ad4
}
     ec8:	5e                   	pop    %esi
     ec9:	5f                   	pop    %edi
     eca:	5d                   	pop    %ebp
     ecb:	c3                   	ret    
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ed0:	39 c2                	cmp    %eax,%edx
     ed2:	72 c4                	jb     e98 <free+0x18>
     ed4:	39 c1                	cmp    %eax,%ecx
     ed6:	73 c0                	jae    e98 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
     ed8:	8b 73 fc             	mov    -0x4(%ebx),%esi
     edb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     ede:	39 f8                	cmp    %edi,%eax
     ee0:	75 d0                	jne    eb2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
     ee2:	03 70 04             	add    0x4(%eax),%esi
     ee5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     ee8:	8b 02                	mov    (%edx),%eax
     eea:	8b 00                	mov    (%eax),%eax
     eec:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
     eef:	8b 42 04             	mov    0x4(%edx),%eax
     ef2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
     ef5:	39 f1                	cmp    %esi,%ecx
     ef7:	75 c6                	jne    ebf <free+0x3f>
    p->s.size += bp->s.size;
     ef9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
     efc:	89 15 d4 1a 00 00    	mov    %edx,0x1ad4
    p->s.size += bp->s.size;
     f02:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
     f05:	8b 4b f8             	mov    -0x8(%ebx),%ecx
     f08:	89 0a                	mov    %ecx,(%edx)
}
     f0a:	5b                   	pop    %ebx
     f0b:	5e                   	pop    %esi
     f0c:	5f                   	pop    %edi
     f0d:	5d                   	pop    %ebp
     f0e:	c3                   	ret    
     f0f:	90                   	nop

00000f10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
     f15:	53                   	push   %ebx
     f16:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
     f1c:	8b 3d d4 1a 00 00    	mov    0x1ad4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     f22:	8d 70 07             	lea    0x7(%eax),%esi
     f25:	c1 ee 03             	shr    $0x3,%esi
     f28:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
     f2b:	85 ff                	test   %edi,%edi
     f2d:	0f 84 9d 00 00 00    	je     fd0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f33:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
     f35:	8b 4a 04             	mov    0x4(%edx),%ecx
     f38:	39 f1                	cmp    %esi,%ecx
     f3a:	73 6a                	jae    fa6 <malloc+0x96>
     f3c:	bb 00 10 00 00       	mov    $0x1000,%ebx
     f41:	39 de                	cmp    %ebx,%esi
     f43:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
     f46:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
     f4d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     f50:	eb 17                	jmp    f69 <malloc+0x59>
     f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f58:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
     f5a:	8b 48 04             	mov    0x4(%eax),%ecx
     f5d:	39 f1                	cmp    %esi,%ecx
     f5f:	73 4f                	jae    fb0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
     f61:	8b 3d d4 1a 00 00    	mov    0x1ad4,%edi
     f67:	89 c2                	mov    %eax,%edx
     f69:	39 d7                	cmp    %edx,%edi
     f6b:	75 eb                	jne    f58 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
     f6d:	83 ec 0c             	sub    $0xc,%esp
     f70:	ff 75 e4             	push   -0x1c(%ebp)
     f73:	e8 73 fc ff ff       	call   beb <sbrk>
  if(p == (char*)-1)
     f78:	83 c4 10             	add    $0x10,%esp
     f7b:	83 f8 ff             	cmp    $0xffffffff,%eax
     f7e:	74 1c                	je     f9c <malloc+0x8c>
  hp->s.size = nu;
     f80:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
     f83:	83 ec 0c             	sub    $0xc,%esp
     f86:	83 c0 08             	add    $0x8,%eax
     f89:	50                   	push   %eax
     f8a:	e8 f1 fe ff ff       	call   e80 <free>
  return freep;
     f8f:	8b 15 d4 1a 00 00    	mov    0x1ad4,%edx
      if((p = morecore(nunits)) == 0)
     f95:	83 c4 10             	add    $0x10,%esp
     f98:	85 d2                	test   %edx,%edx
     f9a:	75 bc                	jne    f58 <malloc+0x48>
        return 0;
  }
}
     f9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
     f9f:	31 c0                	xor    %eax,%eax
}
     fa1:	5b                   	pop    %ebx
     fa2:	5e                   	pop    %esi
     fa3:	5f                   	pop    %edi
     fa4:	5d                   	pop    %ebp
     fa5:	c3                   	ret    
    if(p->s.size >= nunits){
     fa6:	89 d0                	mov    %edx,%eax
     fa8:	89 fa                	mov    %edi,%edx
     faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
     fb0:	39 ce                	cmp    %ecx,%esi
     fb2:	74 4c                	je     1000 <malloc+0xf0>
        p->s.size -= nunits;
     fb4:	29 f1                	sub    %esi,%ecx
     fb6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
     fb9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
     fbc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
     fbf:	89 15 d4 1a 00 00    	mov    %edx,0x1ad4
}
     fc5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
     fc8:	83 c0 08             	add    $0x8,%eax
}
     fcb:	5b                   	pop    %ebx
     fcc:	5e                   	pop    %esi
     fcd:	5f                   	pop    %edi
     fce:	5d                   	pop    %ebp
     fcf:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
     fd0:	c7 05 d4 1a 00 00 d8 	movl   $0x1ad8,0x1ad4
     fd7:	1a 00 00 
    base.s.size = 0;
     fda:	bf d8 1a 00 00       	mov    $0x1ad8,%edi
    base.s.ptr = freep = prevp = &base;
     fdf:	c7 05 d8 1a 00 00 d8 	movl   $0x1ad8,0x1ad8
     fe6:	1a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     fe9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
     feb:	c7 05 dc 1a 00 00 00 	movl   $0x0,0x1adc
     ff2:	00 00 00 
    if(p->s.size >= nunits){
     ff5:	e9 42 ff ff ff       	jmp    f3c <malloc+0x2c>
     ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1000:	8b 08                	mov    (%eax),%ecx
    1002:	89 0a                	mov    %ecx,(%edx)
    1004:	eb b9                	jmp    fbf <malloc+0xaf>
