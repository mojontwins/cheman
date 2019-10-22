// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Simple coco

void simplecoco_init (void) {
	coco_it = COCOS_MAX; while (coco_it --) {
		coco_y [coco_it] = 0;
#ifdef ONE_PER_ENEM
	}
#else
		coco_slots [coco_it] = coco_it;
	}
	coco_slot = COCOS_MAX;
#endif
}

#ifdef ENABLE_COCO_AIMED
void simplecoco_aimed_new () {

#ifdef ONE_PER_ENEM
	coco_it = gpit; if (0 == coco_y [coco_it]) {
#else
	if (coco_slot) {
		coco_slot --; coco_it = coco_slots [coco_slot];
#endif

		// Calculate distance
		rda = DELTA (prx, rdx); // dx
		rdb = DELTA (pry, rdy); // dy
		rdc = MIN (rda, rdb);	// MIN (dx, dy)
		rdct = rda + rdb - (rdc >> 1) - (rdc >> 2) + (rdc >> 4);
		
#if defined(COCO_FAIR_D) && COCO_FAIR_D > 0
		if (rdct > COCO_FAIR_D) 
#endif
		{
			// Shoot towards the player.
			_coco_x = rdx << FIX_BITS;
			_coco_y = rdy << FIX_BITS;

			// Apply formula. Looks awkward but it's optimized for space and shitty compiler
			rdsint = COCO_V * rda / rdct; coco_vx [coco_it] = ADD_SIGN2 (px, _coco_x, rdsint);
			rdsint = COCO_V * rdb / rdct; coco_vy [coco_it] = ADD_SIGN2 (py, _coco_y, rdsint);

			// Fill arrays
			coco_x [coco_it] = _coco_x;
			coco_y [coco_it] = _coco_y;
			
			SFX_PLAY (SFX_COCO);
		}
	}
}
#endif

#ifdef ENABLE_COCO_AIMED_DOWN
void simplecoco_straight_down () {
#ifdef ONE_PER_ENEM
	coco_it = gpit; if (0 == coco_y [coco_it]) {
#else	
	if (coco_slot) {
		coco_slot --; coco_it = coco_slots [coco_slot];
#endif

		if (pry > rdy + 32) {
			coco_x [coco_it] = rdx << FIX_BITS;
			coco_y [coco_it] = rdy << FIX_BITS;
			coco_vx [coco_it] = 0;
			coco_vy [coco_it] = COCO_V;
		}
	}
}
#endif

#ifdef ENABLE_COCO_STRAIGHT
void simplecoco_straight_new () {

	// Create coco @ rdx, rdy, direction rda
#ifdef ONE_PER_ENEM				
	coco_it = gpit; if (0 == coco_y [coco_it]) {
#else	
	if (coco_slot) {
		coco_slot --; coco_it = coco_slots [coco_slot];
#endif

		coco_x [coco_it] = rdx << FIX_BITS;
		coco_y [coco_it] = rdy << FIX_BITS;
		coco_vx [coco_it] = coco_vx_precalc [rda];
		coco_vy [coco_it] = coco_vy_precalc [rda];

		SFX_PLAY (SFX_COCO);
	} 

}
#endif

#ifndef ONE_PER_ENEM
void simplecoco_destroy (void) {
	coco_y [coco_it] = 0;
	coco_slots [coco_slot] = coco_it; coco_slot ++;
}
#endif

void simplecoco_do (void) {
	coco_it = COCOS_MAX; while (coco_it --) {		
		spr_idx = SPR_COCOS_BASE + coco_it;


		if (coco_y [coco_it]) {
			// Move
			_coco_x = coco_x [coco_it] + coco_vx [coco_it];
			_coco_y = coco_y [coco_it] + coco_vy [coco_it];

			// Out of bounds
			if (_coco_x < 0 || _coco_x > (PRX_MAX_COCO<<FIX_BITS) || _coco_y < (16<<FIX_BITS) || _coco_y > (PRY_MAX_COCO<<FIX_BITS)) {

#ifdef ONE_PER_ENEM
				coco_y [coco_it] = 0;
#else
				simplecoco_destroy (); 
#endif
				break;
			}

			rdx = _coco_x >> FIX_BITS;
			rdy = _coco_y >> FIX_BITS;

			// Render
			spr_on [spr_idx] = 1;
			spr_x [spr_idx] = rdx;
			spr_y [spr_idx] = rdy;

			spr_next [spr_idx] = sprite_cells [COCO_CELL_BASE];

			// Collide w/player
			if (rdx >= prx + 1 && rdx <= prx + 7 && rdy + 7 >= pry && rdy <= pry + 12
	#ifdef PLAYER_FLICKERS
				&& !pflickering
	#else				
				&& !phit
	#endif
			) {
				pwashit = 1;
#ifdef ONE_PER_ENEM
				coco_y [coco_it] = 0;
#else
				simplecoco_destroy (); 
#endif
			}

			coco_x [coco_it] = _coco_x;
			coco_y [coco_it] = _coco_y;
		} else spr_on [spr_idx] = 0;

	}
}
