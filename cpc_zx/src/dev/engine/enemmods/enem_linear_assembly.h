// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Enem. type linear

#asm
	._enem_linear_assembly_h
	._em_l
		ld  de, (_gpit)
		ld  d, 0
		ld  hl, _en_washit
		add hl, de
		ld  a, (hl)
		or a
		jp nz, __em_l_done

	// Horizontal movement & collision

#ifdef LINEAR_COLLIDES
		ld a, (__en_x)
		ld (_rdx), a
#endif

		ld  a, (__en_mx)
		ld  b, a
		ld  a, (__en_x)
		add b
		ld  (__en_x), a

#ifdef LINEAR_COLLIDES	
		ld  a, (__en_mx)
		or  a
		jr  z, _em_l_no_horz_collision

		ld  a, (__en_y)
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
		cp  128
		jr  c, _em_l_h2	; If positive

		ld  a, (__en_x)
		srl a 
		srl a
		srl a
		srl a
		jr  _em_l_h3

	._em_l_h2
		ld  a, (__en_x)
		add 15
		srl a
		srl a
		srl a
		srl a

	._em_l_h3
		ld  (_cx1), a
		ld  (_cx2), a
	
		call _cm_two_points

	#ifdef LINEAR_COLLIDE_EVERYTHING
			ld  a, (_at1)
			ld  b, a
			ld  a, (_at2)
			add b 
			jr  z, _em_l_no_horz_collision
	#else
			ld  a, (_at1)
			and OBSTACLE_BIT
			jr  nz, _em_l_horz_collision
			ld  a, (_at2)
			and OBSTACLE_BIT
			jr  z, _em_l_no_horz_collision
	#endif

	._em_l_horz_collision
		ld  a, (_rdx)
		ld  (__en_x), a 
		ld  a, (__en_mx)
		neg
		ld  (__en_mx), a

	._em_l_no_horz_collision
#endif

	// Vertical movement & collision

#ifdef LINEAR_COLLIDES
		ld a, (__en_y)
		ld (_rdy), a
#endif

		ld  a, (__en_my)
		ld  b, a
		ld  a, (__en_y)
		add a, b
		ld  (__en_y), a

#ifdef LINEAR_COLLIDES	
		ld  a, (__en_my)
		or  a
		jr  z, _em_l_no_vert_collision

		ld  a, (__en_x)
		srl a 
		srl a
		srl a
		srl a
		ld  (_cx1), a

		ld  a, (__en_x)
		add 15
		srl a
		srl a
		srl a
		srl a
		ld  (_cx2), a

		ld  a, (__en_my)
		cp  128
		jr  c, _em_l_v2	; If positive

		ld  a, (__en_y)
		srl a 
		srl a
		srl a
		srl a
		jr  _em_l_v3

	._em_l_v2
		ld  a, (__en_y)
		add 15
		srl a
		srl a
		srl a
		srl a

	._em_l_v3
		ld  (_cy1), a
		ld  (_cy2), a
	
		call _cm_two_points

	#ifdef LINEAR_COLLIDE_EVERYTHING
		ld  a, (_at1)
		ld  b, a
		ld  a, (_at2)
		add b 
		jr  z, _em_l_no_vert_collision
	#else
		ld  a, (_at1)
		and OBSTACLE_BIT
		jr  nz, _em_l_vert_collision
		ld  a, (_at2)
		and OBSTACLE_BIT
		jr  z, _em_l_no_vert_collision
	#endif

	._em_l_vert_collision
		ld  a, (_rdy)
		ld  (__en_y), a 
		ld  a, (__en_my)
		neg
		ld  (__en_my), a

	._em_l_no_vert_collision
#endif

	// Trajectory limits: horizontal

		ld  a, (__en_x1)
		ld  b, a 
		ld  a, (__en_x)			
		cp  b 
		jr  z, _em_l_horz_trajectory_limit

		ld  a, (__en_x2)
		ld  b, a 
		ld  a, (__en_x)			
		cp  b 
		jr  nz, _em_l_no_horz_trajectory_limit

	._em_l_horz_trajectory_limit
		ld  a, (__en_mx)
		neg
		ld  (__en_mx), a	

	._em_l_no_horz_trajectory_limit

	// Trajectory limits: vertical

#ifdef PLAYER_STEPS_ON_ENEMIES
/*
	// Translate to assembly: to do.
	if (_en_my) {
		if (_en_y <= _en_y1) _en_my = ABS (_en_my);
		if (_en_y >= _en_y2) _en_my = -ABS (_en_my);
	}
*/
		ld  a, (__en_my)
		or  a
		jr  z, _em_l_no_vert_trajectory_limit

		// if (_en_y <= _en_y1): skip if _en_y > _en_y1
		ld  a, (__en_y)
		ld  c, a
		ld  a, (__en_y1)
		cp  c
		jr  c, _em_l_no_surpass_y1

		// _en_my = ABS (_en_my)
		ld  a, (__en_my)
		bit 7, a
		jr  z, _em_l_vert_abs_skip_1
		neg a
		ld  (__en_my), a
	._em_l_vert_abs_skip_1
		jr  _em_l_no_vert_trajectory_limit

	._em_l_no_surpass_y1

		// if (_en_y >= _en_y2): skip if _en_y2 > _en_y
		ld  a, (__en_y2)
		ld  c, a
		ld  a, (__en_y)
		cp  c
		jr  c, _em_l_no_surpass_y2

		// _en_my = -ABS (_en_my)
		ld  a, (__en_my)
		bit 7, a
		jr  nz, _em_l_vert_abs_skip_2
		neg a
		ld  (__en_my), a
	._em_l_vert_abs_skip_2

	._em_l_no_surpass_y2

#else
		ld  a, (__en_y1)
		ld  b, a
		ld  a, (__en_y)				
		cp  b 
		jr  z, _em_l_vert_trajectory_limit

		ld  a, (__en_y2)
		ld  b, a
		ld  a, (__en_y)				
		cp  b 
		jr  nz, _em_l_no_vert_trajectory_limit

	._em_l_vert_trajectory_limit
		ld  a, (__en_my)
		neg
		ld  (__en_my), a	
	
#endif
	._em_l_no_vert_trajectory_limit

	// Sprite cell selection

#ifdef PLATFORMS_FIXED_CELL
		ld  a, (_rdt)
		cp  0x20
		jr  nz, _em_l_not_a_platform

		ld  a, PLATFORMS_FIXED_CELL
		jr _em_l_spr_id_set
	._em_l_not_a_platform
#endif
	
		ld  a, (__en_mx)
		or  a
		jr  z, _em_l_cell_vertical
		
		ld  a, (__en_x)
		jr  _enems_linear_cell_set

	._em_l_cell_vertical
		ld  a, (__en_y)

	._enems_linear_cell_set
		srl a
		srl a
		srl a		

		and 1

		ld  de, _en_s
		ld  hl, (_gpit)
		ld  h, 0
		add hl, de 
		ld  b, (hl)

		add b 			; A = en_s [gpit] + (rda & 1)

#ifdef ENEMS_WITH_FACING
		ld  c, a
		ld  b, 0

		ld  a, (__en_mx)
		jr  z, _em_l_with_facing_vertical

		cp  128
		jr  c, _em_l_with_facing_done ; Positive

		ld  b, 2
		jr  _em_l_with_facing_done

	._em_l_with_facing_vertical
		ld  a, (__en_my)
		cp  128
		jr  c, _em_l_with_facing_done ; Positive

		ld  b, 2

	._em_l_with_facing_done

		ld  a, c
		add b
#endif

	._em_l_spr_id_set
		ld  (_spr_id), a

	.__em_l_done
#endasm
