// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Floaty push boxes

// Will create an instance whenever a push box is moved 

void fpb_init (void) {
	gpit = FPB_MAX; while (gpit --) {
		fpb_ac [gpit] = 0;
		fpb_slots [gpit] = gpit;
	}
	fpb_slot = FPB_MAX;
	process_floaty = 0;
}

void fpb_add (void) {
	// New box to add is @ (pbx1, rdyy)
	if (fpb_slot) {
		fpb_slot --; rda = fpb_slots [fpb_slot];
		fpb_ac [rda] = 1;
		fpb_ct [rda] = FPB_FRAMES;
		fpb_yx [rda] = (rdyy << 4) | pbx1;

		process_floaty = 1;
	}
}

void fpb_do (void) {
	if (0 == process_floaty) return;

	process_floaty = 0;
	gpit = FPB_MAX; while (gpit --) {
		if (fpb_ac [gpit]) {
			process_floaty = 1;
			if (fpb_ct [gpit]) fpb_ct [gpit] --; else {
				rdyx = fpb_yx [gpit]; 
				if (rdyx > 143 || (scr_attr [rdyx + 16] & FLOOR_BITS)) {
					fpb_slots [fpb_slot] = gpit; fpb_slot ++;
					fpb_ac [gpit] = 0;
				} else {
					_t = scr_buff [rdyx];
					rdxx = _x = rdyx & 15;
					_y = rdyx >> 4;
					set_map_tile ();

					_t = 14;
					rdyx += 16;
					scr_attr [rdyx] = 11;
					_x = SCR_X + (rdxx << 1);
					_y = SCR_Y + (rdyx >> 4) << 1;
					DRAW_TILE_UPD ();

					fpb_yx [gpit] = rdyx;
					fpb_ct [gpit] = FPB_FRAMES;
				}
			}
		}
	}
}
