// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Player collisions with bg in the vertical axis

cx1 = prx >> 4;
cx2 = (prx + 7) >> 4;
rdsint = pvy + pgtmy;
if (rdsint) {
	if (rdsint < 0) {
		#ifdef PLAYER_8_PIXELS
			cy1 = cy2 = (pry + 6) >> 4;
		#else
			cy1 = cy2 = (pry + 1) >> 4;
		#endif
		cm_two_points ();
		#ifdef PLAYER_GENITAL
			if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS))
		#else
			if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT))
		#endif
		{
			pgotten = pvy = 0;
			#ifdef PLAYER_8_PIXELS
				pry = ((cy1 + 1) << 4) - 6;
			#else
				pry = ((cy1 + 1) << 4) - 1;
			#endif
			py = pry << FIX_BITS;
		} else {

		#ifdef EVIL_TILE_MULTI
			if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
				pvy = PLAYER_V_REBOUND_MULTI; evil_tile_hit = 1;
			}
		#endif	

		#ifdef ENABLE_HOLES
			if (!pholed) {
				cy1 = cy2 = (pry + 14) >> 4;
				cm_two_points ();
				if ((at1 & HOLE_BIT) && (at2 & HOLE_BIT)) player_holed ();
			} 
		#endif

		#ifdef ENABLE_QUICKSANDS
			if ((at1 & QUICKSANDS_BIT) || (at2 & QUICKSANDS_BIT)) {
				//if (pctj > 2) pj = pvy = 0;
				if (pvy < -PLAYER_VY_EXIT_QUICKSANDS) pvy = -PLAYER_VY_EXIT_QUICKSANDS;
			}
		#endif
		}
	} else {
		cy1 = cy2 = (pry + 15) >> 4; 
		cm_two_points (); 
		#ifdef PRECISE_DESCENDING_COLLISION			
 			if (((pry - 1) & 15) < (1 + (rdsint >> 4)) && ((at1 & (OBSTACLE_BIT | PLATFORM_BIT)) || (at2 & (OBSTACLE_BIT | PLATFORM_BIT))))
		#else
 			if ((at1 & (OBSTACLE_BIT | PLATFORM_BIT)) || (at2 & (OBSTACLE_BIT | PLATFORM_BIT)))
		#endif	 			
 		{
			pgotten = pvy = 0;
			pry = (cy1 - 1) << 4;
			py = pry << FIX_BITS;
		} else {
		#ifdef ENABLE_HOLES
			if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT))) player_holed ();
		#endif			

		#ifdef EVIL_TILE_MULTI
			if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
				pvy = -PLAYER_V_REBOUND_MULTI; evil_tile_hit = 1;
			}
		#endif		

		#ifdef ENABLE_QUICKSANDS
			if ((at1 & QUICKSANDS_BIT) || (at2 & QUICKSANDS_BIT)) pvy = PLAYER_VY_SINKING;
		#endif	
		}
	}
	#ifdef PLAYER_PROCESS_BLOCK
		#ifdef PLAYER_GENITAL		
			if ((at1 & SPECIAL_BEH) == SPECIAL_BEH) { __x = cx1; __y = cy1; __d = 0; player_process_block (); }
			if ((cx1 != cx2) && ((at2 & SPECIAL_BEH) == SPECIAL_BEH)) { __x = cx2; __y = cy1; __d = 0; player_process_block (); }
		#endif		
	#endif
}

#ifdef PLAYER_GRAVITY
	// Floor detections: possee

	cy1 = cy2 = (pry + 16) >> 4;
	cm_two_points ();
	ppossee = ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) && pvy >= 0 && ((pry & 0xf) == 0);
	#ifdef PLAYER_JUMPS	
		if (ppossee || pgotten) {
			pjustjumped = 0;
			#ifdef PLAYER_DOUBLE_JUMP
				njumps = 0;
			#endif		
		}
	#endif	
#endif	
