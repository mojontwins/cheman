// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// General
	#define FIX_BITS						4

// Useful macros

// System stuff
	#ifdef SPECCY
		#define SW_SPRITES_16x24				4		// # of 16x24 software sprites
		#define SW_SPRITES_16x16				1		// # of 16x16 software sprites
		#define SW_SPRITES_16x8					0		// # of 16x8 software sprites
		#define SW_SPRITES_8x16					0		// # of 8x16 software sprites
		#define SW_SPRITES_8x8					0		// # of 8x8 software sprites

		#define SW_SPRITES_ALL					SW_SPRITES_16x24+SW_SPRITES_16x16+SW_SPRITES_16x8+SW_SPRITES_8x16+SW_SPRITES_8x8
	#endif
	#ifdef CPC
		#define SW_SPRITES_ALL 					5		// Cheman: player + 3 actors + pumpkin
	#endif

	#define SPR_PLAYER						0
	#define SPR_ENEMS_BASE					1
	#define SPR_BULLETS_BASE				SPR_ENEMS_BASE + 3
	#define SPR_HITTER						0xff
	#ifdef SPECCY
		#define SPR_COCOS_BASE					0xff
	#endif
	#ifdef CPC
		#define SPR_COCOS_BASE					0xff
	#endif
	

// These apply only to the ZX port
	#define NUMBLOCKS 						(((SW_SPRITES_16x24*13)+(SW_SPRITES_16x16*10)+(SW_SPRITES_8x8*5)+((SW_SPRITES_16x8+SW_SPRITES_8x16)*7)))
	//#define AD_FREE							(RAMTOP-NUMBLOCKS*15)

// Sound engine (preliminary)
	
	#ifdef SPECCY
		//#define SE_NONE
	#define SE_BEEPER
	#endif

	#ifdef CPC
		//#define SE_NONE
		#define SE_ARKOS
		//#define SE_DEBUG
	#endif

	#ifdef SE_ARKOS
		#define SFX_PLAY(n)					sfx_play (n+1);
		#define SFX_PLAY_DIRECT(n)			sfx_play (n+1);
		#define MUSIC_PLAY(n)				music_play (n);
		#define MUSIC_STOP					music_stop ();
	#endif

	#ifdef SE_NONE 
		#define SFX_PLAY(n) 				;
		#define SFX_PLAY_DIRECT(n) 			;
		#define MUSIC_PLAY(n)				;
		#define MUSIC_STOP 					;
	#endif

	#ifdef SE_BEEPER
		#define SFX_PLAY(n)					queued_sound = (n)
		#define SFX_PLAY_DIRECT(n)			beep_fx (n)
		#define MUSIC_PLAY(n)				;
		#define MUSIC_STOP 					;
	#endif

	#ifdef SE_DEBUG
		#define SFX_PLAY(n) 				;
		//#define MUSIC_PLAY(n)				;
		#define MUSIC_PLAY(n)				music_play (n);
		#define MUSIC_STOP 					;
	#endif

// Macros
	#define MSB(x)							((x)>>8)
	#define LSB(x)							((x)&0xff)
	#define MAX(x1,x2)						((x1)<(x2)?(x2):(x1))
	#define MIN(x1,x2)						((x1)<(x2)?(x1):(x2))
	#define SGNI(n)							((n)<0?-1:((n)>0?1:0))
	#define SGNC(a,b,c)						((a)<(b)?-(c):(c))
	#define SATURATE_Z(n)					((n)<0?0:(n))
	#define SATURATE(v,max)					((v)>=0?((v)>(max)?(max):(v)):((v)<-(max)?-(max):(v)))
	#define SATURATE_N(v,min)				(v<min?min:v)
	#define ABS(n)							((n)<0?-(n):(n))
	#define DELTA(a,b)						((a)<(b)?(b)-(a):(a)-(b))
	#define CL(x1,y1,x2,y2)					((x1)+4>=(x2)&&(x1)<=(x2)+12&&(y1)+12>=(y2)&&(y1)<=(y2)+12)
	#define CL_TALL(x1,y1,x2,y2)			((x1)+4>=(x2)&&(x1)<=(x2)+12&&(y1)+12>=(y2)&&(y1)<=(y2)+8)
	#define SUBSTR_SAT(a,b)					((a)>(b)?(a)-(b):0)
	#define DISABLE_SFX_NEXT_FRAME			*((unsigned char*)0x01bf)=1;
	#define ADD_SIGN2(a,b,v)				(((a)==(b))?(0):(((a)>(b))?(v):(-((signed char) (v)))))
	#define ADD_SIGN(a,v) 					((a)?(((a)>0)?(v):(-(v))):(0))
	#define COLLIDE(x1,y1,x2,y2)			cx1=(x1);cx2=(x2);cy1=(y1);cy2=(y2);if (collide())

	#define DIGIT(n)						(16+(n))

// About the heap
	#define SPRITES_EXTRA_CELLS				0		// # of 16x16 sprite cells besides the player (for enemies, etc)
	#define SPRITES_SMALL_CELLS				1		// # of 8x8 sprite cells (sword, punch, bullets...)

// Game definitions
	#define MAX_PANTS						20
	#define MAX_LEVELS 						2

	#define N_ENEMS							3
	#define BOLTS_MAX 						4		// MAX. # of bolts in a level
	#define ENEMS_GENERAL_LIFE				2
	#define ENEMS_GENERAL_DYING_FRAMES		16
	#define ENEMS_GENERAL_HIT_FRAMES		5

	#define LIFE_INI						5
	#define LIFE_REFILL						1

	#define UP_ALSO_JUMPS					// No need for two buttons

// Screen position of stuff
	#define SCR_X							0
	#define SCR_Y 							1		// If 12 tiles high, viewport minus one

// Timed message
	//#define ENABLE_TIMED_MESSAGE
	#define TM_ATTR							15
	#define TM_X							2
	#define TM_Y 							22
	#define TM_FRAMES 						50
	#define TIMED_MESSAGE 					"50 COINS FOR ONE EXTRA LIFE!"
#ifdef SPECCY
	#define TM_ERASE						"                            "
#endif
#ifdef CPC
	#define TM_ERASE						"\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc\xfc"
#endif

// Game engine values

	#define TALL_PLAYER						// Player is 16x24

	#define PERSISTENT_DEATHS
	//#define PERSISTENT_ENEMIES
	#define ENEMS_SUFFER_WHEN_HITTING_PLAYER
	//#define ENEMS_MIN_KILLABLE			0x12
	//#define ENEMS_DIE_ON_EVIL_TILE

// Printer

	// Choose:
	#define PRINT_PSEUDOASCII				// patterns 0-63 == ASCII 32-95
	//#define PRINT_CUSTOM					// Custom 0xff-terminated strings (mkts)
	//#define PRINT_UL_PRINTER				// Used from the TEXT command (Scripting) 

	//#define ENABLE_TEXT_WINDOW			// Uses compressed text (by textstuffer.exe)

// Map types & configurations

	//#define PRECISE_DESCENDING_COLLISION	// No-pop for type 4 plaforms in side-scrollers

	//#define ENABLE_HOLES					// hole in the ground, for top-down view games.
	//#define HOLE_BIT						2

	//#define ENABLE_CONVEYORS
	#define CONVEYOR_SPEED					16
	#define CONVEYOR_BIT 					32

	//#define ENABLE_SLIPPERY
	//#define SLIPPERY_BIT					16

	//#define ENABLE_QUICKSANDS
	//#define QUICKSANDS_BIT 				2

	//#define ENABLE_WATER 					
	//#define WATER_BIT 					2

	#define ENABLE_TILE_GET
	#define TILE_GET_BIT					2
	//#define TILE_GET_COUNT_ON_FLAG		1	// If not defined, count on ptile_get_ctr
	#define TILE_GET_LIFE_REFILL			25
	#define TILE_GET_CLEAR_TILE				0
	#define PERSISTENT_TILE_GET				// Needs tile_got/tile_got_offset
	// For MAX_PANTS - 12*20 = 240 bytes.
	
// Those are quite standard and 99% of the time you don't need to touch them

	#define EVIL_BIT						1
	#define PLATFORM_BIT					4
	#define OBSTACLE_BIT					8

	#define FLOOR_BITS						12 // (OBSTACLE_BIT | PLATFORM_BIT)
	#define NOTAIR_BITS						13 // (FLOOR_BITS | EVIL_BIT)

	#define SPECIAL_BEH						10	// For keyholes 
	#define PUSHABLE_BEH 					11  // pushable. Should include OBSTACLE_BIT

	//#define NO_AUTOFLICK					// Enable and the game won't flick screen on screen boundaries.

// Map format

	#define PRX_MAX 			244
	#define PRX_MAX_FIX_BITS 	3904		// The #asm preprocessor is stupid
	#ifdef SPECCY
		#define PRX_MAX_COCO	248
	#endif
	#ifdef CPC
		#define PRX_MAX_COCO 	240
	#endif
	#define MAP_CHARSW 		32

	#ifdef SPECCY
		#define PRY_MAX 		192
		#define PRY_MAX_FIX_BITS 3072		// The #asm preprocessor is stupid
		#define PRY_MAX_COCO	200
	#endif
	#ifdef CPC
		#define PRY_MAX 		184
		#define PRY_MAX_FIX_BITS 2944		// The #asm preprocessor is stupid
		#define PRY_MAX_COCO	192
	#endif
	#define MAP_CHARSH 		24
	#define TY_MAX			12

	//#define MAP_FORMAT_RLE44
	#define MAP_FORMAT_RLE53
	//#define MAP_FORMAT_BYTE_RLE
	//#define MAP_FORMAT_PACKED
	//#define MAP_ENABLE_AUTOSHADOWS
	//#define MAP_FORMAT_NOINDEX			// Use with PACKED/UNPACKED.

	//#define SCENERY_BITS					13	

	// Alt tile defines a substitute for tile 0 at random		
	//#define MAP_USE_ALT_TILE				16
	//#define ALT_TILE_EXPRESSION			((rand8()&31)==0)

	//#define MAP_DONT_PAINT_TILE_0			// If you want to use backdrops, make the painter skip tile 0
	//#define MAP_CHECK_TOP
	//#define MAP_CHECK_BOTTOM

	//#define MAP_WITH_DECORATIONS

// Enems format

	#define ENEMS_FORMAT_UNPACKED			// Good ol' unpacked format.
	//#define ENEMS_FORMAT_COMPACTED		// Only active enems stored + index

// Enems stuff
	//#define ENEMS_WITH_FACING
	
	//#define ENEMS_UPSIDE_DOWN				// Enems may have this state (ie. when hit with Yun's fabolees)
	#ifdef SPECCY
		#define ENEMS_CELL_BASE					9
	#endif
	#ifdef CPC 
		#define ENEMS_CELL_BASE					13	
	#endif

	#define EMPTY_CELL							12

	#ifdef SPECCY
		#define EXPLOSION_CELL_BASE 			16
	#endif
	#ifdef CPC
		#define EXPLOSION_CELL_BASE 			20
	#endif


// Linear enemies

	#define ENABLE_LINEAR
	#define ENABLE_PLATFORMS
	#ifdef SPECCY
		#define PLATFORMS_FIXED_CELL			15
	#endif
	#ifdef CPC
		#define PLATFORMS_FIXED_CELL			19
	#endif
	//#define LINEAR_COLLIDES					// Collides with BG & 8.
	//#define LINEAR_COLLIDE_EVERYTHING		// Collides with BG != 0.

// Type7 (with or without generators) enemies

	//#define ENABLE_TYPE7
	//#define TYPE7_BASE_SPRITE 			24
	//#define TYPE7_WITH_GENERATOR
	//#define TYPE7_GENERATOR_LIFE			10
	#define TYPE7_MINION_LIFE 				4					// Actually this value + 1
	#define TYPE7_SPAWN_TIME				24+(rand8()&63)		// Must be of course > TYPE7_DYING_FRAMES!
	#define TYPE7_SMOKE_TIME				16 //40
	#define TYPE7_MINION_DYING_FRAMES		16
	#define TYPE7_MINION_HIT_FRAMES			3
	//#define TYPE7_GENERATOR_DYING_FRAMES	16
	//#define TYPE7_GENERATOR_HIT_FRAMES	5
	//#define TYPE7_FIXED_SPRITE			3
	#define TYPE7_STOP_FRAMES				0x07 				// 0x1f meghan
	#define TYPE7_STOP_RATE					0x1f 				// 0x7 meghan

// Walker 

// Steady shooters
	//#define ENABLE_STEADY_SHOOTER
	#ifdef SPECCY
		#define STEADY_SHOOTER_BASE_TILE		44
	#endif
	#ifdef CPC
		#define STEADY_SHOOTER_BASE_TILE		32
	#endif

// Monococo
	//#define ENABLE_MONOCOCO
	#define MONOCOCO_BASE_TIME_HIDDEN		150
	#define MONOCOCO_BASE_TIME_APPEARING	50
	#define MONOCOCO_BASE_TIME_ONBOARD		50
	#define MONOCOCO_FIRE_COCO_AT			MONOCOCO_BASE_TIME_ONBOARD/2
	//#define MONOCOCO_CELL_BASE			(en_s [gpit])
	#define MONOCOCO_CELL_BASE				8

// Monococo simple
	// Ninjajar's. A linear enemy which soots at random.
	//#define ENABLE_MONOCOCO_SIMPLE
	#define MONOCOCO_SIMPLE_SHOOTING_FREQ	63

// Gyrosaws
	//#define ENABLE_GYROSAW
	#define GYROSAW_CELL_BASE				72
	#define GYROSAW_V						1
	//#define GYROSAW_SLOW

// Saws
	//#define ENABLE_SAW
	#define SAW_CELL_BASE					20
	#define SAW_V_DISPL						4
	#define SAW_EMERGING_STEPS				10
	#define SAW_CELL_OCCLUSION				sssaw_02

// Precalc Fanty (0x3x)
	//#define ENABLE_PRECALC_FANTY
	
// Precalc, all integer homing fanty from Goddess. (0x3x)	
	//#define ENABLE_PRECALC_HOMING_FANTY
	#define FANTY_ST_IDLE					0
	#define FANTY_ST_PURSUING				1
	#define FANTY_ST_RETREATING				2
	#define FANTY_ST_RESET					3
	#define FANTY_SIGHT_DISTANCE			96

// Precalc, all integer fanty adapted from Goddess (with timer)
// Substitutes Fanty (0x3x as well)	
	//#define ENABLE_PRECALC_TIMED_FANTY

// Global for all fanties
	//#define FANTY_COLLIDES
	#define FANTY_CELL_BASE 				12
	#define FANTY_REPOSITION_NONETHELESS			// Reposition fanty to origin when entering screen regardless of configuration

// Catacrock
	//#define ENABLE_CATACROCK
	#define CATACROCK_CELL_BASE 			28
	#define CATACROCK_CROCK_FRAMES			50
	#define CATACROCK_G 					4
	#define CATACROCK_MAXV					64

// Nube (Ninjajar!)
	//#define ENABLE_NUBE
	#define NUBE_SIMPLE_SHOOTING_FREQ		63

// Espectros
	//#define ENABLE_ESPECTROS
	#define ESPECTRO_CELL_BASE 				8
	#define ESPECTRO_A 						1
	#define ESPECTRO_MAXV 					32
	#define ESPECTRO_REBOUND				48
	#define ESPECTRO_V_RETREATING			8

// Custom fumettos
	//#define ENABLE_FUMETTOS
	#define FUMETTOS_MAX 					3
	#define FUMETTO_BASE_PATTERN 			2

// Saws
	//#define ENABLE_SAWS
	// What else?

// Springs
	#define ENABLE_SPRINGS
	#define SPRINGS_TILE					13
	#define SPRINGS_SOUND					6
	#define SPRINGS_TILE_DETECT				23			// Detect this tile # in the map to create
	
// Propellers

	//#define ENABLE_PROPELLERS
	#define PROPELLERS_MAX					8
	#define PROPELLERS_PATTERN				64			// Animating patterns start here
	#define PROPELLERS_BIT 					64			// Bit to make a tile "propellable"
	#define PROPELLERS_LIMIT				5			// max # of tiles high. Comment for no limit
	//#define PROPELLERS_CREATE_FROM_MAP	33			// Detect this tile # in the map to create
	//#define PROPELLERS_X 					flags [15] 	// Use these if you want to create propellers
	//#define PROPELLERS_Y 					flags [14]	// by other means (for example script & EXTERN)
	#define PROPELLERS_ON_OFF
	#define PROPELLERS_MAX_CTR_FIXED		120
	#define PROPELLERS_INI_CTR				(PROPELLERS_MAX_CTR_FIXED - (propellers_idx << 2))

// Estrujators

	//#define ENABLE_ESTRUJATORS
	#define ESTRUJATORS_MAX					8			// 
	//#define ESTRUJATORS_CREATE_FROM_MAP
	#define ESTRUJATORS_TILE 				21			// Detect this tile # in the map to create
	//#define ESTRUJATORS_X					flags [15]	// Use these if you want to create estrujators
	//#define ESTRUJATORS_Y					flags [14]	// by other means (for example script & EXTERN)
	//#define ESTRUJATORS_DELAY				flags [13]	// Same, for the delay.
	#define ESTRUJATORS_DOWN_IDLE_TIME 		10
	#define ESTRUJATORS_TILE_DELETER		3
	#define ESTRUJATORS_HEIGHT				3			// In tiles.
	#define ESTRUJATORS_SLOW							// Half as slow. Twice as predictable

// Cataracts

	// Remember, cataracts & estrujators share memory structures,
	// If you define CATARACTS but not ESTRUJATORS, please keep
	// ESTRUJATORS_MAX #define'd.

	//#define ENABLE_CATARACTS
	//#define CATARACTS_CREATE_FROM_MAP		
	//#define CATARACTS_X					flags [15]	// Use these if you want to create cataracts
	//#define CATARACTS_Y					flags [14]	// by other means (for example script & EXTERN)
	#define CATARACTS_IDLE_TIME				240
	#define CATARACTS_PATTERN 				0xcc
	#define CATARACTS_DELETE_PATTERN 		0xca
	#define CATARACTS_HEIGHT				4			// In tiles.
	#define CATARACTS_TILE					23
	#define CATARACTS_TILE_ALT				16

// Pez??n
	//#define ENABLE_PRECALC_PEZON
	#define PEZON_WAIT						50
	#define PEZONS_BASE_SPRID				60

// Lemmings
	//#define ENABLE_LEMMINGS
	#define LEMMINGS_G						4			// in pixels per frame

// Auxiliary stuff

	#if defined (ENABLE_STEADY_SHOOTER) || defined (ENABLE_MONOCOCO) || defined (ENABLE_MONOCOCO_SIMPLE) || defined (ENABLE_LAME_BOSS_1)
	
		#define ENABLE_COCOS
		#define COCOS_MAX 						3
		#ifdef SPECCY
			#define COCO_CELL_BASE				29
			#define COCO_V						96
		#endif
		#ifdef CPC
			#define COCO_CELL_BASE				28
			#define COCO_V						120
		#endif
		
		#define ONE_PER_ENEM

		#if defined (ENABLE_MONOCOCO) || defined (ENABLE_MONOCOCO_SIMPLE) || defined (ENABLE_LAME_BOSS_1)
		#define ENABLE_COCO_AIMED
		//#define COCO_FAIR_D						64
		#endif

		#if defined (ENABLE_STEADY_SHOOTER)
		#define ENABLE_COCO_STRAIGHT
		#endif

		#if defined (ENABLE_NUBE)
		#define ENABLE_COCO_AIMED_DOWN
		#endif

	#endif

	#if defined (ENABLE_FANTY) || defined (ENABLE_GENERATONIS) || defined (ENABLE_ESPECTROS) || defined (ENABLE_CATACROCK)
	#define ENEMIES_NEED_FP
	#endif

	#if defined (PROPELLERS_CREATE_FROM_MAP) || defined (SPRINGS_CREATE_FROM_MAP) || defined (ESTRUJATORS_CREATE_FROM_MAP) || defined (CATARACTS_CREATE_FROM_MAP)
	#define CREATE_STUFF_FROM_MAP
	#endif

// Evil tiles

	// Enable the ones you need. Use a custom way to switch between them if you activate several:
	//#define EVIL_TILE_ON_FLOOR
	//#define EVIL_TILE_ON_CEILING
	//#define EVIL_TILE_MULTI
	#define EVIL_TILE_CENTER

	#if defined (EVIL_TILE_MULTI) || defined (EVIL_TILE_ON_FLOOR) || defined (EVIL_TILE_ON_CEILING) || defined (EVIL_TILE_CENTER)
	#define ENABLE_EVIL_TILE
	#endif

// Player

	// This is the lowest Y value for the player. Player Y = 16 in 
	// the top border. In CPC, you can't get out of the screen, so
	// use wisely. In ZX, leave it to 0.

	// For genital games, 8 is good.

	#ifdef SPECCY
		#define ABSOLUTE_BOTTOM	14
		#define ABSOLUTE_BOTTOM_FIX_BITS 224 	// The #asm preprocessor is stupid
	#endif
	#ifdef CPC
		#define ABSOLUTE_BOTTOM 16 // 16
		#define ABSOLUTE_BOTTOM_FIX_BITS 256 	// The #asm preprocessor is stupid
	#endif

	// Enable the ones you need. Use a custom way to switch between them if you activate several:
	//#define PLAYER_GENITAL
	#define GENITAL_HORIZONTAL_PREFERED			// On diagonals, facing is horizontal. Otherwise vertical

	#define PLAYER_JUMPS
	//#define PLAYER_DOUBLE_JUMP
	//#define PLAYER_MONONO
	//#define PLAYER_JETPAC
	//#define PLAYER_HIDES

	#define PLAYER_8_PIXELS						// Collision box is 8x8 instead of 8x16

	//#define PLAYER_PUSH_BOXES
	#define PLAYER_FIRE_TO_PUSH
	#define PLAYER_PUSH_BOXES_CRUSH_CRUDE		// Crude. Only works in top-down
	//#define FLOATY_PUSH_BOXES					// Push box is not copied to screen buffer
												// And screen buffer is used to clear boxes
	#define FLOATY_PUSH_BOXES_SUBST			0	// Push box is subst. by this in buffer
	//#define PLAYER_PUSH_BOXES_ANIMATE		6	// display a cell for N frames

	// And for the falling boxes...
	//#define FPB_MAX 						4	// Max simmultaneous falling boxes
	//#define FPB_FRAMES 					4 	// Time in frames

	//#define PLAYER_NO

	#if defined (PLAYER_JUMPS) || defined (PLAYER_MONONO) || defined (PLAYER_JETPAC)
	#define PLAYER_GRAVITY
	#endif

	// When hit

	#define PLAYER_REBOUNDS
	#define PLAYER_FLICKERS					25
	#define PLAYER_DIE_AND_RESPAWN
	#define PLAYER_DIE_AND_RESPAWN_JUST_SPIKES

	// Ways to kill

	//#define PLAYER_FABOLEES
	//#define PLAYER_SPINS
	//#define PLAYER_SPINS_KILLS
	#define PLAYER_STEPS_ON_ENEMIES
	#define PLAYER_STEPS_KILLS
	#define PLAYER_JUMPS_ON_ENEMIES			// requires PLAYER_STEPS_ON_ENEMIES
	//#define PLAYER_BUTT
	//#define PLAYER_PUNCHES
	//#define KILLABLE_CONDITION			(1)		// This has to be hardcoded in ASM NOW at enems_do_assembly

	#ifdef PLAYER_PUNCHES
	#define HITTER_LAST_FRAME				6
	#define HITTER_HOT_MIN					3
	#define HITTER_HOT_MAX					4
	#define HITTER_CELL_BASE				18
	#endif

	#if defined(PLAYER_PUNCHES)
	#define ENABLE_HITTER
	#endif

// Things related to shooting

	//#define PLAYER_CAN_FIRE
	//#define PLAYER_CAN_FIRE_DIAGONAL
	//#define PLAYER_VX_RECOIL				32
	#define BULLETS_CELL_BASE 				58

	// Ammonition
	//#define AMMO_MAX						99
	#define AMMO_REFILL						50

	// Turret

	//#define PLAYER_TURRET
	#define TURRET_FRAMES					16 	

	// Bullets

	#define BULLETS_MAX						3

	//#define SHOOTING_DRAINS

	//#define ENABLE_PUAS
	#define PUAS_MAX						2
	#define PUAS_VX							2

	// Fabolees

	//#define ENABLE_FABOLEES
	#define FABOLEES_MAX 					3

	// Movement values 

	#ifdef SPECCY
		#define PLAYER_VX_MAX					64
		#define PLAYER_AX						16
		#define PLAYER_RX						32	
		#define PLAYER_VX_MIN 					16
		
		// Y Axis, genital
		
		#define PLAYER_VY_MAX					64
		#define PLAYER_AY						16
		#define PLAYER_RY						32
		#define PLAYER_VY_MIN 					16
	#endif

	#ifdef CPC
		#define PLAYER_VX_MAX					96
		#define PLAYER_AX						24
		#define PLAYER_RX						48	
		#define PLAYER_VX_MIN 					24
		
		// Y Axis, genital
		
		#define PLAYER_VY_MAX					96
		#define PLAYER_AY						24
		#define PLAYER_RY						48
		#define PLAYER_VY_MIN 					24
	#endif

	
	#define PLAYER_VY_FALLING_MAX			127
	#define PLAYER_G						24 
	#define PLAYER_G_JUMPING				4
	
	//#define PLAYER_VY_SINKING				2		// For quicksands
	//#define PLAYER_VY_EXIT_QUICKSANDS 	8

	// #define PLAYER_VY_JETPAC_MAX			12		// Jetpac values
	// #define PLATER_AY_JETPAC 			2

	#define PLAYER_VY_JUMP_INITIAL			127
	#define PLAYER_VY_JUMP_RELEASE			64
	#define PLAYER_VY_JUMP_A_STEPS 			6
	//#define PLAYER_AY_JUMP				8

	//#define PLAYER_VY_JUMP_FROM_ENEM 		32
	
	//#define PLAYER_AY_PROPELLER			2
	//#define PLAYER_VY_PROPELLER_MAX		32

	//#define PLAYER_G_WATER 				1
	//#define PLAYER_VY_MAX_SINK_WATER		16
	//#define PLAYER_VY_OUT_OF_WATER		64
	//#define PLAYER_AY_SWIM				24
	//#define PLAYER_VY_SWIM_MAX			24

	//#define PLAYER_AX_SWIMMING			1
	//#define PLAYER_RX_SWIMMING			2
	//#define PLAYER_VX_MAX_SWIMMING		20

	#define PLAYER_V_INERTIA				4
	#define PLAYER_V_REBOUND				127
	#define PLAYER_V_REBOUND_MULTI			127
	#define PLAYER_VY_BUTT_REBOUND			48
	#define PLAYER_HIT_FRAMES				16
	#define PLAYER_REBOUND_REVERSE_DIRECTION

	#define PLAYER_VY_FLICK_TOP				96
	#define PLAYER_VY_FLICK_TOP_SWIMMING	PLAYER_VY_SWIM_MAX

	// Breakable walls

	//#define BREAKABLE_WALLS
	#define BREAKABLE_PERSISTENT					// Make changes persistent. Does not work with RLE'd maps.
	#define BREAKABLE_MAX 					4		// Breaking at the same time
	#define BREAKABLE_FRAMES_DESTROY		8		// Show breaking tile for N frames
	#define BREAKABLE_BREAKING_TILE			31
	#define BREAKABLE_BIT					128		// 1?????? ????????

	// Define those so you have to hit tiles several times
	// Each time you hit, the attr gets added the INCREMENT_COUNTER.
	// Tile is broken if attr & MASK == HITS. Do your bit math.
	//#define BREAKABLE_AND_MASK			0x60	// ??11?? ????????
	//#define BREAKABLE_HITS 				0x60	// ??11?? ????????
	//#define BREAKABLE_INCREMENT_COUNTER	0x20    // ??01?? ????????
	//#define BREAKABLE_FRAMES_HIT			4

	#define BREAKABLE_TILE_SPECIAL			12		// If the broken tile is this one, spawn
	#define BREAKABLE_TILE_GET				22		// this tile if this expression is true:
	#define BREAKABLE_TILE_EXPRESION		((rand8()&3))

// Hotspots
// Define those to include all related code

	
	#define HOTSPOT_TYPE_OBJECT				1
	#define HOTSPOT_TYPE_KEY 				2
	#define HOTSPOT_TYPE_REFILL 			3
	//#define HOTSPOT_TYPE_AMMO				4
	
	#define HOTSPOTS_BASE_TILE				31		// Draw tile hrt+constant
	#define HOTSPOTS_RESTORE_WITH_MAP_DATA			// Delete hotspot tile with the proper tile.

	//#define HOTSPOT_SIMPLE_SIGNS			2		// For simple signs. Text id is encoded in the top 4 bits.
	//#define HOTSPOT_TYPE_STAR				5

	//#define HOTSPOTS_MAY_CHANGE					// Copy hotspot type to RAM. It may change ingame
	//#define DISABLE_HOTSPOTS

// Expand upon this when needed

	#if defined (PLAYER_CAN_FIRE) || defined (PLAYER_SPINS_KILLS) || defined (PLAYER_STEPS_ON_ENEMIES) || defined (ENEMS_DIE_ON_EVIL_TILE) || defined (ENABLE_HITTER) || defined (PLAYER_PUSH_BOXES_CRUSH_CRUDE)
	#define ENEMIES_CAN_DIE			
	#endif

	#if defined (PLAYER_DIE_AND_RESPAWN) || defined (ENABLE_HOLES)
	#define PLAYER_SAFE
	#endif

// Handy (expand?)
	#if defined (HOTSPOT_TYPE_KEY) || defined (PLAYER_PUSH_BOXES)
	#define PLAYER_PROCESS_BLOCK
	#endif

	#if defined (ENABLE_WATER) || defined (EVIL_TILE_CENTER)
	#define PLAYER_ENABLE_CENTER_DETECTIONS
	#endif

	#if MAX_PANTS>42 && defined (CPC) && defined (PERSISTENT_ENEMIES)
	#define PERSISTENT_ENEMIES_PACKED
	#endif

// Scripting stuff

	//#define SCRIPTING_ON
	#define ACTION_KEY_DOWN
	//#define ACTION_KEY_FIRE

	//#define CLEAR_FLAGS
	#define MAX_FLAGS 						4
	//#define COUNT_KILLED_ON_FLAG 			1
	#define ONLY_ONE_OBJECT_FLAG 			2
	//#define PLAYER_INV_FLAG				0 		// Exports pinv to this flag

	//#define LINE_OF_TEXT_Y				24
	//#define LINE_OF_TEXT_X				1

	#define ENABLE_FIRE_ZONE
	//#define ENABLE_EXTERN_CODE
	//#define FIRE_SCRIPT_WITH_ANIMATION

	//#define ENABLE_CONTAINERS
	#define CONTAINERS_MAX 					5		// As few as you need!
	//#define CONTAINER_ACTION_STOPS_CHECKS			// ifdef, container hit means no fire script ran
	#define CONTAINERS_HAS_GOT_FLAG			30
	#define CONTAINERS_X 					sc_x
	#define CONTAINERS_Y 					(sc_y+1)
	#define CONTAINERS_N 					sc_n

	//#define SPRITE_NO 					ssmisc_05

	// Some stuff make hotspots managing slightly more complex

	#if defined (ONLY_ONE_OBJECT_FLAG) || defined (HOTSPOT_SIMPLE_SIGNS)
	#define HOTSPOTS_LOGIC_MORE_COMPLEX
	#endif

// Animation cells

	#ifdef SPECCY
		#define CELL_FACING_RIGHT 				0
		#define CELL_FACING_LEFT 				4
		#define CELL_IDLE 						0
		#define CELL_WALK_BASE 					1
	 	#define CELL_JUMP 						4
	#endif
	
	#ifdef CPC
		#define CELL_FACING_RIGHT 				0
		#define CELL_FACING_LEFT 				6
		#define CELL_IDLE 						0
		#define CELL_WALK_BASE 					1
	 	#define CELL_JUMP 						5
	#endif

// SFX

	#define SFX_JUMP						0
	#define SFX_COIN						1
	#define SFX_DEATH						2
	#define SFX_BRICK						3
	#define SFX_COCO						4
	#define SFX_ITEM						5
	#define SFX_ENEMY_HIT					6
	#define SFX_SHOOT						6 // TODO

// Flick
	
	#define FLICK_NO 						0
	#define FLICK_LEFT 						1
	#define FLICK_RIGHT 					2
	#define FLICK_UP 						3
	#define FLICK_DOWN 						4

// Make code more readable:

	#define MONOCOCO_COUNTER 				en_my
	#define _MONOCOCO_COUNTER				_en_my

	#define GYROSAW_COUNTER 				en_mx
	#define GYROSAW_DIRECTION				en_my
	#define _GYROSAW_DIRECTION				_en_my
	#define _GYROSAW_COUNTER 				_en_mx
	
	#define CATACROCK_COUNTER 				en_mx
	#define CATACROCK_WAIT 					en_my
	#define _CATACROCK_WAIT 				_en_my
	#define _CATACROCK_COUNTER				_en_mx
	#define _CATACROCK_STATE 				_en_state

	#define GENERATONI_COUNTER 				en_x2
	#define GENERATONI_WAIT 				en_y2
	#define GENERATONI_HL 					en_my
	#define _GENERATONI_COUNTER 			_en_x2
	#define _GENERATONI_WAIT 				_en_y2
	#define _GENERATONI_HL 					_en_my

	#define STEADY_SHOOTER_DIRECTION		en_my
	#define STEADY_SHOOTER_WAIT				en_mx
	#define _STEADY_SHOOTER_WAIT 			_en_mx
	#define _STEADY_SHOOTER_DIRECTION       _en_my

	#define SAW_ORIENTATION					en_s
	#define SAW_EMERGING_DIRECTION			en_my
	#define SAW_MOVING_DIRECTION 			en_mx
	#define _SAW_EMERGING_DIRECTION			_en_my
	#define _SAW_MOVING_DIRECTION 			_en_mx

	#define PEZON_TIMER 					en_mx
	#define PEZON_MAX_TIME					en_y2
	#define PEZON_INCS_IDX 					en_my
	#define _PEZON_TIMER					_en_mx
	#define _PEZON_MAX_TIME					_en_y2
	#define _PEZON_INCS_IDX					_en_my

	#define SW_SPRITES_16x24_BASE			0
	#define SW_SPRITES_16x16_BASE			SW_SPRITES_16x24_BASE+SW_SPRITES_16x24
	#define SW_SPRITES_16x8_BASE			SW_SPRITES_16x16_BASE+SW_SPRITES_16x16
	#define SW_SPRITES_8x16_BASE			SW_SPRITES_16x8_BASE+SW_SPRITES_16x8
	#define SW_SPRITES_8x8_BASE				SW_SPRITES_8x16_BASE+SW_SPRITES_8x16
	
	// Custom stuff

	//#define PGAUGE_MAX 					7
	//#define PGAUGE_TRANSFORM_PENALTY		4

// platform-related features
	#ifdef SPECCY
		#define CONTROLLER_READ 				((joyfunc) (&keys));
		#define CONTROLLER_LEFT(a)				(((a) & sp_LEFT) == 0)
		#define CONTROLLER_RIGHT(a)				(((a) & sp_RIGHT) == 0)
		#define CONTROLLER_UP(a)				(((a) & sp_UP) == 0)
		#define CONTROLLER_DOWN(a)				(((a) & sp_DOWN) == 0)
		#define BUTTON_A(a)						(sp_KeyPressed (key_jump))
		#define BUTTON_B(a)						(((a) & sp_FIRE) == 0)

		#define SCREEN_UPDATE					sp_UpdateNow ()
		#define SCREEN_UPDATE_NO_SPRITES		sp_UpdateNow ()
		#define SPRITE_CELL_PTR_UPDATE(a)		spr_cur [(a)] = spr_next [(a)]
		#define SPRITE_UPDATE_ABS(a, x, y)		sp_MoveSprAbs (sp_sw [(a)], spritesClip, spr_next [(a)] - spr_cur [(a)], SCR_Y - 1 + ((y)>>3), SCR_X + ((x)>>3), (x) & 7, (y) & 7)
		#define SPRITE_OUT(a)					sp_MoveSprAbs (sp_sw [(a)], spritesClip, 0, -2, -2, 0, 0);

		#define KEY_ASCII						sp_GetKey ()
		#define CLEAR_RECT(a)					sp_ClearRect (a, 0, 0, sp_CR_ALL); sp_Invalidate (a, a);

		#define RECT_FULL_SCREEN				(fsRect)
		#define RECT_GAME_AREA					(spritesClip)

		#define DRAW_PATTERN(x,y,c,p)			sp_PrintAtInv ((y), (x), (c), (p));
		#define DRAW_PATTERN_UPD(x,y,c,p)		sp_PrintAtInv ((y), (x), (c), (p));
	#endif

	#ifdef CPC
		#define CONTROLLER_READ
		#define CONTROLLER_LEFT(a)				((pad != 0xff) && cpc_TestKey (KEY_LEFT))
		#define CONTROLLER_RIGHT(a)				((pad != 0xff) && cpc_TestKey (KEY_RIGHT))
		#define CONTROLLER_UP(a) 				((pad != 0xff) && cpc_TestKey (KEY_UP))
		#define CONTROLLER_DOWN(a)				((pad != 0xff) && cpc_TestKey (KEY_DOWN))
		#define BUTTON_A(a)						((pad != 0xff) && cpc_TestKey (KEY_BUTTON_A))
		#define BUTTON_B(a)						((pad != 0xff) && cpc_TestKey (KEY_BUTTON_B))

		#define SCREEN_UPDATE					cpc_screen_update ();
		#define SCREEN_UPDATE_NO_SPRITES		cpc_ShowTileMap (0);
		#define SPRITE_CELL_PTR_UPDATE(a)		sp_sw [(a)].sp0 = (int) (spr_next [(a)])
		#define SPRITE_UPDATE_ABS(a,x,y)		{ sp_sw [(a)].cx = (((x) + SCR_X*8) >> 2); sp_sw [(a)].cy = (y) + SCR_Y*8; }
		#define SPRITE_OUT(a)					{ sp_sw [(a)].sp0 = (int) (ss_empty); sp_sw [(a)].cx = sp_sw [(a)].cy = 0; }

		#define KEY_ASCII						sp_GetKey ()
		#define CLEAR_RECT(a)					cpc_clear_rect (a)

		#define RECT_FULL_SCREEN				0
		#define RECT_GAME_AREA					1

		#define DRAW_PATTERN(x,y,c,p)			cpc_SetTile ((x), (y), (p))
		#define DRAW_PATTERN_UPD(x,y,c,p)		cpc_SetTouchTileXY ((x), (y), (p))
	#endif

	#define SCR_BUFFER_SIZE 192

#if SPRITES_SMALL_CELLS > 0
	#define NEED_SMALL_SPRITES
#endif

#define IS_BREAKABLE(a) ((a)&BREAKABLE_BIT)
#define IS_OBSTACLE_HARD(a) ((a)&OBSTACLE_BIT)

#if defined (PLAYER_CAN_FIRE) || defined (PLAYER_STEPS_KILLS) || defined (PLAYER_SPINS_KILLS) || defined (PLAYER_PUNCHES)
	#define ENEMS_CAN_DIE
#endif

// Custom flags for level properties may go here. Or may not.
 
#define ENABLE_PUMPKIN
