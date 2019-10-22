// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// levelset.h
// Manually compiled assets lists for levels

// Costomize as needed

// If you need constants as declared by the converters,
// Add / include them here

/*
#ifdef SPECCY
	#include "..\ports\zx\bin\enems.h"
	#include "..\ports\zx\bin\hotspots.h"
#endif
#ifdef CPC
	#include "..\ports\cpc\bin\enems.h"
	#include "..\ports\cpc\bin\hotspots.h"
#endif
*/

#ifdef SPECCY
	#include "..\ports\zx\bin\level0\enems.h"
	#include "..\ports\zx\bin\level0\hotspots.h"
	#include "..\ports\zx\bin\level1\enems.h"
	#include "..\ports\zx\bin\level1\hotspots.h"
#endif
#ifdef CPC
	#include "..\ports\cpc\bin\level0\enems.h"
	#include "..\ports\cpc\bin\level0\hotspots.h"
	#include "..\ports\cpc\bin\level1\enems.h"
	#include "..\ports\cpc\bin\level1\hotspots.h"
#endif

// For me each level is:

// ts_tilemaps
// behs
// map
// enems
// hotspots
// script index in script pool
// ini_x (tiles)
// ini_y (tiles)
// scr_ini
// map_width

#define SCRIPT_INDEX		0
#define PLAYER_INI_X		1
#define PLAYER_INI_Y		2
#define PLAYER_SCR_INI		3
#define LEVEL_MAP_W			4
#define MAX_HOTSPOTS_TYPE_1	5
#define RES_MAP				6
#define RES_LOCKS			7
#define RES_ENEMS			8
#define RES_HOTSPOTS		9
#define RES_BEHS			10
#define RES_TS 				11
#define RES_META			12
#define MAX_KILLABLE_ENEMS	13

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
	LEVEL0_TS_TILEMAPS_C,

	// More stuff
	MAX_ENEMS_0_TYPE_12
};

const unsigned char level1 [] = {
	0,
	9, 3,
	16,
	4,
	MAX_HOTSPOTS_1_TYPE_1,

	// Compressed resources IDs:
	LEVEL1_MAP_C,
	0,
	LEVEL1_ENEMS_C,
	LEVEL1_HOTSPOTS_C,
	LEVEL1_BEHS_C,
	LEVEL1_TS_PATTERNS_C,
	LEVEL1_TS_TILEMAPS_C,

	// More stuff
	MAX_ENEMS_1_TYPE_12	
};

const unsigned char * levels [] = {
	level0, level1
};
