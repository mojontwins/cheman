// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// System Initializacion file

void *my_malloc(uint bytes) {
   return sp_BlockAlloc(0);
}
void *u_malloc = my_malloc;
void *u_free = sp_FreeBlock;

#asm
	defw 0	// 2 bytes libres
#endasm

void ISR(void) {
	isrc ++;
}

void system_init (void) {

	// splib2 initialization
	sp_Initialize (0, 0);
	sp_Border (BLACK);
	
#asm
	di
#endasm

	sp_InitIM2(0xf1f1);
	sp_CreateGenericISR(0xf1f1);
	sp_RegisterHook(255, ISR);
#asm
	ei
#endasm


	// Reserve memory blocks for sprites
	//sp_AddMemory (0, NUMBLOCKS, 14, AD_FREE);
	sp_AddMemory (0, NUMBLOCKS, 14, dynamic_memory_pool);

	// Load tileset
	gp_gen = ts; gpit = 0; do {
		sp_TileArray (gpit ++, gp_gen); gp_gen += 8;
	} while (gpit);

	// Clipping rectangle
	spritesClip = &spritesClipValues;
	
	// Sprite allocation
	rda = 0;

	// 16x24 sprites
	gpit = SW_SPRITES_16x24; while (gpit) { -- gpit;
		sp_sw [rda] = sp_CreateSpr (sp_MASK_SPRITE, 4, ss_main, 1 + rda, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 64, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 128, TRANSPARENT);		
		sp_sw_cox [rda] = 0;
		sp_sw_coy [rda] = -8;
		++ rda;
	}

	// 16x16 sprites. 
	gpit = SW_SPRITES_16x16; while (gpit) { -- gpit;
		sp_sw [rda] = sp_CreateSpr (sp_MASK_SPRITE, 3, ss_main, 1 + rda, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 48, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 96, TRANSPARENT);
		sp_sw_cox [rda] = 0;
		sp_sw_coy [rda] = 0;
		++ rda;
	}

#if defined(SW_SPRITES_16x8) && (SW_SPRITES_16x8 > 0)
	gpit = SW_SPRITES_16x8; while (gpit) { -- gpit;
		sp_sw [rda] = sp_CreateSpr (sp_MASK_SPRITE, 2, ss_main, 1 + rda, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 32, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 64, TRANSPARENT);	
		sp_sw_cox [rda] = 0;
		sp_sw_coy [rda] = 0;
		++ rda;
	}
#endif

#if defined(SW_SPRITES_8x16) && (SW_SPRITES_8x16 > 0)
	gpit = SW_SPRITES_8x16; while (gpit) { -- gpit;
		sp_sw [rda] = sp_CreateSpr (sp_MASK_SPRITE, 3, ss_main, 1 + rda, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 48, TRANSPARENT);
		sp_sw_cox [rda] = 0;
		sp_sw_coy [rda] = 0;
		++ rda;
	}
#endif

#if defined(SW_SPRITES_8x8) && (SW_SPRITES_8x8 > 0)
	gpit = SW_SPRITES_8x8; while (gpit) { -- gpit;
		sp_sw [rda] = sp_CreateSpr (sp_MASK_SPRITE, 2, ss_main, 1 + rda, TRANSPARENT);
		sp_AddColSpr (sp_sw [rda], ss_main + 32, TRANSPARENT);
		sp_sw_cox [rda] = 0;
		sp_sw_coy [rda] = 0;
		++ rda;
	}
#endif

	gpit = SW_SPRITES_ALL; while (gpit) { -- gpit;
		spr_cur [gpit] = spr_next [gpit] = ss_main;
	}
}
