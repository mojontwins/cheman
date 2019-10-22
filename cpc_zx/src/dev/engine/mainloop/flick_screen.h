// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// Change screen
	// Very basic. Extend when needed.
#ifndef NO_AUTOFLICK
		if (prx == 4 && pvx < 0 && n_pant) {
			n_pant --; px = PRX_MAX<<FIX_BITS;
		} else if (prx == PRX_MAX && pvx > 0) {
			n_pant ++; px = 4<<FIX_BITS;
		} 

		if (pry <= ABSOLUTE_BOTTOM && pvy < 0
	#ifdef MAP_CHECK_TOP
			&& n_pant >= c_level [LEVEL_MAP_W]
	#endif
		) {
			n_pant -= c_level [LEVEL_MAP_W]; py = PRY_MAX<<FIX_BITS;		

	#if defined (PLAYER_JUMPS) || defined (PLAYER_MONONO)
			#ifdef ENABLE_WATER
				if (pwater) pvy = -PLAYER_VY_FLICK_TOP_SWIMMING; else
			#endif
			{ pvy = -PLAYER_VY_FLICK_TOP; pj = 1; pctj = 0; pjustjumped = 1; }
	#endif

		} else if (pry >= PRY_MAX && pvy > 0) {
			n_pant += c_level [LEVEL_MAP_W]; py = ABSOLUTE_BOTTOM<<FIX_BITS;
		}
#endif
	
if (on_pant != n_pant && do_game) {
	prx = px >> FIX_BITS; pry = py >> FIX_BITS;
	game_prepare_screen ();
	on_pant = n_pant;
	isrc = 0;
	#ifdef CPC
		isrc_max = 0;
	#endif
} 
