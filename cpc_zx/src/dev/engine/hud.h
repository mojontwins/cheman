// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Hud - customize here your hud routines.

void hud_update (void) {

#asm
	#ifdef SPECCY
		ld  a, 71
		ld  (__t), a
	#endif

	// ### LINE 0 ###

		xor a
		ld  (__y), a

		// update pbodycount

		ld  a, (_opbodycount)
		ld  c, a
		ld  a, (_pbodycount)
		cp  c
		jr  z, hud_update_skip_pbodycount

		ld  a, 20
		ld  (__x), a

		ld  hl, (_c_level)
		ld  bc, MAX_KILLABLE_ENEMS
		add hl, bc
		ld  c, (hl)
		ld  a, (_pbodycount)
		ld  b, a
		ld  a, c
		sub b
		ld  (__n), a
		call _p_t2

		ld  a, (_pbodycount)
		ld  (_opbodycount), a

	.hud_update_skip_pbodycount

		// update plife

		ld  a, (_oplife)
		ld  c, a
		ld  a, (_plife)
		cp  c
		jr  z, hud_update_skip_plife

		ld  a, 29
		ld  (__x), a
		ld  a, (_plife)
		ld  (__n), a
		call _p_t2

		ld  a, (_plife)
		ld  (_oplife), a

	.hud_update_skip_plife

	// ### LINE 1 ###

		ld  a, 1
		ld  (__y), a

		// update ptile_get_ctr

		ld  a, (_optile_get_ctr)
		ld  c, a
		ld  a, (_ptile_get_ctr)
		cp  c
		jr  z, hud_update_skip_ptile_get_ctr

		ld  a, 7
		ld  (__x), a
		ld  a, (_ptile_get_ctr)
		ld  (__n), a
		call _p_t2

		ld  a, (_ptile_get_ctr)
		ld  (_optile_get_ctr), a

	.hud_update_skip_ptile_get_ctr

		// Update pobjs

		ld  a, (_opobjs)
		ld  c, a
		ld  a, (_pobjs)
		cp  c
		jr  z, hud_update_skip_pobjs

		ld  a, 20
		ld  (__x), a
		ld  hl, (_c_level)
		ld  bc, MAX_HOTSPOTS_TYPE_1
		add hl, bc
		ld  c, (hl)
		ld  a, (_pobjs)
		ld  b, a
		ld  a, c
		sub b
		ld  (__n), a
		call _p_t2

		ld  a, (_pobjs)
		ld  (_opobjs), a

	.hud_update_skip_pobjs

		// Update keys

		ld  a, (_opkeys)
		ld  c, a
		ld  a, (_pkeys)
		cp  c
		jr  z, hud_update_skip_pkeys

		ld  a, 29
		ld  (__x), a
		ld  a, (_pkeys)
		ld  (__n), a
		call _p_t2

		ld  a, (_pkeys)
		ld  (_opkeys), a

	.hud_update_skip_pkeys	

	#endasm
/*

	if (ptile_get_ctr != optile_get_ctr) {
		p__t2 (29, 0, ptile_get_ctr);
		optile_get_ctr = ptile_get_ctr;
	}

	if (pstars != opstars) {
		p__t2 (18, 23, pstars);
		opstars = pstars;
	}
*/
}
