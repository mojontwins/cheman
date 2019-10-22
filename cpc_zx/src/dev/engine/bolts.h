// MT MK2 NES v0.87ZCP - Peyejo pendejo!
// Copyleft 2017 by The Mojon Twins

// Bolts

void bolts_load (void) {
	gpit = BOLTS_MAX; while (gpit --) lkact [gpit] = 0;
}

// needs rdc = (y << 4) + x
void bolts_clear_bolt (void) {
	gp_gen = locks;
	for (gpit = 0; gpit < BOLTS_MAX; gpit ++) {
		rda = *gp_gen ++; // Screen
		rdb = *gp_gen ++; // YX
		if (n_pant == rda && rdc == rdb) {
			lkact [gpit] = 1;
			SFX_PLAY (SFX_BRICK);
		}
	}
}

void bolts_update_screen (void) {
	gp_gen = locks;
	for (gpjt = 0; gpjt < BOLTS_MAX; gpjt ++) {
		rda = *gp_gen ++; 	// Screen
		rdb = *gp_gen ++;	// YX
		if (n_pant == rda && lkact [gpjt]) {
			_t  = 0; _x  = rdb & 0xf; _y  = rdb >> 4;
			set_map_tile ();
		}
	}
}
