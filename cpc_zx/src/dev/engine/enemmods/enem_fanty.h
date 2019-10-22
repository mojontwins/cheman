// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// half_life is used here to balance load...

	if (fanty_timer [gpit]) {
		fanty_timer [gpit] --;
	} else {
		// Modify v
		if (!half_life) {
			if (enf_x [gpit] > px) {
				enf_vx [gpit] -= (FANTY_A+FANTY_A); if (enf_vx [gpit] < -FANTY_MAXV) enf_vx [gpit] = -FANTY_MAXV;
			} else if (enf_x [gpit] < px) {
				enf_vx [gpit] += (FANTY_A+FANTY_A); if (enf_vx [gpit] > FANTY_MAXV) enf_vx [gpit] = FANTY_MAXV;
			}
			if (enf_y [gpit] > py) {
				enf_vy [gpit] -= (FANTY_A+FANTY_A); if (enf_vy [gpit] < -FANTY_MAXV) enf_vy [gpit] = -FANTY_MAXV;
			} else if (enf_y [gpit] < py) {
				enf_vy [gpit] += (FANTY_A+FANTY_A); if (enf_vy [gpit] > FANTY_MAXV) enf_vy [gpit] = FANTY_MAXV;
			}
		}

		// Horizontal
		enf_x [gpit] += enf_vx [gpit]; 
		enf_y [gpit] += enf_vy [gpit]; 

		if (half_life) {
			if (enf_x [gpit] < 4 << FIX_BITS) enf_x [gpit] = 4 << FIX_BITS;
			if (enf_x [gpit] > 236 << FIX_BITS) enf_x [gpit] = 236 << FIX_BITS;
			
			if (enf_y [gpit] < 4 << FIX_BITS) enf_y [gpit] = 4 << FIX_BITS;
			if (enf_y [gpit] > 176 << FIX_BITS) enf_y [gpit] = 176 << FIX_BITS;
		}	
	}

	_en_x = enf_x [gpit] >> FIX_BITS;
	_en_y = enf_y [gpit] >> FIX_BITS;
	spr_id = FANTY_CELL_BASE + half_life + ((enf_x [gpit] < px) ? 0 : 2);
	// enems_spr ();

