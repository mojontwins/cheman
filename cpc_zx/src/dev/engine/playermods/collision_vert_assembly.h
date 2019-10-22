// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Player collisions with bg in the vertical axis (assembly version)

#asm
		// cx1 = prx >> 4;
		ld  a, (_prx)
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a

		// cx2 = (prx + 7) >> 4;
		ld  a, (_prx)
		add 7
		srl a
		srl a
		srl a
		srl a
		ld  (_cx2), a

		// rdsint = pvy + pgtmy;
		ld  hl, _pvy
		call l_gchar
		ex  de, hl
		ld  hl, _pgtmy
		call l_gchar
		add hl, de
		; ld  (_rdsint), hl

		// if (rdsint)
		ld  a, l 
		or  h 
		jp  z, _pm_vert_v_zero

		// if (rdsint < 0) {		
		xor a 
		or  h
		jp  p, _pm_vert_v_pos	// Result positive == SKIP!

	._pm_vert_v_neg

		// cy1 = cy2 = (pry + X) >> 4; X = PLAYER_8_PIXELS?6|1
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
		ld  (_cy2), a

		call _cm_two_points

		/*
		#ifdef PLAYER_GENITAL
			if ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS))
		#else
			if ((at1 & OBSTACLE_BIT) || (at2 & OBSTACLE_BIT))
		#endif
		*/
		ld  a, (_at1)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  nz, _pm_vert_v_neg_collide

		ld  a, (_at2)
	#ifdef PLAYER_GENITAL
		and FLOOR_BITS
	#else
		and OBSTACLE_BIT
	#endif
		jp  z, _pm_vert_v_neg_collide_else

	._pm_vert_v_neg_collide
		// pgotten = pvy = 0
		xor a
		ld  (_pvy), a 
		ld  (_pgotten), a

		// pry = ((cy1 + 1) << 4) - X; X = PLAYER_8_PIXELS?6|1
		ld  a, (_cy1)
		inc a
		sla a
		sla a
		sla a
		sla a
	#ifdef PLAYER_8_PIXELS
		sub 6
	#else
		sub 1
	#endif
		ld  (_pry), a

		// py = pry << FIX_BITS
		ld  d, 0
		ld  e, a
		ld  l, 4
		call l_asl
		ld  (_py), hl

		jp  _pm_vert_v_coll_done

	._pm_vert_v_neg_collide_else

	#ifdef EVIL_TILE_MULTI
		// if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
		ld  a, (_at1)
		and EVIL_BIT
		jp  nz, _pm_vert_v_neg_evil_do

		ld  a, (_at2)
		and EVIL_BIT
		jp  z, _pm_vert_v_neg_evil_done

	._pm_vert_v_neg_evil_do
		ld  a, PLAYER_V_REBOUND_MULTI
		ld  (_pvy), a
		ld  a, 1
		ld  (_evil_tile_hit), a
		jp  _pm_vert_v_coll_done

	._pm_vert_v_neg_evil_done
	#endif

	#ifdef ENABLE_HOLES
		// if (!pholed)
		ld  a, (_pholed)
		or  a
		jp  z, _pm_vert_v_neg_hole_done

		// cy1 = cy2 = (pry + 14) >> 4;
		ld  a, (_pry)
		add 14
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a
		ld  (_cy2), a

		call _cm_two_points

		// if ((at1 & HOLE_BIT) && (at2 & HOLE_BIT))
		ld  a, (_at1)
		and HOLE_BIT
		jp  z, _pm_vert_v_neg_hole_done

		ld  a, (_at2)
		and HOLE_BIT
		jp  z, _pm_vert_v_neg_hole_done

	._pm_vert_v_neg_hole_do
		call _player_holed
		jp  _pm_vert_v_coll_done

	._pm_vert_v_neg_hole_done
	#endif

	#ifdef ENABLE_QUICKSANDS
		// ((at1 & QUICKSANDS_BIT) || (at2 & QUICKSANDS_BIT)) 
		ld  a, (_at1)
		and QUICKSANDS_BIT
		jp  nz, _pm_vert_v_neg_quicksands_do

		ld  a, (_at2)
		and QUICKSANDS_BIT
		jp  z, _pm_vert_v_neg_quicksands_done

	._pm_vert_v_neg_quicksands_do
		// if (pvy < -PLAYER_VY_EXIT_QUICKSANDS)		
		ld  hl, _pvy
		call l_gchar
		ld  de, -PLAYER_VY_EXIT_QUICKSANDS
		ex  de, hl
		call l_lt
		jr  nc, _pm_vert_v_neg_quicksands_done

		ld  a, -PLAYER_VY_EXIT_QUICKSANDS
		ld  (_pvy), a

		jp  _pm_vert_v_coll_done
	._pm_vert_v_neg_quicksands_done
	#endif

		jp  _pm_vert_v_coll_done

	// } else {
	._pm_vert_v_pos

		// cy1 = cy2 = (pry + 15) >> 4; 
		ld  a, (_pry)
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a
		ld  (_cy2), a

		call _cm_two_points

	#ifdef PRECISE_DESCENDING_COLLISION
		// if (((pry - 1) & 15) < (1 + (rdsint >> 4)) && ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)))
		// WONT BE ABLE TO TEST THIS UNTIL I MAKE A PLATFORMER!
	#else
		// if ((at1 & FLOOR_BITS)) || (at2 & FLOOR_BITS))
		ld  a, (_at1)
		and FLOOR_BITS
		jp  nz, _pm_vert_v_pos_collide

		ld  a, (_at2)
		and FLOOR_BITS
		jp  z, _pm_vert_v_pos_collide_else
	#endif

	._pm_vert_v_pos_collide
		// pgotten = pvy = 0
		xor a
		ld  (_pvy), a 
		ld  (_pgotten), a

		// pry = (cy1 - 1) << 4;
		ld  a, (_cy1)
		dec a
		sla a
		sla a
		sla a
		sla a
		ld  (_pry), a

		// py = pry << FIX_BITS;
		ld  d, 0
		ld  e, a
		ld  l, 4
		call l_asl
		ld  (_py), hl

		jp  _pm_vert_v_coll_done				

	._pm_vert_v_pos_collide_else

	#ifdef ENABLE_HOLES
		// if (!pholed && ((at1 & HOLE_BIT) && (at2 & HOLE_BIT)))
		ld  a, (_pholed)
		or  a
		jr  nz, _pm_vert_v_pos_hole_done

		ld  a, (_at1)
		and HOLE_BIT
		jp  z, _pm_vert_v_pos_hole_done

		ld  a, (_at2)
		and HOLE_BIT
		jp  z, _pm_vert_v_pos_hole_done

		call _player_holed
		jp  _pm_vert_v_coll_done

	._pm_vert_v_pos_hole_done
	#endif

	#ifdef EVIL_TILE_MULTI
		// if ((at1 & EVIL_BIT) || (at2 & EVIL_BIT)) {
		ld  a, (_at1)
		and EVIL_BIT
		jp  nz, _pm_vert_v_pos_evil_do

		ld  a, (_at2)
		and EVIL_BIT
		jp  z, _pm_vert_v_pos_evil_done

	._pm_vert_v_pos_evil_do
		ld  a, -PLAYER_V_REBOUND_MULTI
		ld  (_pvy), a
		ld  a, 1
		ld  (_evil_tile_hit), a
		jp  _pm_vert_v_coll_done

	._pm_vert_v_pos_evil_done
	#endif

	#ifdef ENABLE_QUICKSANDS
		// ((at1 & QUICKSANDS_BIT) || (at2 & QUICKSANDS_BIT)) 
		ld  a, (_at1)
		and QUICKSANDS_BIT
		jp  nz, _pm_vert_v_pos_quicksands_do

		ld  a, (_at2)
		and QUICKSANDS_BIT
		jp  z, _pm_vert_v_pos_quicksands_done

	._pm_vert_v_pos_quicksands_do
		ld  a, PLAYER_VY_SINKING
		ld  (_pvy), a

		jp  _pm_vert_v_coll_done
	._pm_vert_v_pos_quicksands_done	
	#endif

	._pm_vert_v_coll_done

	#if defined (PLAYER_PROCESS_BLOCK) && defined (PLAYER_GENITAL)
	._pm_vert_process_block
		// if ((at1 & SPECIAL_BEH) == SPECIAL_BEH) {
		ld  a, (_at1)
		and SPECIAL_BEH
		cp  SPECIAL_BEH
		jr  nz, _pm_vert_process_block_1_done

	._pm_vert_process_block_1_do
		// __x = cx1;
		ld  a, (_cx1)
		ld  (___x), a

		// __y = cy1;
		ld  a, (_cy1)
		ld  (___y), a
		
		// __d = 0;
		xor a
		ld  (___d), a

		// player_process_block (); 
		call _player_process_block

		// }
	._pm_vert_process_block_1_done
		// if ((cx1 != cx2) && ((at2 & SPECIAL_BEH) == SPECIAL_BEH))
		ld  a, (_cx1)
		ld  c, a
		ld  a, (_cx2)
		cp  c
		jr  z, _pm_vert_process_block_2_done

		ld  a, (_at2)
		and SPECIAL_BEH
		cp  SPECIAL_BEH
		jr  nz, _pm_vert_process_block_2_done

	._pm_vert_process_block_2_do
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

	._pm_vert_process_block_2_done
	#endif

	._pm_vert_v_zero

	._pm_vert_v_done
#endasm

