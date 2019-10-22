// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

//#define DEBUG
//#define CHEAT_ON

// Main memory allocation & setup
#ifdef SPECCY
	// splib2 memory map:
	// 61440 - 61696  IM 2 Interrupt Vector Table (optional) 
	// 61697 - 61936  Free (240 bytes) 
	// 61937 - 61948  Generic Interrupt Service Routine @ 0xf1f1 (optional) 
	// 61949 - 61951  Free (3 bytes) 
	// 61952 - 65535  Horizontal Rotation Tables (optional)

	#ifdef MODE_128K
		#pragma output STACKPTR=24049
		#define FREEPOOL 		61697
		#define BASE_EP 		61857	// (FREEPOOL+160);
	#else
		//#pragma output STACKPTR=61952
		#pragma output STACKPTR=61936
		#define RAMTOP 			61440

		#define TEXTBUFF		23296
		#define BASE_EP 		23296 + 116
		#define FREEPOOL 		23296 + 116 + 252

		#define BASE_BREAKABLE	23296 + 116 + 252 + 384

	#endif
#endif

#ifdef CPC
	// This does not work. That's why I have replaced
	// cpc_crt0.asm. You can find my modified copy in
	// the cpc folder.
	// #pragma output STACKPTR=0xFFFF

	#define TEXTBUFF		0xC000 + 0x600
	#define FREEPOOL 		0xC800 + 0x600
	#define BASE_EN 		0xD000 + 0x600
	#define BASE_BREAKABLE	0xD800 + 0x600
	#define BASE_SPRITES 	0xE000 + 0x600
	#define BASE_SFX		0xE800 + 0x600	
	#define BASE_EP 		0xF000 + 0x600
	#define BASE_LUT		0xF800 + 0x600

	#define BASE_ARKOS		34868 	// 0x8834
	#define BASE_MUSIC		32250	// 0x7DFA
	#define BASE_SUPERBUFF	0x9000

	// Arkos addresses
	#define PLY_STOP		BASE_ARKOS+0x0753
	#define PLY_INIT		BASE_ARKOS+0x06FE
	#define PLY_SFX_INIT	BASE_ARKOS+0x0762
	#define PLY_PLAY 		BASE_ARKOS+0x000A // 0x883E
	#define PLY_SFX_PLAY	BASE_ARKOS+0x0776

	extern unsigned char nametable [0];

	#define SIZE_ARKOS_COMPRESSED 1149
#endif

#ifdef SPECCY
#include <spritepack.h>
#endif

#ifdef CPC
#include <cpcrslib.h>
#endif

#include "definitions.h"		// Main #defines
#include "ram/globals.h"		// Variables

#ifdef CPC
	#include "assets/pal.h"
	// CUSTOM {
	#include "assets/pal2.h"
	// } END_OF_CUSTOM
#endif

#include "_somedefs.h"

// Compressed stuff at the beginning.
#include "assets/library.h"

// The script
#ifdef SCRIPTING_ON
	#include "assets/scripts.h"
#endif

// Now, text
#ifdef ENABLE_TEXT_WINDOW
	#include "assets/texts.h"
#endif

// Now, stuff.
#include "ram/heap.h"			// Space for stuff (level + graphics)

#include "assets/levelset.h"
#include "assets/spriteset.h"
#include "assets/precalcs.h"
#include "assets/dynamic_sprite_sizes.h"

// Utils
#include "util/aplib.h"
#include "util/random.h"
//#include "util/passwd_ninjajar_M.h"

#include "util/general.h"
#include "util/librarian.h"

#ifdef SPECCY
	#include "util/system_speccy.h"
#endif
#ifdef CPC
	#include "util/system_cpc.h"
#endif
	
#include "util/collisions.h"
#include "util/controls.h"

// Sound
#ifdef CPC
	#include "sound/arkos_cpc.h"
#endif

// Engine
#include "engine/printer.h"
#ifdef ENABLE_TIMED_MESSAGE
	#include "engine/timed_message.h"
#endif
#ifdef ENABLE_TEXT_WINDOW
	#include "engine/text_window.h"
#endif
#ifdef ENABLE_COCOS
	#include "engine/simplecoco.h"
#endif	
#ifndef DISABLE_HOTSPOTS
	#include "engine/hotspots.h"
#endif
#ifdef HOTSPOT_TYPE_KEY
	#include "engine/bolts.h"
#endif
#ifdef BREAKABLE_WALLS
	#include "engine/breakable.h"
#endif
#ifdef FLOATY_PUSH_BOXES
	#include "engine/fpb.h"
#endif
#ifdef ENABLE_HITTER
	#include "engine/hitter.h"
#endif
#ifdef PLAYER_CAN_FIRE
	#include "engine/bullets.h"
#endif
#include "engine/enems.h"
#include "engine/player.h"
#include "engine/hud.h"
#ifdef SCRIPTING_ON
	#ifdef ENABLE_EXTERN_CODE
		#include "engine/extern.h"
	#endif
	#include "engine/msc.h"
#endif
#include "engine/level_setup.h"

#include "engine/game.h"


#include "main.h"				// Main loop

// Sound
#ifdef SE_BEEPER
	#include "sound/beeper_music.h"
	#include "sound/beeper_sfx.h"
#endif

extern unsigned char END_OF_MAIN_BIN [0];
