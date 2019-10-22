// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Change screen, assembly version

#asm 
		xor a
		ld  (_rda), a

	#ifndef NO_AUTOFLICK
		// if (prx == 4 && pvx < 0 && n_pant) {
		ld  a, (_prx)
		cp  4
		jp  nz, _ml_flick_screen_horz_else

		ld  hl, _pvx
		call l_gchar
		ld  de, 0
		ex  de, hl
		call l_lt
		jp  nc, _ml_flick_screen_horz_else

		ld  a, (_n_pant)
		or  a
		jr  z, _ml_flick_screen_horz_else

		// n_pant --; px = PRX_MAX<<FIX_BITS;
		ld  hl, _n_pant
		dec (hl)

		ld  hl, PRX_MAX_FIX_BITS
		ld  (_px), hl

		ld  a, FLICK_LEFT
		ld  (_rda), a

		jp  _ml_flick_screen_horz_done

	._ml_flick_screen_horz_else

		// if (prx == PRX_MAX && pvx > 0) {
		ld  a, (_prx)
		cp  PRX_MAX
		jp  nz, _ml_flick_screen_horz_done

		ld  hl, _pvx
		call l_gchar
		ld  de, 0
		ex  de, hl
		call l_gt
		jp  nc, _ml_flick_screen_horz_done

		// n_pant ++; px = 4<<FIX_BITS;
		ld  hl, _n_pant
		inc (hl)

		ld  hl, 64
		ld  (_px), hl

		ld  a, FLICK_RIGHT
		ld  (_rda), a

	._ml_flick_screen_horz_done

		// if (pry <= ABSOLUTE_BOTTOM && pvy < 0
		ld  a, (_pry)
		cp  ABSOLUTE_BOTTOM
		jr  z, _ml_flick_screen_vert_continue1
		jr  nc, _ml_flick_screen_vert_else
	._ml_flick_screen_vert_continue1

		ld  hl, _pvy
		call l_gchar
		ld  de, 0
		ex  de, hl
		call l_lt
		jp  nc, _ml_flick_screen_vert_else

	#ifdef MAP_CHECK_TOP
		// && n_pant >= c_level_map_w

		ld  a, (_c_level_map_w)
		ld  c, a
		ld  a, (_n_pant)
		cp  c
		jp  c, _ml_flick_screen_vert_else
	#endif

		// n_pant -= c_level_map_w; py = PRY_MAX<<FIX_BITS;
		ld  a, (_c_level_map_w)
		ld  c, a
		ld  a, (_n_pant)
		sub c
		ld  (_n_pant), a

		ld  hl, PRY_MAX_FIX_BITS
		ld  (_py), hl

		#if defined (PLAYER_JUMPS) || defined (PLAYER_MONONO)
			#ifdef ENABLE_WATER
				// if (pwater) pvy = -PLAYER_VY_FLICK_TOP_SWIMMING; else
				ld  a, (_pwater)
				or  a
				jr  z, _ml_flick_screen_up_vy_boost

				ld  a, -PLAYER_VY_FLICK_TOP_SWIMMING
				ld  (_pvy), a
				jp  _ml_flick_screen_up_vy_boost_done

			#endif

			._ml_flick_screen_up_vy_boost
				//{ pvy = -PLAYER_VY_FLICK_TOP; pj = 1; pctj = 0; pjustjumped = 1; }
				ld  a, -PLAYER_VY_FLICK_TOP
				ld  (_pvy), a
				
				xor a
				ld  (_pctj), a
				inc a
				ld  (_pj), a
				ld  (_pjustjumped), a
			._ml_flick_screen_up_vy_boost_done
		#endif

		ld  a, FLICK_UP
		ld  (_rda), a

		jp  _ml_flick_screen_vert_done

	._ml_flick_screen_vert_else

		// else if (pry >= PRY_MAX && pvy > 0) {
		ld  a, (_pry)
		cp  PRY_MAX
		jp  c, _ml_flick_screen_vert_done

		ld  hl, _pvy
		call l_gchar
		ld  de, 0
		ex  de, hl
		call l_gt
		jp  nc, _ml_flick_screen_vert_done

		// n_pant += c_level_map_w; py = ABSOLUTE_BOTTOM<<FIX_BITS;
		ld  a, (_c_level_map_w)
		ld  c, a
		ld  a, (_n_pant)
		add c
		ld  (_n_pant), a

		ld  hl, ABSOLUTE_BOTTOM_FIX_BITS
		ld  (_py), hl

		ld  a, FLICK_DOWN
		ld  (_rda), a

	._ml_flick_screen_vert_done


	#endif

#endasm

#include "my/flick_screen_overrides.h"

#asm

	// if (on_pant != n_pant && do_game) {
._mk_flick
	ld  a, (_n_pant)
	ld  c, a
	ld  a, (_on_pant)
	cp  c
	jr  z, _ml_flick_skip

	ld  a, (_do_game)
	or  a
	jr  z, _ml_flick_skip

	// prx = px >> FIX_BITS; 
	ld  hl, (_px)
	ex  de, hl
	ld  l, 4
	call l_asr 		; -> L
	ld  a, l 		
	ld  (_prx), a

	// pry = py >> FIX_BITS;
	ld  hl, (_py)
	ex  de, hl
	ld  l, 4
	call l_asr 		; -> L
	ld  a, l
	ld  (_pry), a

	call _game_prepare_screen

	ld  a, (_n_pant)
	ld  (_on_pant), a
	xor a
	ld  (_isrc), a
	#ifdef CPC
		ld  (_isrc_max), a
	#endif
._ml_flick_skip

#endasm
