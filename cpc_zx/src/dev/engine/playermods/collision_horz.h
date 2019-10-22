// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Player collisions with bg in the horizontal axis
	
	#ifdef PLAYER_8_PIXELS
		cy1 = (pry + 6) >> 4;
	#else
		cy1 = (pry + 1) >> 4;
	#endif
	cy2 = (pry + 15) >> 4;
	if (pvx + pgtmx) {
		if (pvx + pgtmx < 0) {
			cx1 = cx2 = prx >> 4;
			cm_two_points ();
			
			#ifdef PLAYER_GENITAL
				if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) {
			#else
				if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT)) {
			#endif
				pvx = 0;
				prx = (cx1 + 1) << 4;
				px = prx << FIX_BITS;
			} else {

#ifdef ENABLE_HOLES
				if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT))) player_holed ();
#endif

#ifdef EVIL_TILE_MULTI
#ifdef PLAYER_SMALLER_ETCB
				cy1 = (pry + PLAYER_ETCB_UP) >> 4;
				cy2 = (pry + PLAYER_ETCB_DOWN) >> 4;
				cx1 = cx2 = (prx + PLAYER_ETCB_LEFT) >> 4;
				cm_two_points (); 
#endif
				if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
					pvx = PLAYER_V_REBOUND_MULTI; evil_tile_hit = 1;
				}
#endif
			}
		} else if (pvx + pgtmx > 0)	{
			cx1 = cx2 = (prx + 7) >> 4; 
			cm_two_points (); 
#ifdef PLAYER_GENITAL
			if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) {
#else
	 		if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT)) {
#endif
				pvx = 0;
				prx = ((cx1 - 1) << 4) + 8;
				px = prx << FIX_BITS;
			} else {

#ifdef ENABLE_HOLES
				if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT))) player_holed ();
#endif			

#ifdef EVIL_TILE_MULTI
#ifdef PLAYER_SMALLER_ETCB
				cy1 = (pry + PLAYER_ETCB_UP) >> 4;
				cy2 = (pry + PLAYER_ETCB_DOWN) >> 4;
				cx1 = cx2 = (prx + PLAYER_ETCB_RIGHT) >> 4;
				cm_two_points (); 
#endif
				if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
					pvx = -PLAYER_V_REBOUND_MULTI; evil_tile_hit = 1;
				}
#endif
			}
		}
#ifdef PLAYER_PROCESS_BLOCK
#ifdef PLAYER_GRAVITY
		if ((at1 & SPECIAL_BEH) == SPECIAL_BEH) { __x = cx1; __y = cy1; player_process_block (); }
		if ((cy1 != cy2) && ((at2 & SPECIAL_BEH) == SPECIAL_BEH)) { __x = cx1; __y = cy2; player_process_block (); }
#else
		if ((at1 & SPECIAL_BEH) == SPECIAL_BEH) { __x = cx1; __y = cy1; __d = 1; player_process_block (); }
		if ((cy1 != cy2) && ((at2 & SPECIAL_BEH) == SPECIAL_BEH)) { __x = cx1; __y = cy2; __d = 1; player_process_block (); }
#endif
#endif
	}

	// In the CPC it's interesting to byte-adjust X coordinates
	// if player has stopped.
#ifdef CPC
	if ((pvx + pgtmx) == 0 && (prx & 0x03)) {
		prx = prx & 0xfc; 	// >>2)<<2)
		px = prx << FIX_BITS;
	}
#endif	
