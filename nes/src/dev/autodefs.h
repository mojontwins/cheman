// NES MK1 v1.0
// Copyleft Mojon Twins 2013, 2015, 2017, 2018

// Inner workings. Don't touch.

#define CATACROCK_WAIT			_en_mx

#if defined (ENABLE_MONOCOCOS) || (defined (ENABLE_COMPILED_ENEMS) && defined (COMPILED_ENEMS_SHOOT)) || (defined (ENABLE_PURSUERS) && defined (PURSUERS_MAY_FIRE))
#define ENABLE_COCOS
#define COCOS_ENABLE_AIMED
#endif

#if defined (ENABLE_SHOOTIES) || defined (ENABLE_STEADY_SHOOTERS)
#define ENABLE_COCOS
#define COCOS_ENABLE_LINEAR
#endif

#ifdef ENABLE_EASY_OBJECTS
#define HOTSPOTS_DYNAMIC
#define CARRY_ONE_HS_OBJECT
#endif

#ifdef ENABLE_PROPELLERS
#define PLAYER_CAN_FLOAT
#endif

#if defined (ENABLE_LADDERS) || defined (ENABLE_PROPELLERS) || defined (ENABLE_SPRINGS) /*|| defined (ENABLE_TRAMPOLINES)*/
#define NEEDS_INITIAL_DETECTION
#endif

#if defined (ENABLE_TILE_GET) || defined (CUSTOM_CENTER_DETECTIONS)
#define NEEDS_CENTER_DETECTION
#endif

#if defined (PLAYER_STEPS_ON_ENEMS) || defined (PLAYER_CAN_FIRE) || defined (PLAYER_KICKS) || defined (PLAYER_PUNCHES) || defined (ENEMIES_SUFFER_ON_PLAYER_COLLISION) || defined (FANTY_KILLED_BY_TILE) || defined (PLAYER_SPINS)
#define ENEMS_MAY_DIE
#endif

#ifdef GAME_AREA_TOP
#define TOP_ADJUST				2
#define SCROLL_Y				8
#endif

#ifdef GAME_AREA_MIDDLE
#define TOP_ADJUST				4
#define SCROLL_Y				8
#endif

#ifdef GAME_AREA_BOTTOM
#define TOP_ADJUST				6
#define SCROLL_Y				8
#endif

#ifdef GAME_AREA_CUSTOM
#define TOP_ADJUST				6
#define SCROLL_Y				12
#endif

#define SPRITE_ADJUST			8*TOP_ADJUST - SCROLL_Y - 16 - 1

#if defined (SMALL_COLLISION) 
	#define ENEMS_UPPER_COLLISION_BOUND 14
#elif defined (TALL_COLLISION)
	#define ENEMS_UPPER_COLLISION_BOUND 24
#else
	#define ENEMS_UPPER_COLLISION_BOUND 12
#endif

#if defined (ACTIVATE_SCRIPTING) && defined (LINE_OF_TEXT)
	#define ENABLE_UL_PRINTER
#endif

#if defined (ENABLE_INTERACTIVES) && !defined (ACTIVATE_SCRIPTING)
	#define INTERACTIVES_FROM_CODE
#endif

#if defined (MAP_FORMAT_RLE53_CHRROM)
	#define MAP_RENDERER_COMPLEX
#endif

#if defined (ENABLE_TILE_GET) && defined (PERSISTENT_TILE_GET)
	#define MAP_RENDERER_COMPLEX
#endif

#if defined (ENABLE_BREAKABLE) && BREAKABLE_LIFE == 1
	#define BREAKABLES_SOFT
#endif

#if defined (ENEMS_FLICKER_ONLY_ON_DYING)
	#define ENEMS_FLICKER
#endif

#if (ENEMS_LIFE_GAUGE > 1) || ((defined (ENABLE_FANTY) || defined (ENABLE_HOMING_FANTY)) && defined (FANTY_LIFE_GAUGE) && (FANTY_LIFE_GAUGE > 1))
	#define NEEDS_LIFE_GAUGE_LOGIC
#endif

#if defined (CHAC_CHAC_FROM_MAP)
	#undef ENABLE_CHAC_CHAC
	#define ENABLE_TILE_CHAC_CHAC
#endif

#if defined (ENABLE_CHAC_CHAC) || defined (ENABLE_TILE_CHAC_CHAC)
	#define ENABLE_SHAKER
#endif

#if defined (ENABLE_FANTY) || defined (ENABLE_HOMING_FANTY) || defined (ENABLE_TIMED_FANTY) || defined (ENABLE_BOIOIONG) || defined (ENABLE_CATACROCKS)
	#define ENEMS_NEED_FP
#endif

#if defined (PLAYER_TOP_DOWN) && defined (NO_HORIZONTAL_EVIL_TILE)
	#undef NO_HORIZONTAL_EVIL_TILE
#endif

