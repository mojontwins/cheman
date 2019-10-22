// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

#define COLLISION_BITS EVIL_BIT|PLATFORM_BIT|OBSTACLE_BIT

#asm
	._enem_type7_assembly_h
	._em_t7

	#ifdef TYPE7_WITH_GENERATOR
		ld  de, _en_gen_washit
		ld  l, b
		ld  h, 0
		add hl, de
		ld  a, (hl)
		or  a
		jr  z, _em_t7_en_gen_hit_ca

		dec a
		ld  (hl), a

	._em_t7_en_gen_hit_ca
	#endif

		ld  a, (__en_state)
		or  a
		jp  z, _em_t7_en_spawn_do

	// [_en_state == 1] Chase the player
	._em_7_chase

		// Update position? not if:
		// phit
		ld  a, (_phit)
		or  a
		jp  nz, _em_t7_update_done

		// en_washit [gpit]
		ld  e, b
		ld  d, 0
		ld  hl, _en_washit		
		add hl, de
		ld  a, (hl)
		or  a
		jp  nz, _em_t7_update_after

		// en_fishing [gpit]
		ld  hl, _en_fishing
		add hl, de
		ld  a, (hl)
		or  a
		jp  nz, _em_t7_update_done

		// pflickering
		ld  a, (_pflickering)
		or  a
		jp  nz, _em_t7_update_done

		// Ok, update position

		ld  a, (_prx)
		and 0xfc
		ld  (_rdx), a

		ld  a, (_pry)
		and 0xfc
		ld  (_rdy), a

		ld  de, _en_v
		ld  l, b
		ld  h, 0
		add hl, de
		ld  a, (hl)
		ld  (_rdc), a 					// rdc = en_v [gpit]

		// Assign v or -v to _en_mx or _en_my depending
		// on the position of the player.

		ld  a, (_rdy)
		ld  c, a
		ld  a, (__en_y)
		cp  c
		jr  c, _em_t7_en_my_positive	// c (rdy) > a (_en_y)
		jr  z, _em_t7_en_my_zero      	// c (rdy) == a (_en_y)
	._em_t7_en_my_negative
		ld  a, (_rdc)
		neg
		jr  _em_t7_en_my_assign
	._em_t7_en_my_positive
		ld  a, (_rdc)
		jr  _em_t7_en_my_assign
	._em_t7_en_my_zero
		xor a
	._em_t7_en_my_assign
		ld  (__en_my), a

		ld  a, (_rdx)
		ld  c, a
		ld  a, (__en_x)
		cp  c
		jr  c, _em_t7_en_mx_positive	// c (rdx) > a (_en_x)
		jr  z, _em_t7_en_mx_zero      	// c (rdx) == a (_en_x)
	._em_t7_en_mx_negative
		ld  a, (_rdc)
		neg
		jr  _em_t7_en_mx_assign
	._em_t7_en_mx_positive
		ld  a, (_rdc)
		jr  _em_t7_en_mx_assign
	._em_t7_en_mx_zero
		xor a
	._em_t7_en_mx_assign
		ld  (__en_mx), a

		// Move & check, horizontal

	._em_t7_horz
		;ld  a, (__en_mx)
		or  a
		jp  z, _em_t7_vert
		ld  c, a
		ld  a, (__en_x)
		add c
		ld  (__en_x), a

		ld  a, (__en_y)
		add 8
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a

		ld  a, (__en_y)
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_cy2), a

		ld  a, (__en_mx)
		cp  0x80
		jr  c, _em_t7_horz_mx_positive

	._em_t7_horz_mx_negative
		ld  a, (__en_x)
		add 4
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a 
		ld  (_cx2), a 
		inc a
		sla a
		sla a
		sla a
		sla a
		sub 4		
		jr  _em_t7_horz_check_collision

	._em_t7_horz_mx_positive
		ld  a, (__en_x)
		add 11
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a 
		ld  (_cx2), a 
		dec a
		sla a
		sla a
		sla a
		sla a
		add 4

	._em_t7_horz_check_collision
		ld  (_rdb), a

		call _cm_two_points

		ld  a, (_at1)
		and COLLISION_BITS
		jr  nz, _em_t7_horz_check_coll_true

		ld  a, (_at2)
		and COLLISION_BITS
		jr  z, _em_t7_horz_check_coll_false

	._em_t7_horz_check_coll_true
		ld  a, (_rdb)
		ld  (__en_x), a

	._em_t7_horz_check_coll_false

		// Move & check, vertical

	._em_t7_vert

		ld  a, (__en_my)
		or  a
		jp  z, _em_t7_axes_done
		ld  c, a
		ld  a, (__en_y)
		add c
		ld  (__en_y), a

		ld  a, (__en_x)
		add 4
		srl a
		srl a
		srl a
		srl a
		ld  (_cx1), a

		ld  a, (__en_x)
		add 11
		srl a
		srl a
		srl a
		srl a
		ld  (_cx2), a

		ld  a, (__en_my)
		cp  0x80
		jr  c, _em_t7_vert_my_positive

	._em_t7_vert_my_negative
		ld  a, (__en_y)
		add 8
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a 
		ld  (_cy2), a 
		inc a
		sla a
		sla a
		sla a
		sla a
		sub 8	
		jr  _em_t7_vert_check_collision

	._em_t7_vert_my_positive
		ld  a, (__en_y)
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_cy1), a 
		ld  (_cy2), a 
		dec a
		sla a
		sla a
		sla a
		sla a

	._em_t7_vert_check_collision
		ld  (_rdb), a

		call _cm_two_points

		ld  a, (_at1)
		and COLLISION_BITS
		jr  nz, _em_t7_vert_check_coll_true

		ld  a, (_at2)
		and COLLISION_BITS
		jr  z, _em_t7_vert_check_coll_false

	._em_t7_vert_check_coll_true
		ld  a, (_rdb)
		ld  (__en_y), a

	._em_t7_vert_check_coll_false

	._em_t7_axes_done

		call _rand8	; ->L 
		ld  a, l
		and TYPE7_STOP_RATE
		cp  2
		jr  nz, _em_t7_update_done

		call _rand8	; ->L
		ld  a, l
		and TYPE7_STOP_FRAMES
		add TYPE7_STOP_FRAMES

		ld  de, _en_fishing
		ld  l, b
		ld  h, 0
		add hl, de 

		ld  (hl), a

	._em_t7_update_done

	._em_t7_cell_selection
		ld  a, (__en_x)
		srl a
		srl a 
		srl a 
		and 1
		ld  c, a

		ld  de, _en_s
		ld  l, b
		ld  h, 0
		add hl, de
		ld  a, (hl)
		add c

		#ifdef ENEMS_WITH_FACING
			._em_t7_facing_selection
				ld  c, a
				ld  a, (__en_mx)
				or  a
				jr  nz, _em_t7_facing_horz
			._em_t7_facing_vert
				ld  a, (__en_my)
			._em_t7_facing_horz 
				cp  0x80
				jr  c, _em_t7_facing_horz_p
			._em_t7_facing_horz_n 
				ld  a, 2
				jr  _em_t7_facing_done
			._em_t7_facing_horz_p
				xor a
			._em_t7_facing_done
				add a, c
		#endif

		ld  (_spr_id), a

	._em_t7_update_after

	// Substract from en_fishing

	._em_t7_en_fishing_dec
		ld  de, _en_fishing
		ld  l, b
		ld  h, 0
		add hl, de
		ld  a, (hl)
		or  a
		jp z, _em_t7_done
		
		dec a
		ld  (hl), a

		jp _em_t7_done

	._em_t7_en_spawn_do

	// [_en_state == 0] Spawn a new minion
		ld  a, (__en_x1)
		ld  (__en_x), a
		ld  a, (__en_y1)
		ld  (__en_y), a

		ld  a, (__en_ct)
		or  a
		jr  z, _em_t7_en_spawn_do_do
		dec a
		ld  (__en_ct), a
		jr  _em_t7_cell_selection_idle

	._em_t7_en_spawn_do_do

		// Select velocity ( 1 2 4 1 )

		call _rand8	; ->L
		ld  a, l
		and 3
		jr  z, _em_t7_set_v_set1
		cp  3
		jr  z, _em_t7_set_v_set1
		cp  1
		jr  z, _em_t7_set_v_set2
		ld  a, 4
		jr  z, _em_t7_set_v
	._em_t7_set_v_set2
		ld  a, 2
		jr  z, _em_t7_set_v
	._em_t7_set_v_set1
		ld  a, 1

	._em_t7_set_v
		ld  de, _en_v
		ld  l, b
		ld  h, 0
		add hl, de

		ld  (hl), a

		// Select sprite base

		#ifdef TYPE7_FIXED_SPRITE
			ld  a, ENEMS_CELL_BASE+TYPE7_FIXED_SPRITE<<2			
		#else
			call _rand8	; ->L
			ld  a, h
			and 3
			sla a 
			sla a
			add ENEMS_CELL_BASE
		#endif

		ld  de, _en_s
		ld  l, b
		ld  h, 0
		add hl, de
		ld  (hl), a

		// Initialize state & life

		ld  a, 1
		ld  (__en_state), a

		ld  a, TYPE7_MINION_LIFE
		ld  de, _en_life
		ld  l, b
		ld  h, 0
		add hl, de		
		ld  (hl), a

		// Cell selection (idle)

		._em_t7_cell_selection_idle
		ld  a, 0xff
		ld  (_spr_id), a

		ld  a, (_en_ct)
		cp  TYPE7_SMOKE_TIME
		jr  c, _em_t7_cell_smoke
		jr  _em_t7_done

	._em_t7_cell_smoke
		ld  a, EXPLOSION_CELL_BASE
		ld  (_spr_id), a

	._em_t7_done

#endasm
