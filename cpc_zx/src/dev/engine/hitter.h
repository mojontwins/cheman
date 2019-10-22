// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Hitter: Implements punches, swords, whips...

void hitter_do (void) {
	if (hitter_frame) {

#ifdef PLAYER_PUNCHES
		hitter_y = pry + 6;
		hitter_x = pfacing ? (prx - hitter_offs [hitter_frame]) : (prx + hitter_offs [hitter_frame]);
		if (hitter_x > 240) hitter_x = 0;
#endif

		if (hitter_frame >= HITTER_HOT_MIN && hitter_frame <= HITTER_HOT_MAX) {
			hitter_hs_x = pfacing ? hitter_x : (hitter_x + 7);
			hitter_hs_y = hitter_y + 3;
		} else hitter_hs_y = 0xff;
		hitter_frame ++; if (hitter_frame == HITTER_LAST_FRAME) hitter_frame = 0;

		// Sprite
		spr_on [SPR_HITTER] = 1;
		spr_x [SPR_HITTER] = hitter_x;
		spr_y [SPR_HITTER] = hitter_y;
		spr_next [SPR_HITTER] = sprite_cells [HITTER_CELL_BASE + (pfacing ? 1 : 0)];

		// Collision w/ breakable tiles
		if (hitter_hs_y != 0xff && hitter_hs_y >= 16) {
			rdx = hitter_hs_x >> 4; if (rdx < 15) {
				rdy = (hitter_hs_y >> 4) - 1;
				rdi = rdx | (rdy << 4);
				if (scr_attr [rdi] & BREAKABLE_BIT)	breakable_break ();
			}
		}

	} else {
		spr_on [SPR_HITTER] = 0;
		hitter_hs_y = 0xff;
	}
}
