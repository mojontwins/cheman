// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Bullets <-> Enemy collision.

// Current enemy index is on "B" and "_gpit"

#asm

	#ifdef PLAYER_CAN_FIRE
			push bc
			
		.__e_d_bullets
			ld a, BULLETS_MAX					
		._e_d_bullets_loop
			dec a
			ld (_bi), a
			
			ld  d, 0
			ld  e, a

			// "DE", "_bi" -> Bullets index

			ld  hl, _b_ac
			add hl, de
			ld  a, (hl)						// b_ac [bi]
			or  a
			jr  z, _e_d_bullets_continue

			// Bullet is active

			ld  hl, _b_x
			add hl, de
			ld  a, (hl)
			ld  (_cx1), a 					// cx1 = b_x [bi]

			ld  hl, _b_y
			add hl, de
			ld  a, (hl)
			ld  (_cy1), a 					// cy1 = b_y [bi]

			ld  a, (__en_x)
			ld  (_cx2), a 					// cx2 = _en_x

			ld  a, (__en_y)
			ld  (_cy2), a 					// cy2 = _en_y
			
			call _collide  ; -> L
			
			xor a
			or  l
			jr  z, _e_d_bullets_continue

		._e_d_bullets_collide
			ld  a, (_rdt)

			#ifdef ENABLE_STEADY_SHOOTER
			._e_d_bullets_steady_shooter
				cp  0x80
				jr  nz, ._e_d_bullets_steady_shooter_done

				ld  de, (_gpit)
				ld  d, 0
				ld  hl, _en_washit
				add hl, de
				ld  (hl), 4
				jr  _e_d_bullets_continue

			._e_d_bullets_steady_shooter_done
			#endif

			#ifdef ENABLE_TYPE7
			._e_d_bullets_c_type7
				cp  0x70
				jr  nz, _e_d_bullets_c_type7_done

				ld  a, (_en_state)
				or  a
				jr  z, _e_d_bullets_continue
				
			._e_d_bullets_c_type7_done
			#endif					

			ld  a, (_bi)
			ld  b, a
			call _bullets_destroy 			// Needs B = bi

			ld  a, (_gpit)
			ld  b, a
			call _enems_drain  				// Needs B = gpit

		._e_d_bullets_continue					
			ld  a, (_bi)
			or  a
			jr  nz, _e_d_bullets_loop

			pop bc
	#endif
#endasm		
