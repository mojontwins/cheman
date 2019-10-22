// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Screen update chores

// Update sprites
update_sprites:
gpit = SW_SPRITES_ALL; while (gpit) { -- gpit;
	#ifdef CPC
		if (spr_on [gpit]) {
			SPRITE_UPDATE_ABS (gpit, spr_x [gpit] + SP_SW_COX, spr_y [gpit] - 16 + SP_SW_COY);
			SPRITE_CELL_PTR_UPDATE (gpit);
		} else SPRITE_OUT (gpit);
	#endif

	#ifdef SPECCY
		if (spr_on [gpit]) {
			rdx = spr_x [gpit] + sp_sw_cox [gpit]; 
			rdy = spr_y [gpit] + sp_sw_coy [gpit] - 16;
			sp_MoveSprAbs (
				sp_sw [gpit], 
				(gpit && gpit < 4) ? &(ensClipRects [gpit - SPR_ENEMS_BASE]) : spritesClip, 
				spr_next [gpit] - spr_cur [gpit],
				SCR_Y + (rdy >> 3), 
				SCR_X + (rdx >> 3), 
				rdx & 7, 
				rdy & 7
			);
			spr_cur [gpit] = spr_next [gpit];	
		} else {
			sp_MoveSprAbs (
				sp_sw [gpit], 
				spritesClip, 
				0,
				-2, -2, 0, 0
			);
		}				
	#endif
}

SCREEN_UPDATE;
