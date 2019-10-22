This is a must!

# How to

This one is tougher - from Mega Meghan (unfinished) to Cheman. (i.e. how to make a new game using MK3 NESOM, part 2).

## Do it

This one needs tile_get, so I wether store the maps in a dumbed down version or I think on something else. I think the dumbed down way is better 'cause this will make both code and my life easier. After all, maps are not too big: 20 screens. But tilesets are 32 tiles big. Crap. 20 * 192 is just too much memory. 

It's never as easy as it seems when you think about it the first time.

Let's see - the AGNES way would need 24 bytes per screen to store the objects you have collected already, that means 480 bytes. From the original NES version, the maps take about 1900 bytes (the biggest, level 1). That means that I have to reserve 2380 bytes vs. storing the maps uncompressed which would take 3840 bytes. I think this is the way to go, specially if I manage to make the related code small.

We'll, let's do it.

This game features scripting in the NES MK2 version ("Dire Job") and code injection in the AGNES version ("Cheman"). I will implement it via customs, NES MK2 / MK3_OM style.

Because don't forget that the MK3_OM engine is a port of NES MK2. Which is older than AGNES. So stuff from AGNES needs to be ported as well. And...

Bleugh. 

This will also test the `ONLY_ONE_OBJECT` feature in this port. Which probably won't work as I believe I translated the hotspots management to assembly so ... you know the drill.

## Remember

I copy this excerpt from the previous howto (Mega Megan's) because it's super important and I keep forgetting everything about it. And because the system has been updated.

### How the sprite system works

There are **sprite cells** and **software sprites** which are completely different entities. 

**software sprites** refer to the actual moving objects on screen. Each related sprite structure carries a couple of function pointers which point to the correct CPCRSlib functions needed to render the objects, based upon their size - this way you can mix different sprite sizes. This has to be set up in `system_cpc.h` when allocation the software sprites. Most likely, you won't have to touch `cpc_screen_update` anymore.

**sprite cells** refer to graphics. The `sprite_cells` array contains a pointer to each sprite cell used in the game. These may be of different sizes, so `sprite_cells` should be built accordingly. `sprite_cells_init` does a cheesy, time and space consuming calculation I should be changing with a static const array definition ASAP. How to generate this array is still in the air. All this stuff is in `assets/spriteset.h`. 

## Graphics

The order of items in this game is 

```c
    #define HOTSPOT_TYPE_OBJECT     1
    #define HOTSPOT_TYPE_KEYS       2
    #define HOTSPOT_TYPE_REFILL     3
```

Which happens to be typical for ZX MK1, ZX MK2 and AGNES.

Got assets for level 1 from Anjuel. Need to do some rearrangement but overall they work. 

- Write a BG TS converter, `/ports/cpc/gfx/ts.spt`. This game has a different tileset for each level, so these get converted later.

- This is the configuration in `ram/heap.h`: this makes room for up to 96 patterns (16 x 96 = 1536) so we have to be careful with the tilesets!

```
        XDEF _ts
        XDEF tiles
    ._ts
    .tiles
        BINARY "../ports/cpc/bin/ts.bin"
    ._ts0
        defs 1536
```

Note how I've added a `._ts0` label with space for 96 patterns. This will be were we'll be decompressing the patterns for each level. This is done in the "Level X assets" sections in `buildbins_cpc.bat` !!

Note how the tmapoffs is 100 as the compressed tilesets will be decompresed right after the fixed patterns which are 64 for the font plus 36 more used in the fixed screens.

```
    ..\utils\mkts_om.exe platform=cpc mode=mapped  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ts0.png out=..\ports\cpc\bin\level0\ts size=8,5 metasize=2,2 tmapoffs=100 max=36 silent 

    ..\utils\mkts_om.exe platform=cpc mode=mapped  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ts1.png out=..\ports\cpc\bin\level1\ts size=8,5 metasize=2,2 tmapoffs=100 max=36 silent 
```

- Adjust the spriteset importer section in `buildbins_cpc.bat`. I have these files with assets:

```
    ssch.png        - Cheman                12 (6x2) 2x3 sprite cells   ssch.bin
    ssempty.png     - Empty sprite face     1 (1x1) 2x3 sprite cells    ssempty.bin
    ssen.png        - Enemies               6 (6x1) 2x3 sprite cells    ssen.bin
    sssmall.png     - Projectiles           1 (1x1) 1x1 sprite cell     sssmall.bin
    ssextra.png     - Explosion & skull     2 (2x1) 2x2 sprite cells    ssextra.bin
```

So

```
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssch.png    out=..\ports\cpc\bin\ssch    size=12,1 metasize=2,3 silent
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssempty.png out=..\ports\cpc\bin\ssempty size=1,1 metasize=2,3 silent
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssen.png    out=..\ports\cpc\bin\ssen    size=6,1 metasize=2,3 silent
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\sssmall.png out=..\ports\cpc\bin\sssmall size=1,1 metasize=1,1 silent
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssextra.png out=..\ports\cpc\bin\ssextra size=2,1 metasize=2,2 silent
```

- Fix the heap (`ram/heap.h`) accordingly so all sprite cells are in place.

## Fixed screens

Generate rle'd bins for fixed screens from ts.spt:

```
    # Fixed screens

    open title.png
    nametablerle
    output nametable ../bin/title.nam.bin
    output nametablerle ../bin/title.rle.bin

    open hud.png
    nametablerle
    output nametable ../bin/hud.nam.bin
    output nametablerle ../bin/hud.rle.bin

    open ending.png
    nametablerle
    output nametable ../bin/ending.nam.bin
    output nametablerle ../bin/ending.rle.bin
```

And include them to the right place in `ram/heap.h`:

```c
    // Custom fixed screens
    extern const unsigned char title_rle [0];
    extern const unsigned char hud_rle [0];
    extern const unsigned char ending_rle [0];

    [...]


    ;; Fixed screens

    ._title_rle
        #ifdef SPECCY
            BINARY "../ports/zx/bin/title.rle.bin"
        #endif
        #ifdef CPC
            BINARY "../ports/cpc/bin/title.rle.bin"
        #endif

    ._hud_rle
        #ifdef SPECCY
            BINARY "../ports/zx/bin/hud.rle.bin"
        #endif
        #ifdef CPC
            BINARY "../ports/cpc/bin/hud.rle.bin"
        #endif

    ._ending_rle
        #ifdef SPECCY
            BINARY "../ports/zx/bin/ending.rle.bin"
        #endif
        #ifdef CPC
            BINARY "../ports/cpc/bin/ending.rle.bin"
        #endif  
```

As you may have guessed, this game has a rle'd hud for some reason. Paint it from the correct spot at `engine/game.h`, around line 53:

```c
    // DRAW GAME FRAME
    gp_aux = hud_rle; unrle ();
```

## Tileset behaviours

Write correct behaviours to `ports/cpc/ts0.behs` and `ports/cpc/ts1.behs`.

```
    0,0,8,8,0,8,8,4,4,8,8,0,4,0,0,10,0,4,0,8,0,4,4,0,0,0,0,4,0,0,4,0
```

```
    0,0,0,0,8,8,8,8,8,4,4,34,4,1,8,10,0,4,0,8,0,0,0,8,8,8,8,8,8,0,8,8
```

Remember 10 = lock. That 34 is for collectibles, but obviously I will need to change it later.

- Adjust importer script `buildbins_cpc.bat`:

```
    echo Level 0 assets
    [...]
    ..\utils\list2bin.exe  ..\ports\cpc\gfx\ts0.behs ..\ports\cpc\bin\level0\behs.bin
    [...]

    echo Level 1 assets
    [...]
    ..\utils\list2bin.exe  ..\ports\cpc\gfx\ts1.behs ..\ports\cpc\bin\level1\behs.bin
    [...]
```

- Fix the heap: now leave space (defs) rather than including a beh binary directly.

## Compressed metatilesets

Remember the `._ts0 defs 1536` section in `heap.h`. We also have to make room for up to 48 metatiles rather than directly including the binary:

```c
    ._tsmaps
        ; Space to define up to 48 metatiles (384 bytes).
        ; defs 384      
        defs 384
```

## Map

- Get / adapt the maps from the original MK1_NES/AGNES game, stick them in `map/`.
- Generate `map/level0.map` and `map/level1.map`.
- Adjust main map size (5, 4) at `definitions.h` -> `MAX_PANTS` to 20. Set `MAX_LEVELS` to 2.
- Fill in `level?` structures at `levelset.h`. Note that we have compressed behs and compressed tilesets (graphics and metatiles), so create a constant for those and include them in the structure.

```c
    const unsigned char level0 [] = {
        0,
        13, 3,
        19,
        5,
        MAX_HOTSPOTS_0_TYPE_1,

        // Compressed resources IDs:
        LEVEL0_MAP_C,
        LEVEL0_LOCKS_C,
        LEVEL0_ENEMS_C,
        LEVEL0_HOTSPOTS_C,
        LEVEL0_BEHS_C,
        LEVEL0_TS_PATTERNS_C,
        LEVEL0_TS_TILEMAPS_C
    };

    const unsigned char level1 [] = {
        0,
        9, 3,
        19,
        4,
        MAX_HOTSPOTS_1_TYPE_1,

        // Compressed resources IDs:
        LEVEL1_MAP_C,
        0,
        LEVEL1_ENEMS_C,
        LEVEL1_HOTSPOTS_C,
        LEVEL1_BEHS_C,
        LEVEL1_TS_PATTERNS_C,
        LEVEL1_TS_TILEMAPS_C
    };
```

- populate the `level` array accordingly. 

```c
    const unsigned char * levels [] = {
        level0, level1
    };
```

- Adjust `buildbins_cpc.bat` to compress both maps and put them in the right place.

```
    ..\utils\rle53map_sp.exe in=..\map\level0.map out=..\ports\cpc\bin\level0\ size=5,4 tlock=15 fixmappy nodecos noindex scrsize=16,12
    [...]

    ..\utils\rle53map_sp.exe in=..\map\level1.map out=..\ports\cpc\bin\level1\ size=4,5 tlock=15 fixmappy nodecos noindex scrsize=16,12
```

## Enems

- Grab the files from the MK1_NES/AGNES port, or the SG1000 port (rather, may be a bit mole polished) and place them in place at `enems/`.
- Recheck everything is correct.
- Adjust `buildbins_cpc.bat` to convert & compress both files and put them in the right place.

```
    ..\utils\eneexp3b_sp.exe in=..\enems\level0.ene out=..\ports\cpc\bin\level0\ yadjust=1 prefix=0
    [...]

    ..\utils\eneexp3b_sp.exe in=..\enems\level1.ene out=..\ports\cpc\bin\level1\ yadjust=1 prefix=1
```

## Engine configuration

Change values in `definitions.h` for this game. Based upon the Mega Meghan config file, I had to change those values...

### Stuff related to **software sprites**

I've introduced a new feature to this version which makes obsolete the `SW_SPRITES_WxH` completely, **for the CPC port**, as it was only used to substract 8 pixels from the top position when rendering them and that was pretty much constrained. *But* you need to define `SW_SPRITES_ALL` with the total amount of software sprites you will be using: player plus three actors (enemies / platforms). Check [how dynamic allocation of sprite sizes work](#dynamic-allocation-of-sprite-sizes).

### Sprite cells

Sprite cells list is, for this game, as follows:

```
    0-11    Main player.
    12      Empty
    13-18   Enemies
    19      Platform
    20      Explosion
    21      Small (not used)
```

(i.e. we'll arrange them this way in `assets/spriteset.h`). So

```c
    #define ENEMS_CELL_BASE                     13
    #define EMPTY_CELL                          12
    #define EXPLOSION_CELL_BASE                 20
```

### Animation cells (for the player):

```c
    #define CELL_FACING_RIGHT               0
    #define CELL_FACING_LEFT                6
    #define CELL_IDLE                       0
    #define CELL_WALK_BASE                  1
    #define CELL_JUMP                       5
```

### About **player**:

Initial life & refill:

```c
    #define LIFE_INI                        5
    #define LIFE_REFILL                     3
```

Player *can't* fire

```c
    //#define PLAYER_CAN_FIRE
```

I need to implement *tile get*, so, for now...

```c
    //#define ENABLE_TILE_GET
```

### About **enems**

No facing for enemies:

```c
    //#define ENEMS_WITH_FACING
```

Enemy life is set to 2:

```c
    #define ENEMS_GENERAL_LIFE              2
```

All enemy types are deactivated but linear. Remember to enable platforms and `LINEAR_COLLIDES`.

```c
    #define ENABLE_LINEAR
    #define ENABLE_PLATFORMS                
    #define LINEAR_COLLIDES                 // Collides with BG & 8.
    #define LINEAR_COLLIDE_EVERYTHING       // Collides with BG != 0.
```

### Map format

```c
    #define MAP_FORMAT_RLE53
```

### Hotspots

Common AGNES configuration.

```c
    #define HOTSPOT_TYPE_OBJECT             1
    #define HOTSPOT_TYPE_KEY                2
    #define HOTSPOT_TYPE_REFILL             3
    //#define HOTSPOT_TYPE_AMMO             4
```

### Custom stuff

Remove custom stuff, for now.

## Printer customization

None as of yet.

## Fixed screens

I'll leave this for now

## Spriteset configuration

Ah, nice! I have a nice utility to calculate sprite offsets which is driven by a nice script! Nicest nicety! The script calculates stuff sequentially, so if you really want to use the tool you have to have your sprites in the heap in the same order. As platforms are not in the `ssen.bin` binary, but on the `ssextra.bin` binary, we make sure that the platform ends up the first in `ssextra.in` so it comes after `ssen.bin` and it's kind of a "4th enemy". If we had scattered sprite faces in the heap we'd have to either write the spriteset by hand or tweak the output from mkcellpointers.exe.

The script is `ports/cpc/gfx/cell_pointers.spt`: 

```
    # ports/cpc/gfx/cell_pointers.spt
    # Script to calculate cell pointers
    # Mega Meghan

    comment 12 cells for the main player, 2x3
    pointer ss_main
    12, 2, 3

    comment Empty cell, 2x3
    pointer ss_empty
    1, 2, 3

    comment 6 cells for the enemies, 2x3
    pointer ss_enems
    6, 2, 3

    comment 2 cells for the platform & explosion, 2x2
    pointer ss_extra
    2, 2, 2

    comment 1 cell for the bullet, 1x1
    pointer ss_small
    1, 1, 1

    # Total number of array entries should be 22
```

Which produces

```c
    // Static cell pointer definition
    // Generated by mkcellpointers v0.1 20190312
    // Target: cpc, block size = 16 bytes

    extern const unsigned char *sprite_cells [0];

    #asm
        ._sprite_cells
        // 12 cells for the main player, 2x3
        defw _ss_main + 0x0000
        defw _ss_main + 0x0060
        defw _ss_main + 0x00c0
        defw _ss_main + 0x0120
        defw _ss_main + 0x0180
        defw _ss_main + 0x01e0
        defw _ss_main + 0x0240
        defw _ss_main + 0x02a0
        defw _ss_main + 0x0300
        defw _ss_main + 0x0360
        defw _ss_main + 0x03c0
        defw _ss_main + 0x0420

        // Empty cell, 2x3
        defw _ss_empty + 0x0000

        // 6 cells for the enemies, 2x3
        defw _ss_enems + 0x0000
        defw _ss_enems + 0x0060
        defw _ss_enems + 0x00c0
        defw _ss_enems + 0x0120
        defw _ss_enems + 0x0180
        defw _ss_enems + 0x01e0

        // 2 cells for the platform & explosion, 2x2
        defw _ss_extra + 0x0000
        defw _ss_extra + 0x0040

        // 1 cell for the bullet, 1x1
        defw _ss_small + 0x0000
    #endasm
```

## Check ending condition

- Ending condition should check only that all objects have been collected. I've moved this to `my/game_ending_condition.h` as it is changed as per game basis.

## Player extra vars

None as of this game.

## Custom inits

None *yet* - will change later when customizing the game to add the text boxes you get when you first do stuff in the game.

## Player cell selection

I've move this to `my/player_cell_selection.h` as this is changed as per game basis.

```c
    if (!ppossee && !pgotten) {
        psprid = CELL_IDLE;
    } else if (ABS (pvx) > PLAYER_VX_MIN) {
        psprid = CELL_WALK_BASE + ((prx >> 4) & 3);
    } else psprid = CELL_IDLE;

    psprid += pfacing;
```

## Sofware sprite management

Customizing `cpc_screen_update` was a must when crafting games for the CPC with MK3_OM, now this requirement is gone as the sprite system has been redesigned. Check [here](#sprite-engine-for-cpc).

## The librarian

Add stuff to `libary_cpc.txt`.

## Level setup

New stuff has to be decompressed for each level, so `engine/level_setup.h`:

```c
    // For this game, decompress map, locks, enemies and hotspots
    librarian_get_resource (c_level [RES_MAP], map);
    librarian_get_resource (c_level [RES_LOCKS], locks);
    librarian_get_resource (c_level [RES_ENEMS], enems);
    librarian_get_resource (c_level [RES_HOTSPOTS], hotspots);

    // Also tileset patterns, metatileset and behs
    librarian_get_resource (c_level [RES_BEHS], behs);
    librarian_get_resource (c_level [RES_TS], ts0);
    librarian_get_resource (c_level [RES_META], tsmaps);
```

## Compile and test

First compilation, let's see what I forgot to change :-). Will have to fix the dynamic allocation for sprite sizes and the fact that explosions are smaller than enemy, so I need to write an "invalidator" of sorts and call it before changing sprite sizes. I know this beforehand, heh.

# Dynamic allocation of sprite sizes

## Sprite engine for CPC

Each CPC software sprite structure carries now a couple of function pointers which point to the correct CPCRSlib functions which need to be used to render the objects.

This has to be set up in `system_cpc.h` when allocating the software sprites. The code in `cpc_screen_update` is now more general and versatile.

# Sprite sizes

I've introduced `sp_sw [].cox, sp_sw [].coy` which are defined per software sprite. That way we can have, for example, enemy sprites of different sizes.

In `system_cpc.h` we have to give default values for all software sprites. In Cheman we only have four software sprites: the main player, plus 3 actors. Actors have varying sizes and offsets; that will be taken care of later:

```c
    gpit = SW_SPRITES_ALL; while (gpit --) {        
        sp_sw [gpit].sp0 = (int) (ss_main);
        sp_sw [gpit].sp1 = (int) (ss_main);     
        sp_sw [gpit].cx = sp_sw [gpit].ox = 0;
        sp_sw [gpit].cy = sp_sw [gpit].oy = 0;
        spr_order [gpit] = gpit;

        // This game: sprites 0 - 3 are 8x24 - albeit they can change dinamicly.
    
        sp_sw [gpit].invfunc = cpc_PutSpTileMap8x24;
        sp_sw [gpit].updfunc = cpc_PutTrSp8x24TileMap2b;
        sp_sw [gpit].cox = 0;
        sp_sw [gpit].coy = -8;
    }
```

As you may have guessed, this works giving `.invfunc`, `.updfunc`, `.cox` and `.coy` proper values. A good place to do this is when loading enemies.

As the enemy system in MK3_OM is a bit cumbersome, we are defining two sets of arrays: one for the enemy types with configurable base cell (type = 0xTS, S = 0..15), and one for enemy types with fixed base cell (defined via #define, and indexed T=0..15, obviously not used for T=1, 2), as:

- Enemy types 0x1? and 0x2? use the least significant nibble to calculate the base cell.
- Enemy types 0x3? use `FANTY_CELL_BASE` (fixed).
- Enemy types 0x4? use `CATACROCK_CELL_BASE`.
- Enemy types 0x5? are not supported yet.
- Enemy types 0x6? use `ESPECTRO_CELL_BASE` (fixed).
- Enemy types 0x7? use a dynamic base cell when creating enemies.
- Enemy types 0x8? use metatiles.
- Enemy types 0x9? use `MONOCOCO_CELL_BASE` (fixed).
- Enemy types 0xA? use `PEZONS_BASE_SPRID` (fixed).
- Enemy types 0xB? use `GYROSAW_CELL_BASE` or `SAW_CELL_BASE` (fixed).

So we'll have two sets of arrays, as mentioned. One will be indexed by the MSB, for fixed base cell type of enemies. If a 0xff is found, the second set of arrays will be used, which are indexed by the LSB. All in `assets/dynamic_sprite_sizes.h`.

```c
    const unsigned char dss_msb_ox [] = { 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned char dss_msb_oy [] = { 0, 0xff, 0xff, 0, 0, 0, 0, 0xff, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned void *dss_msb_invfunc [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned void *dss_msb_updfunc [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

    // Indexed by LSB (sprite face #)

    const unsigned char dss_lsb_ox [] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned char dss_lsb_oy [] = { 0, -8, -8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned char *dss_lsb_invfunc [] = { cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x24, cpc_PutSpTileMap8x16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    const unsigned char *dss_lsb_updfunc [] = { cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x24TileMap2b, cpc_PutTrSp8x16TileMap2b, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
```

Note that these settings are global for now.

Problem is explosions. They substitutie the current sprite cell, so they have to be the same size as the current sprite.

I have several solutions in mind if you have several sized sprites, as different sprite cells for explosions based upon sprite msb/lsb, but this isn't needed in Cheman so won't be included yet.

In Cheman, only batucadas, which are 8x24, can be destroyed, so explosions have a fixed size of 8x24 and that's it.

## Custom stuff for only one object

The HUD is pretty constrained and as there are no projectiles in this game I have plenty of frame time so I'm adding a pumpking sprite which will be rendered whenever Cheman is carrying a pumpkin.

First of all enable the "only one object" mode. We'll be using `flag` 2 to store status (because things):

```c
    #define ONLY_ONE_OBJECT_FLAG            2
```

So on to the preparations; first we have to properly convert the new sprite in `buildbins_cpc.bat`:

```
    ..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\pumpkin.png out=..\ports\cpc\bin\sspumpkin size=1,1  metasize=2,2 silent
```

Then import it as a new sprite face @ `ram/heap.h`.

```c
    // CUSTOM {
        extern const unsigned char ss_pumpkin [0];
    // } END_OF_CUSTOM

    [...]

    // CUSTOM {
    ._ss_pumpkin
        #ifdef SPECCY
            BINARY "../ports/zx/bin/sspumpkin.bin"
        #endif
        #ifdef CPC
            BINARY "../ports/cpc/bin/sspumpkin.bin"
        #endif
    // } END_OF_CUSTOM
```

Don't forget to appoint for it in the spriteset, adding an entry to `cell_pointers_spt`:

```
    comment 1 cell for the custom pumpkin, 2x2
    pointer ss_pumpkin
    1, 2, 2
```

Next is adding a new SW sprite. We had 4, now we have 5. In `definitions.h`:

```c
    #ifdef CPC
        #define SW_SPRITES_ALL                  5       // Cheman: player + 3 actors
    #endif
```

This is an 8x16 sprite which will never change, so modify `util/system_cpc.h` accordingly:

```c
    // Sprite allocation

    gpit = SW_SPRITES_ALL; while (gpit --) {        
        sp_sw [gpit].cx = sp_sw [gpit].ox = 0;
        sp_sw [gpit].cy = sp_sw [gpit].oy = 0;
        spr_order [gpit] = gpit;

        // This game: sprites 0 - 3 are 8x24 - albeit they can change dinamicly.
        // Sprite 4 is 8x16
    
        if (gpit < 4) {
            sp_sw [gpit].sp0 = (int) (ss_main);
            sp_sw [gpit].sp1 = (int) (ss_main);         
            sp_sw [gpit].invfunc = cpc_PutSpTileMap8x24;
            sp_sw [gpit].updfunc = cpc_PutTrSp8x24TileMap2b;
            sp_sw [gpit].cox = 0;
            sp_sw [gpit].coy = -8;
        } else {
            sp_sw [gpit].sp0 = (int) (ss_pumpkin);
            sp_sw [gpit].sp1 = (int) (ss_pumpkin);
            sp_sw [gpit].invfunc = cpc_PutSpTileMap8x16;
            sp_sw [gpit].updfunc = cpc_PutTrSp8x16TileMap2b;
            sp_sw [gpit].cox = 0;
            sp_sw [gpit].coy = 0;
        }
    }
```

Now initialize it. Add this to `my/game_init_custom.h`:

```c
    spr_on [4] = 0;
```

Now we have to make that, if `flags [ONLY_ONE_OBJECT_FLAG]` is set, `spr_on = 1` and `spr_x / spr_y ` follow the player.

We can add such code at the end of  `player.h` for instance:

```c
    // CUSTON {
    // The pumpkin!
    if (flags [ONLY_ONE_OBJECT_FLAG]) {
        spr_on [4] = 1;
        spr_x [4] = spr_x [SPR_PLAYER];
        spr_y [4] = pry - 12;
    } else spr_on [4] = 0;
    // } END_OF_CUSTOM
```

## Carry pumpkins to the totems

This was made via scripting in the original but this game is pretty much very simple to add a scripting engine just to do this.

All we have to do is detect cheman touches something in some screens, so I'm adding a code in the readily available `my/main_loop_custom.h`. Screens to check are the center column, that is, screens 2, 7, 12 and 17 for level 0, and just screen 18 in level 1.

## Custom key redefinition

We just need LEFT/RIGHT and UP (JUMP) for this game. Change `controls_setup` in `utils\controls.h`.

```c
    #ifdef CPC
        // Key order is left right down up action jump.
        // If your game does not use all key assignations
        // you have to skip those you don't use in the for loop.

        // CUSTOM: 4; was: 5
        #define LASTKEY 4
        
        // CUSTOM {
        /*
        unsigned char ktext_0 [] = "LEFT ";
        unsigned char ktext_1 [] = "RIGHT";
        unsigned char ktext_2 [] = "DOWN ";
        unsigned char ktext_3 [] = "UP   ";
        unsigned char ktext_4 [] = "ACTION";
        unsigned char ktext_5 [] = "JUMP  ";
        unsigned char *ktexts [] = {
            ktext_0, ktext_1, ktext_2, ktext_3, ktext_4, ktext_5
        };
        */
        unsigned char ktext_0 [] = "LEFT ";
        unsigned char ktext_1 [] = "RIGHT";
        unsigned char ktext_2 [] = "JUMP ";
        unsigned char *ktexts [] = {
            ktext_0, ktext_1, 0, 0, 0, ktext_2
        };
        // } END_OF_CUSTOM

        void controls_setup (void) {
            // Redefinition code
            _x = 6; _y = 15; p_s ("                     /                     ");

            // First of all, clear up definitions so no collision is possible:
            for (gpit = 0; gpit <= KEY_BUTTON_B; gpit ++) cpc_AssignKey (gpit, 0);
            
            while (cpc_AnyKeyPressed ());
            _x = 8; _y = 15; p_s ("PRESS A KEY FOR:");
            for (gpit = 0; gpit < LASTKEY; gpit ++) {
                // CUSTOM { SKIP TO JUMP!
                if (gpit == 2) gpit = 5;
                // } END OF CUSTOM
                _x = 13; _y = 16; p_s (ktexts [gpit]);
                cpc_ShowTileMap (0);
                cpc_RedefineKey (gpit);
                //while (cpc_TestKey (gpit));           
            }
        }
    #endif
```

# Persistent tile get

This is new for this version - Older versions relied on modifying the actual map-data on RAM (as it was unpacked), but this requires UNPACKED/PACKED and is not compatible with RLE.

Limited support was thought of in MK2_NES: A relatively small array which contains 12 bytes per screen. Each bit encodes two adjacent tiles as a whole. Not perfect, but it somewhat works.

First of all, introduce `PERSISTENT_TILE_GET` in `definitions.h` and then create the variables needed in `ram/globals.h`.

We have `TEXTBUFF` which is located at `0xC600`. Texts are not very long. We could place the `tile_got` array at the end of this space, that is, from `0xC7FF` donwards.

```c
    #ifdef PERSISTENT_TILE_GET
        #ifdef SPECCY
            unsigned char tile_got [MAX_PANTS*12];
        #endif
        #ifdef CPC
            unsigned char tile_got [MAX_PANTS*12] @ (TEXTBUFF + 0x200 - (MAX_PANTS*12))
        #endif
        unsigned char tile_got_offset;
    #endif  
```

The code which registers the persistence is already in place, directly lifter from MK2_NES:

```c
    #ifdef PERSISTENT_TILE_GET
        gpint = tile_got_offset + (cy1 - 1);
        rda = tile_got [gpint];
        tile_got [gpint] = rda | bitmask [cx1 >> 1];
    #endif
```

What's left to do is 1.- Clearing the buffer when entering a level, 2.- precalculating `tile_got_offset` on entering a new screen, and finally modifying the map after drawing the screen upon the contents of `tile_got`. Right after drawing current screen:

```c
    #ifdef PERSISTENT_TILE_GET
        _t = TILE_GET_CLEAR_TILE;
        gpit = tile_got_offset = (n_pant << 3) + (n_pant << 2);
        for (_y = 0; _y < 24; _y += 2) {
            for (_x = 0; _x < 32; ) {
                if (tile_got [gpit] & bitmask [_x >> 2]) {
                    DRAW_TILE (); _x += 2;
                    DRAW_TILE (); _x += 2;
                } else _x += 4;
                ++ gpit;
            }
        }
    #endif
```

# ZX Version

It's been a while since I don't make a ZX port so the system part may be a bit rusty, but overall the ZX engine was easier to make behave so it shouldn't be quite a problem.

## Main preparations

First thing is creating a `buildbins_zx.bat` with adapted commands so the assets come out in ZX format. Create a librarian file, etc.

Next is `compile_zx.bat`, which I've created using Otro Bosque's as a base.

Note that in this port, there are just 83 different chars in the main ts, as opposed to 100 in the CPC port. So the conversion of `ts0.png` and `ts1.png` have to start in 83.

```
    ..\utils\mkts_om.exe platform=zx mode=mapped in=..\ports\zx\gfx\ts0.png out=..\ports\zx\bin\level0\ts size=8,5 metasize=2,2 tmapoffs=83 max=36 defaultink=7 silent 

    ..\utils\mkts_om.exe platform=zx mode=mapped in=..\ports\zx\gfx\ts1.png out=..\ports\zx\bin\level1\ts size=8,5 metasize=2,2 tmapoffs=83 max=36 defaultink=7 silent 
```
## The heap

I took special care to fill up the ZX side of the `#defines` when configuring the heap for CPC, so everything should be in place bar minor last minute adjustments.

To save precious space (sprite cells in the ZX port take much more space than in the CPC port!), the biggest pattern count is on `ts1.png`: 88 patterns which take 704 bytes `(88*8)`, and that's exactly the space we reserve:

```c

```

## Spriteset

I made a script to generate the CPC spriteset, but no I have a somewhat completely different set of values. Mainly because ZX cell sizes are different. So I'm making a platform selection switch into the `mkcellpointers.exe` utility.

Delete that, I'm a genius and that was already implemented!

## Sprite sizes 

In the ZX port variable sprite sizes is not implemented yet and seriously I don't really have the time to do it! So let's consider every sprite cell is 2x3 and that's all.

Still, we have to make the proper definitions in `definitions.h`:

```c
    #ifdef SPECCY
        #define SW_SPRITES_16x24                4       // # of 16x24 software sprites
        #define SW_SPRITES_16x16                1       // # of 16x16 software sprites
        #define SW_SPRITES_16x8                 0       // # of 16x8 software sprites
        #define SW_SPRITES_8x16                 0       // # of 8x16 software sprites
        #define SW_SPRITES_8x8                  0       // # of 8x8 software sprites

        #define SW_SPRITES_ALL                  SW_SPRITES_16x24+SW_SPRITES_16x16+SW_SPRITES_16x8+SW_SPRITES_8x16+SW_SPRITES_8x8
    #endif
```

This is, four 16x24 sprites (player + enemies), and 1 16x16 sprite (pumpkin).

`util/system_speccy.h` seems correct. But the speccy version needs provision for .cox, .coy in sp_sw!


