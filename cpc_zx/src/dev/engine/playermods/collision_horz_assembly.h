// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Player collisions with bg in the horizontal axis (assembly version)

#asm
		// cy1 = (pry + X) >> 4; X = PLAYER_8_PIXELS ? 6 : 1
		ld  a, (_pry)
	#ifdef PLAYER_8_PIXELS
		add 6
	#else
		add 1
	#endif
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a

		// cy2 = (pry + 15) >> 4;
		ld  a, (_pry)
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_cy2), a

		// rdsint = pvx + pgtmx;
		ld  hl, _pvx
		call l_gchar
		ex  de, hl
		ld  hl, _pgtmx
		call l_gchar
		add hl, de
		; ld  (_rdsint), hl

		// if (rdsint)
		ld  a, l
		or  h
		jp  z, _pm_horz_v_zero

		// if (rdsint < 0) {
		xor a
		or  h
		jp  p, _pm_horz_v_pos

	._pm_horz_v_neg
		// cx1 = cx2 = prx >> 4;
		ld  a, (_prx)
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a
		ld  (_cx2), a

		call _cm_two_points

		/*
		#ifdef PLAYER_GENITAL
			if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) {
		#else
			if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT)) {
		#endif
		*/
		ld  a, (_at1)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  nz, _pm_horz_v_neg_collide

		ld  a, (_at2)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  z, _pm_horz_v_neg_collide_else

	._pm_horz_v_neg_collide
		// pvx = 0
		xor a
		ld  (_pvx), a

		// prx = (cx1 + 1) << 4
		ld  a, (_cx1)
		inc a
		sla a
		sla a
		sla a
		sla a
		ld  (_prx), a

		// px = prx << FIX_BITS
		ld  d, 0
		ld  e, a
		ld  l, 4
		call l_asl
		ld  (_px), hl

		jp  _pm_horz_v_coll_done

	._pm_horz_v_neg_collide_else

	#ifdef ENABLE_HOLES
		// if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT)))
		ld  a, (_pholed)
		or  a
		jr  nz, _pm_horz_v_neg_hole_done

		ld  a, (_at1)
		and HOLE_BIT
		jp  z, _pm_horz_v_neg_hole_done

		ld  a, (_at2)
		and HOLE_BIT
		jp  z, _pm_horz_v_neg_hole_done

		call _player_holed
		jp  _pm_horz_v_coll_done

	._pm_horz_v_neg_hole_done	
	#endif

	#ifdef EVIL_TILE_MULTI
		// if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
		ld  a, (_at1)
		and EVIL_BIT
		jp  nz, _pm_horz_v_neg_evil_do

		ld  a, (_at2)
		and EVIL_BIT
		jp  z, _pm_horz_v_neg_evil_done

	._pm_horz_v_neg_evil_do
		ld  a, PLAYER_V_REBOUND_MULTI
		ld  (_pvx), a
		ld  a, 1
		ld  (_evil_tile_hit), a
		jp  _pm_horz_v_coll_done

	._pm_horz_v_neg_evil_done
	#endif
		jp  _pm_horz_v_coll_done

	// } else {
	._pm_horz_v_pos
	
		// cx1 = cx2 = (prx + 7) >> 4; 
		ld  a, (_prx)
		add 7
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a
		ld  (_cx2), a

		call _cm_two_points

		/*
		#ifdef PLAYER_GENITAL
			if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) {
		#else
			if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT)) {
		#endif
		*/
		ld  a, (_at1)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  nz, _pm_horz_v_pos_collide

		ld  a, (_at2)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  z, _pm_horz_v_pos_collide_else

	._pm_horz_v_pos_collide
		// pvx = 0
		xor a
		ld  (_pvx), a

		// prx = ((cx1 - 1) << 4) + 8;
		ld  a, (_cx1)
		dec a
		sla a
		sla a
		sla a
		sla a
		add 8
		ld  (_prx), a

		// px = prx << FIX_BITS
		ld  d, 0
		ld  e, a
		ld  l, 4
		call l_asl
		ld  (_px), hl

		jp  _pm_horz_v_coll_done

	._pm_horz_v_pos_collide_else

	#ifdef ENABLE_HOLES
		// if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT)))
		ld  a, (_pholed)
		or  a
		jr  nz, _pm_horz_v_pos_hole_done

		ld  a, (_at1)
		and HOLE_BIT
		jp  z, _pm_horz_v_pos_hole_done

		ld  a, (_at2)
		and HOLE_BIT
		jp  z, _pm_horz_v_pos_hole_done

		call _player_holed
		jp  _pm_horz_v_coll_done

	._pm_horz_v_pos_hole_done	
	#endif

	#ifdef EVIL_TILE_MULTI
		// if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
		ld  a, (_at1)
		and EVIL_BIT
		jp  nz, _pm_horz_v_pos_evil_do

		ld  a, (_at2)
		and EVIL_BIT
		jp  z, _pm_horz_v_pos_evil_done

	._pm_horz_v_pos_evil_do
		ld  a, -PLAYER_V_REBOUND_MULTI
		ld  (_pvx), a
		ld  a, 1
		ld  (_evil_tile_hit), a
		jp  _pm_horz_v_coll_done

	._pm_horz_v_pos_evil_done
	#endif

	._pm_horz_v_coll_done

	#ifdef PLAYER_PROCESS_BLOCK
	._pm_horz_process_block
		// if ((at1 & SPECIAL_BEH) == SPECIAL_BEH) {
		ld  a, (_at1)
		and SPECIAL_BEH
		cp  SPECIAL_BEH
		jr  nz, _pm_horz_process_block_1_done

	._pm_horz_process_block_1_do
		// __x = cx1;
		ld  a, (_cx1)
		ld  (___x), a

		// __y = cy1;
		ld  a, (_cy1)
		ld  (___y), a
		
		// __d = 0;
		ld  a, 1
		ld  (___d), a

		// player_process_block (); 
		call _player_process_block

		// }
	._pm_horz_process_block_1_done
		// if ((cy1 != cy2) && ((at2 & SPECIAL_BEH) == SPECIAL_BEH))
		ld  a, (_cy1)
		ld  c, a
		ld  a, (_cy2)
		cp  c
		jr  z, _pm_horz_process_block_2_done

		ld  a, (_at2)
		and SPECIAL_BEH
		cp  SPECIAL_BEH
		jr  nz, _pm_horz_process_block_2_done

	._pm_horz_process_block_2_do
		// __x = cx2;
		ld  a, (_cx2)
		ld  (___x), a

		// __y = cy2;
		ld  a, (_cy2)
		ld  (___y), a
		
		// __d = 0;
		xor a
		ld  (___d), a

		// player_process_block (); 
		call _player_process_block

	._pm_horz_process_block_2_done		

	#endif

		jp _pm_horz_v_done

	._pm_horz_v_zero
		// if ((pvx + pgtmx) == 0 && (prx & 0x03)) {
		ld  a, (_prx)
		and 3
		jr  nz, _pm_horz_v_zero_done

		// prx = prx & 0xfc;
		ld  a, (_prx)
		and 0xfc
		ld  (_prx), a

		// px = prx << FIX_BITS;
		ld  d, 0
		ld  e, a
		ld  l, 4
		call l_asl
		ld  (_px), hl

	._pm_horz_v_zero_done

	._pm_horz_v_done	
#endasm