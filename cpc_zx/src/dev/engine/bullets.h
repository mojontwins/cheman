// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Projectiles

void bullets_ini (void) {
	#asm
			ld  b, BULLETS_MAX
			ld  d, 0
		._bullets_ini_loop
			dec b
			ld  e, b
			ld  hl, _b_ac
			add hl, de
			ld  (hl), 0
			ld  hl, _b_slots
			add hl, de
			ld  (hl), b
			ld  a, b
			or  a
			jr  nz, _bullets_ini_loop

			ld  a, BULLETS_MAX
			ld  (_b_slot), a
	#endasm
}

void bullets_fire (void) {
	#asm
		#ifdef AMMO_MAX
			ld  a, (_pammo)
			or  a
			ret z
		#endif

			// Get slot
			ld  a, (_b_slot)
			or  a
			ret z

			dec a
			ld  (_b_slot), a
			ld  d, 0
			ld  e, a
			ld  hl, _b_slots
			add hl, de
			ld  a, (hl)
			ld  (_bic), a

		#ifdef AMMO_MAX
			ld  a, (_pammo)
			dec a
			ld  (_pammo), a
		#endif

		#ifdef PLAYER_GENITAL
			ld  a, (_pfacing)
			cp  CELL_FACING_RIGHT
			jr  z, _bullets_fire_right
			cp  CELL_FACING_LEFT
			jr  z, _bullets_fire_left
			cp  CELL_FACING_DOWN
			jr  z, _bullets_fire_down
		._bullets_fire_up
			ld  e, 3
			jr _bullets_direction_done
		._bullets_fire_right
			ld  e, 0
			jr  _bullets_direction_done
		._bullets_fire_left
			ld  e, 1
			jr  _bullets_direction_done
		._bullets_fire_down
			ld  e, 2

		._bullets_direction_done
			ld  d, 0
			ld  hl, _bu_dx
			add hl, de
			ld  c, (hl)
			ld  hl, _bu_dy
			add hl, de
			ld  a, (hl)

			; A: dy, C: dx
			ld  de, (_bic)
			ld  d, 0
			ld  hl, _b_my
			add hl, de
			ld  (hl), a

			ld  hl, _b_mx
			add hl, de
			ld  (hl), c

			ld  hl, _b_x
			add hl, de
			ld  a, (_prx)
			and 0xf8
			ld  (hl), a

			ld  hl, _b_y
			add hl, de
			ld  a, (_pry)
			and 0xf8
			ld (hl), a
		#else
			ld  hl, _b_x
			add hl, de
			ld  a, (_prx)
			and 0xf8
			ld  (hl), a

			ld  hl, _b_y
			add hl, de
			ld  a, (_pry)
			and 0xf8
			ld (hl), a

			ld  a, (_pfacing)
			or  a
			jr  z, _bullets_fire_right

		._bullets_fire_left
			ld  a, -BULLETS_V
			jr  _bullets_direction_done
		._bullets_fire_right
			ld  a, BULLETS_V

		._bullets_direction_done
			ld  hl, _b_mx
			add hl, de
			ld  (hl), a
		#endif

			ld  hl, _b_ac
			add hl, de
			ld  (hl), 1

			// Sprite cell	
			#endasm
				spr_next [SPR_BULLETS_BASE + bic] = ss_small;
			#asm

		#ifdef PLAYER_VX_RECOIL
			ld  a, (_pfacing)
			or  a
			jr  _bullets_recoil_left
		._bullets_recoil_right	
			ld  a, PLAYER_VX_RECOIL
			jr  _bullets_recoil_done
		._bullets_recoil_left
			ld  a, -PLAYER_VX_RECOIL
		._bullets_recoil_done
			ld  (_pvx), a
		#endif
	#endasm

	SFX_PLAY (SFX_SHOOT);
}

void player_hit (void);

void bullets_do (void) {
	#asm
			ld  b, BULLETS_MAX
		._bullets_do_loop
			dec b
			ld  a, b
			add SPR_BULLETS_BASE
			ld  (_spr_idx), a

			ld  e, b
			ld  d, 0

			ld  hl, _b_ac
			add hl, de
			ld  a, (hl)
			or  a
			jp  z, _bullets_do_off

			// Advance bullet
			ld  hl, _b_x
			add hl, de
			ld  c, (hl)
			ld  hl, _b_mx
			add hl, de
			ld  a, (hl)
			ld  (__b_mx), a
			add c
			ld  (__b_x), a

			ld  hl, _b_y
			add hl, de
			ld  c, (hl)
			ld  hl, _b_my
			add hl, de
			ld  a, (hl)
			ld  (__b_my), a
			add c
			ld  (__b_y), a

			// Collision & boundaries
			;ld  a, (__b_y)
			add -12
			and 0xf0
			ld  c, a
			ld  a, (__b_x)
			add 4
			srl a
			srl a
			srl a
			srl a
			or  c
			ld  e, a
			ld  d, 0
			ld  hl, _scr_attr
			add hl, de
			ld  a, (hl)

		#ifdef BREAKABLE_WALLS
			// IS_BREAKABLE (bic) -> (bic & BREAKABLE_BIT)
			ld  c, a
			and BREAKABLE_BIT
			jr  z, _bullets_do_non_breakable

			// TODO: Translate
			push bc
			#endasm
				breakable_break ();
			#asm
			pop bc
			jp _bullets_destroy

		._bullets_do_non_breakable
			ld  a, c
		#endif

			// IS_OBSTACLE_HARD (bic) -> (bic & OBSTACLE_BIT)
			and OBSTACLE_BIT
			jr  nz, _bullets_destroy

			// Send to renderer
			ld  de, (_spr_idx)
			ld  d, 0
			ld  hl, _spr_on
			add hl, de
			ld  (hl), 1
			ld  hl, _spr_x
			add hl, de
			ld  a, (__b_x)
			ld  (hl), a
			ld  hl, _spr_y
			add hl, de
			ld  a, (__b_y)
			ld  (hl), a

			// In this engine, bullets are always cell-aligned
			// And this makes my life easier!

		._bullets_do_checks_horz
			ld  a, (__b_mx)
			or  a
			jr  z, _bullets_do_checks_vert

			ld  a, (__b_x)
			or a 
			jr  z, _bullets_destroy
			cp  248
			jr  z, _bullets_destroy

		#ifndef PLAYER_CAN_FIRE_DIAGONAL
			jr  _bullets_update
		#endif

		._bullets_do_checks_vert
			ld  a, (__b_my)
			or  a
			jr  z, _bullets_update

			ld  a, (__b_y)
			cp  16
			jr  z, _bullets_destroy
			cp  192
			jr  z, _bullets_destroy

		._bullets_update

			// Update coordinates
			ld  d, 0
			ld  e, b
			ld  hl, _b_x
			add hl, de
			ld  a, (__b_x)
			ld  (hl), a
		#ifdef PLAYER_GENITAL			
			ld  hl, _b_y
			add hl, de
			ld  a, (__b_y)
			ld  (hl), a
		#endif

			jr _bullets_do_done

		._bullets_destroy
			ld  e, b
			ld  d, 0
			ld  hl, _b_ac
			add hl, de
			ld  (hl), 0

			ld  a, b
			ld  de, (_b_slot)
			ld  d, 0
			ld  hl, _b_slots
			add hl, de
			ld  (hl), a
			ld  a, e
			inc a
			ld  (_b_slot),a 

			jr _bullets_do_done

		._bullets_do_off
			// Sprite off

			ld  hl, _spr_on
			ld  de, (_spr_idx)
			ld  d, 0
			add hl, de
			ld  (hl), 0

		._bullets_do_done

			ld  a,b 
			or  a
			jp  nz, _bullets_do_loop
	#endasm
}
