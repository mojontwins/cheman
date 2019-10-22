// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void enems_do (void) {
	#asm
			ld  b, 3
		.__e_d_big_loop
			dec b
			ld  a, b
			ld  (_gpit), a

			add SPR_ENEMS_BASE
			ld  (_spr_idx), a

			ld  d, 0
			ld  e, a
			ld  hl, _spr_on
			add hl, de
			xor a
			ld  (hl), a

		.__e_d_local_copy
			ld  e, b

			ld  hl, _en_t
			add hl, de
			ld  a, (hl)
			ld  (__en_t), a

			ld  hl, _en_x
			add hl, de
			ld  a, (hl)
			ld  (__en_x), a

			ld  hl, _en_y
			add hl, de
			ld  a, (hl)
			ld  (__en_y), a

			ld  hl, _en_x1
			add hl, de
			ld  a, (hl)
			ld  (__en_x1), a

			ld  hl, _en_y1
			add hl, de
			ld  a, (hl)
			ld  (__en_y1), a

			ld  hl, _en_x2
			add hl, de
			ld  a, (hl)
			ld  (__en_x2), a

			ld  hl, _en_y2
			add hl, de
			ld  a, (hl)
			ld  (__en_y2), a

			ld  hl, _en_mx
			add hl, de
			ld  a, (hl)
			ld  (__en_mx), a

			ld  hl, _en_my
			add hl, de
			ld  a, (hl)
			ld  (__en_my), a

			ld  hl, _en_state
			add hl, de
			ld  a, (hl)
			ld  (__en_state), a

			ld  hl, _en_ct
			add hl, de
			ld  a, (hl)
			ld  (__en_ct), a

			#ifdef ENEMS_UPSIDE_DOWN
				ld  hl, _en_ud
				add hl, de
				ld  a, (hl)
				ld  (__en_ud), a
			#endif
			
			#ifdef ENEMIES_NEED_FP
				ld  hl, _enf_vx
				ld  a, (hl)
				ld  (__enf_vx), a

				ld  hl, _enf_vy
				ld  a, (hl)
				ld  (__enf_vy), a

				sla e

				ld  hl, _enf_x
				add hl, de
				ld  a, (hl)
				ld  (__enf), a
				inc hl
				ld  a, (hl)
				ld  (__enf+1), a

				ld  hl, _enf_y
				add hl, de
				ld  a, (hl)
				ld  (__enf), a
				inc hl
				ld  a, (hl)
				ld  (__enf+1), a
			#endif

			// End of copy. Now use the copies.

			// Reset spr_id
			ld  a, 0xff
			ld  (_spr_id), a				

			#ifdef ENEMIES_CAN_DIE
				xor a
				ld  (_rdf), a

				#if defined (ENABLE_TYPE7) && defined (TYPE7_WITH_GENERATOR)
					// TODO
				#endif
				.__e_d_check_washit
					#ifdef ENEMIES_NEED_FP
						ld  e, b
						ld  d, 0
					#endif
					ld  hl, _en_washit
					add hl, de
					ld  a, (hl)
					or  a
					jr  nz, __e_d_washit_or_dying

					ld  hl, _en_dying
					add hl, de
					ld  a, (hl)
					or  a
					jr  z, __e_d_washit_or_dying_done

				.__e_d_washit_or_dying
					ld  a, EXPLOSION_CELL_BASE
					ld  (_spr_id), a

					ld  a, 1
					ld  (_rdf), a
					
					ld e, b
					ld d, 0
					ld hl, _en_dying
					add hl, de
					ld a, (hl)
					or a
					jr z, __e_d_not_dying

					dec a
					ld (hl), a
					call __e_d_paint_proc
					jp __e_d_big_loop_continue

				.__e_d_not_dying
					ld hl, _en_washit
					add hl, de
					ld a, (hl)
					or a
					jr z, __e_d_not_washit

					dec a
					ld (hl), a

				.__e_d_not_washit

				.__e_d_washit_or_dying_done
			#endif

			// Enemies can be switched off by raising bit 3

			ld  a, (__en_t)
			and 0x08
			jr z, __e_d_no_switch_off

			xor a
			ld  (__en_t), a

		.__e_d_no_switch_off

			ld  a, (__en_t)
			and 0xf0
			ld  (_rdt), a
			or  a
			jp  z, __e_d_big_loop_continue

			#ifdef ENABLE_PLATFORMS
				// TODO :: Test
				// Preparation for moving platforms
				.__e_d_platform_precheck
					cp  0x20
					jr  nz, __e_d_not_platform_0
					
				.__e_d_pregotten_calc
					xor a
					ld  (_pregotten), a
					
					ld  a, (__en_x)
					ld  c, a

					ld  a, (_prx)
					add 9
					cp  c
					jr  c, __e_d_pregotten_calc_done

					ld  a, c
					add 17
					ld  c, a

					ld  a, (_prx)
					cp  c
					jr  z, __e_d_pregotten_calc_do
					jr  nc, __e_d_pregotten_calc_done

				.__e_d_pregotten_calc_do
					ld  a, 1
					ld  (_pregotten), a

				.__e_d_pregotten_calc_done
					ld  a, 1
					jr  __e_d_platform_precheck_done
				.__e_d_not_platform_0	
					xor a
				.__e_d_platform_precheck_done
					ld  (_is_platform), a
			#endif

			#ifdef ENEMS_UPSIDE_DOWN
				// Upside down
				// TODO
			#endif

			// Update enemies based upon enemy type
			// TODO :Incomplete. Will keep adding more and more
			// enemy types as I make games.
			// If you are using this and need all the types just
			// use the C version which is still in there.

			push bc

		._enems_update_do
			ld  a, (_rdt)

			#ifdef ENABLE_MONOCOCO_SIMPLE
				.__e_d_monococo_simple_do
					cp  0x90
					jp  nz, __e_d_not_monococo_simple

					#endasm
					#include "engine/enemmods/enem_monococo_simple.h"
					#asm					

					// Keep running the linear type afterwards

				.__e_d_not_monococo_simple_done
					
			#endif

			#ifdef ENABLE_LINEAR
				.__e_d_linear_do
					cp  0x10
					jr  z, __e_d_linear_do_do
					cp  0x20
					jp  nz, __e_d_linear_done

				.__e_d_linear_do_do
					#endasm
					#include "engine/enemmods/enem_linear_assembly.h"
					#asm

					// break
					jp _enems_update_done

				.__e_d_linear_done
			#endif

			#ifdef ENABLE_TYPE7
				.__e_d_type7_do
					cp  0x70
					jp  nz, __e_d_type7_done

					#endasm
					#include "engine/enemmods/enem_type_7_assembly.h"
					#asm

					// break
					jp _enems_update_done

				.__e_d_type7_done
			#endif

		._enems_update_done

			pop bc

			// Paint
			call __e_d_paint_proc

		// Moving platforms

		#ifdef ENABLE_PLATFORMS
		.__e_d_platform_check
			ld  a, (_is_platform)
			or  a
			jp  z, __e_d_platform_done

			// if (pregotten && !pgotten && !(pj && pvy <= 0)) {
			ld  a, (_pregotten)
			or  a
			jp  z, __e_d_platform_done

			ld  a, (_pgotten)
			or  a
			jp  nz, __e_d_platform_done

			ld  a, (_pj)
			or  a
			jr  z, __e_d_platform_do

			ld  a, (_pvy)
			cp  $80
			jp  z, __e_d_platform_done
			jp  nc, __e_d_platform_done

		.__e_d_platform_do

			// Horizontal moving platforms
			ld  a, (__en_mx)
			or  a
			jr  z, __e_d_platform_horz_done

		.__e_d_platform_horz_do

			// if (pry + 20 >= _en_y 
			ld  a, (__en_y)
			ld  c, a
			ld  a, (_pry)
			add 20
			cp  c
			jp  c, __e_d_platform_vert_done

			// && pry + 12 <= _en_y) {
			// _en_y >= pry + 12, skip if _en_y < pry + 12
			ld  a, (_pry)
			add 12
			ld  c, a
			ld  a, (__en_y)
			cp  c
			jp  c, __e_d_platform_vert_done

			ld  a, 1
			ld  (_pgotten), a

			push bc		
			#endasm
				pgtmx = _en_mx << (FIX_BITS - _en_state);
				pry = _en_y - 16; py = pry << FIX_BITS;
				pvy = 0;
				#asm
			pop bc

		.__e_d_platform_horz_done

			// Vertical moving platforms
			ld  a, (__en_my)
			or  a
			jp  z, __e_d_platform_vert_done

			cp  $80
			jr  c, __e_d_platform_vert_my_positive

		.__e_d_platform_vert_my_negative
			// pry + 20 >= _en_y, skip if pry + 20 < _en_y
			ld  a, (__en_y)
			ld  c, a
			ld  a, (_pry)
			add 20
			cp  c
			jp  c, __e_d_platform_vert_done

			// pry + 12 <= _en_y
			// _en_y >= pry + 12, skip if _en_y < pry + 12
			ld  a, (_pry)
			add 12
			ld  c, a
			ld  a, (__en_y)
			cp  c
			jp  c, __e_d_platform_vert_done

			jr  __e_d_platform_vert_do

		.__e_d_platform_vert_my_positive
			//  pry + 20 + _en_my >= _en_y, skip if pry + 16 + _en_my < _en_y
			ld  a, (__en_y)
			ld  c, a
			ld  a, (__en_my)
			ld  d, a
			ld  a, (_pry)
			add 20
			add d
			cp  c
			jp  c, __e_d_platform_vert_done

			// pry + 12 <= _en_y
			// _en_y >= pry + 12, skip if _en_y < pry + 12
			ld  a, (_pry)
			add 12
			ld  c, a
			ld  a, (__en_y)
			cp  c
			jr  c, __e_d_platform_vert_done

		.__e_d_platform_vert_do

			ld  a, 1
			ld  (_pgotten), a

			push bc
			#endasm
				pgtmy = _en_my << (FIX_BITS - _en_state);
				pry = _en_y - 16; py = pry << FIX_BITS;
				pvy = 0;
			#asm
			pop bc

		.__e_d_platform_vert_done

			jp __e_d_big_loop_update_and_continue

		.__e_d_platform_done
		#endif

		// Enems <-> Evil collision
		#if defined (ENEMS_DIE_ON_EVIL_TILE) && (defined (ENABLE_LINEAR) || defined (ENABLE_FANTY))
		.__e_d_evil_tile_check

			// Calculate attribute at the center of the collision box
			ld  a, (__en_y)
			sub 7
			and 0xf0
			ld  c, a
			ld  a, (__en_x)
			add 7
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
			and 1
			jr  z, __e_d_evil_tile_done

			// Only for types 0x10, 0x30
			ld  a, (__rdt)
			#if defined (ENABLE_LINEAR) && defined (ENABLE_FANTY)			
				cp  0x10
				jr  z, __e_d_evil_tile_do
				cp  0x30
				jr  nz, __e_d_evil_tile_done
			#elif defined (ENABLE_LINEAR)
				cp  0x10
				jr  nz, __e_d_evil_tile_done
			#elif defined (ENABLE_FANTY)
				cp  0x30
				jr  nz, __e_d_evil_tile_done
			#endif
		.__e_d_evil_tile_do
			call _enems_drain
			jp  __e_d_big_loop_update_and_continue

		.__e_d_evil_tile_done
		#endif

		// Enems <-> Player collision

		#ifdef ENABLE_PLATFORMS
			ld  a, (_rdt)
			cp  0x20
			jp  z, __e_d_pcol_done
		#endif

		#ifdef PLAYER_STEPS_ON_ENEMIES
			// Check stuff, if it fails, go to normal collision at __e_d_player_collision.
			// After it is done, skip to __e_d_pcol_done

			// Check this collision:
			// prx + 7    >= _en_x
			// _en_x + 15 >= prx
			// pry + 15   >= _en_y
			// _en_y      >= pry + 8

			// Break if
			// A             C
			// prx + 7    < _en_x
			// _en_x + 15 < prx
			// pry + 15   < _en_y
			// _en_y      < pry + 8			

			ld  a, (__en_x)
			ld  c, a
			ld  a, (_prx)
			add 8
			cp  c
			jp  c, __e_d_player_collision

			ld  a, (_prx)
			ld  c, a
			ld  a, (__en_x)
			add 16
			cp  c
			jp  c, __e_d_player_collision
			
			// CUSTOM { Changed some values for tall batucados!}
			ld  a, (__en_y)
			ld  c, a
			ld  a, (_pry)
			;add 15		
			add 23
			cp  c
			jp  c, __e_d_player_collision

			ld  a, (_pry)
			;add 8
			add 12
			ld  c, a
			ld  a, (__en_y)			
			
			cp  c
			jp  c, __e_d_player_collision

			// && pvy >= 0
			ld  a, (_pvy)
			cp  $80								; sign
			jp  nc, __e_d_player_collision 		; branch if negative

			#ifdef PLAYER_BUTT
				ld  a, (_pbutt)
				or  a
				jr  z, __e_d_player_collision
			#endif

			#if defined (ENABLE_SAW) || defined (ENABLE_GYROSAW)
				ld  a, (_rdt)
				cp  0xb0
				jr  z, __e_d_player_collision
			#endif

			// Player has set foot on the evil baddie
			#ifdef PLAYER_JUMPS_ON_ENEMIES
				.__e_d_jumps_on_enemies
				// if (BUTTON_B(pad) || CONTROLLER_UP(pad))
				#ifdef SPECCY
					// if ( (pad & sp_FIRE) == 0 )
					ld  a, (_pad)
					and sp_FIRE
					jr  z, __e_d_jumps_on_enemies_do

					ld  a, (_pad)
					and sp_UP
					jr  nz, __e_d_jumps_on_enemies_done
				.__e_d_jumps_on_enemies_do
				#endif

				#ifdef CPC
					// if ( (cpc_TestKey (KEY_BUTTON_B)))
					ld  l, KEY_BUTTON_B
					push bc
					call cpc_TestKey
					pop bc
					xor a 
					or  l
					jr  z, __e_d_jumps_on_enemies_done
				#endif

					ld  a, 1
					ld  (_pj), a
					xor a
					ld  (_pctj), a
					ld  a, -PLAYER_VY_JUMP_INITIAL
					ld  (_pvy), a

					jp  __e_d_step_bounce_done

				.__e_d_jumps_on_enemies_done
			#endif

				ld  a, -PLAYER_VY_BUTT_REBOUND
				ld  (_pvy), a
			.__e_d_step_bounce_done

			#ifdef PLAYER_DOUBLE_JUMP
				ld  a, 1
				ld  (_njumps), 1
			#endif

			#ifdef ENABLE_FUMETTOS
				push bc
				call _fumetos_add
				pop bc 
			#endif

			// Affect enemies
			#if defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY) || defined (ENABLE_PRECALC_TIMED_FANTY)
				ld  a, (_rdt)
				cp  0x30
				jr  nz, __e_d_step_affect_t30_done

				ld  a, (FANTY_INCS_MAX - 1)
				ld  (__en_my), a
				jp  __e_d_step_affect_done

			.__e_d_step_affect_t30_done
			#endif

				// _en_my = ABS (_en_my)
				ld  a, (__en_my)
				cp  $80 
				jr  c, __e_d_step_affect_done

				neg
				ld  (__en_my), a

			.__e_d_step_affect_done

			#ifdef PLAYER_STEPS_KILLS
				// killable condition must be HARDCODED!
				ld  a, (__en_t)
				and 7
				cp  2
				jr  nz, __e_d_step_kills_done

				call _enems_drain
				jp  __e_d_big_loop_update_and_continue

			.__e_d_step_kills_done
			#endif

			jp __e_d_pcol_done
		#endif

		.__e_d_player_collision

		// prx + 4    >= _en_x
		// _en_x + 12 >= prx
		// pry + 12   >= _en_y
		// _en_y + 8  >= pry

		// O lo mismo, break si
		// A            C
		// prx + 4    < _en_x
		// _en_x + 12 < prx
		// pry + 12   < _en_y
		// _en_y + 8  < pry

		// The last + 8 is +12 #ifdef TALL_PLAYER 

			ld  a, (__en_x)
			ld  c, a
			ld  a, (_prx)
			add 4
			cp  c
			jp  c, __e_d_pcol_done

			ld  a, (_prx)
			ld  c, a
			ld  a, (__en_x)
			add 12
			cp  c
			jp  c, __e_d_pcol_done

			ld  a, (__en_y)
			ld  c, a
			ld  a, (_pry)
			;add 12
			add 16			; CUSTOM!!
			cp  c
			jp  c, __e_d_pcol_done

			ld  a, (_pry)
			ld  c, a
			ld  a, (__en_y)
			#ifdef TALL_PLAYER
				add 12
			#else
				add 8
			#endif
			cp  c
			jp  c, __e_d_pcol_done

		// Check for enemy type
			ld  a, (_rdt)
			ld  c, a

			#ifdef ENABLE_MONOCOCO
			.__e_d_pcol_monococo_check
				ld  a, c
				cp  0x90
				jr  nz, __e_d_pcol_monococo_done
				ld  a, (_en_state)
				cp  2
				jp  nz, __e_d_pcol_done
			.__e_d_pcol_monococo_done
			#endif

			#ifdef ENABLE_CATACROCK
			.__e_d_pcol_catacrock_check
				ld  a, c
				cp  0x40
				jr  nz, __e_d_pcol_catacrock_check_done
				ld  a, (_en_state)
				cp  1
				jp  nz, __e_d_pcol_done
			.__e_d_pcol_catacrock_check_done
			#endif

			#ifdef ENABLE_GENERATONIS
			.__e_d_pcol_generatoni_check
				ld  a, c
				cp  0x50
				jr  nz, __e_d_pcol_generatoni_check_done
				ld  a, (_en_state)
				or  a
				jp  z, __e_d_pcol_done
			.__e_d_pcol_generatoni_check_done
			#endif

			#ifdef ENABLE_TYPE7
			.__e_d_pcol_type7_check
				ld  a, c
				cp  0x70
				jr  nz, __e_d_pcol_type7_check_done
				ld  a, (_en_state)
				or  a
				jp  z, __e_d_pcol_done
			.__e_d_pcol_type7_check_done
			#endif

			#ifdef ENABLE_STEADY_SHOOTER
				ld  a, c
				cp  0x80
				jp  z, __e_d_pcol_done
			#endif

		// More checks

			#ifdef PLAYER_FLICKERS
				ld  a, (_pflickering)
				or  a
				jp  nz, __e_d_pcol_done
			#endif

		.__e_d_pcol_do
			// TODO: PLAYER_SPINS_KILLS

			#ifdef PLAYER_REBOUNDS
				#ifdef PLAYER_REBOUND_REVERSE_DIRECTION
				.__e_d_pcol_prebounds
					ld  a, (_pvx)
					or  a
					jr  nz, __e_d_pcol_prb_do
					ld  a, (_pvy)
					or  a
					jr  z, __e_d_pcol_prb_enpos
				
				.__e_d_pcol_prb_do
				
					// ABS pvy -> C
					ld  a, (_pvy)
					cp  $80
					jr  c, __e_d_pcol_prb_abs_pvy_pos
					
					neg

				.__e_d_pcol_prb_abs_pvy_pos
					ld  c, a

					// ABS pvx -> A
					ld  a, (_pvx)
					cp  $80
					jr  c, __e_d_pcol_prb_abs_pvx_pos
					
					neg

				.__e_d_pcol_prb_abs_pvx_pos

					cp  c
					jr  c, __e_d_pcol_prb_do_pvy

				.__e_d_pcol_prb_do_pvx

					// If pvx > 0 -> pvx = -PLAYER_V_REBOUND
					// If pvx < 0 -> pvx = PLAYER_V_REBOUND

					ld  a, (_pvx)
					cp  $80
					jr  c, __e_d_pcol_prb_pvx_as_p
					
					ld  a, PLAYER_V_REBOUND
					ld  (_pvx), a
					jr  __e_d_pcol_prb_done

				.__e_d_pcol_prb_pvx_as_p
					ld  a, -PLAYER_V_REBOUND
					ld  (_pvx), a
					jr  __e_d_pcol_prb_done

				.__e_d_pcol_prb_do_pvy

					// If pvy > 0 -> pvy = -PLAYER_V_REBOUND
					// If pvy < 0 -> pvy = PLAYER_V_REBOUND

					ld  a, (_pvy)
					cp  $80
					jr  c, __e_d_pcol_prb_pvy_as_p
					
					ld  a, PLAYER_V_REBOUND
					ld  (_pvy), a
					jr  __e_d_pcol_prb_done

				.__e_d_pcol_prb_pvy_as_p
					ld  a, -PLAYER_V_REBOUND
					ld  (_pvy), a
					jr  __e_d_pcol_prb_done

				.__e_d_pcol_prb_enpos

					// If prx > _en_x -> prx = PLAYER_V_REBOUND
					// If prx < _en_x -> prx = -PLAYER_V_REBOUND
				.__e_d_pcol_prb_enpos_check_x
					ld  a, (__en_x)
					ld  c, a
					ld  a, (_prx)
					cp  c
					jr  c, __e_d_pcol_prb_enpos_en_x_bigger

					ld  a, PLAYER_V_REBOUND
					ld  (_pvx), a
					jr  __e_d_pcol_prb_enpos_check_y

				.__e_d_pcol_prb_enpos_en_x_bigger
					ld  a, -PLAYER_V_REBOUND
					ld  (_pvx), a

				.__e_d_pcol_prb_enpos_check_y
					ld  a, (__en_y)
					ld  c, a
					ld  a, (_pry)
					cp  c
					jr  c, __e_d_pcol_prb_enpos_en_y_bigger

					ld  a, PLAYER_V_REBOUND
					ld  (_pvy), a
					jr  __e_d_pcol_prb_done

				.__e_d_pcol_prb_enpos_en_y_bigger
					ld  a, -PLAYER_V_REBOUND
					ld  (_pvy), a

				.__e_d_pcol_prb_done
				#endif
			#endif

			#ifdef ENABLE_ESPECTROS
			.__e_d_pcol_with_espectro
				ld  a, c
				cp  0x60
				jr  nz, __e_d_pcol_with_espectro_done
				ld  a, 3
				ld  (__en_state), a
				ld  a, (_ticks)
				ld  (__en_ct), a
			.__e_d_pcol_with_espectro_done
			#endif

			#if defined (ENEMIES_CAN_DIE) && defined (ENEMS_SUFFER_WHEN_HITTING_PLAYER)
				call _enems_drain				
			#endif

			#ifdef ENABLE_GENERATONIS
			.__e_d_pcol_with_generatoni
				ld  a, c
				cp  0x50
				jr nz, __e_d_pcol_with_generatoni_done
				ld  a, (__en_mx)
				neg
				ld  (__en_mx), a
			.__e_d_pcol_with_generatoni_done
			#endif

			ld  a, 1
			ld  (_pwashit), a

		.__e_d_pcol_done

		// Enems <-> Stuff collision

			// Puas
			#ifdef ENABLE_PUAS
			// TODO
			#endif

			// Bullets
			#endasm
			#include "engine/enemmods/enems_col_bullets_assembly.h"			
			#asm

			// Fabolees
			#ifdef ENABLE_FABOLEES
			// TODO
			#endif

			// Hitter
			#ifdef ENABLE_HITTER
			// TODO
			#endif

		.__e_d_big_loop_update_and_continue
			call _enems_restore_vals
		.__e_d_big_loop_continue

			ld  a, b
			or  a
			jp  nz, __e_d_big_loop
		ret

		.__e_d_paint_proc
		.__e_d_paint_check
			#if defined (ENABLE_TYPE7) && defined (TYPE7_WITH_GENERATOR)
					ld  a, (_rdt)
					cp  0x70
					jr  nz, __e_d_paint_no_gen
					call enems_draw_generator
				.__e_d_paint_no_gen
			#endif

			ld  a, (_spr_id)
			cp  0xff
			jr  z, __e_d_no_paint
			ld  de, (_spr_idx)
			ld  d, 0
			ld  hl, _spr_on
			add hl, de
			ld  a, (hl)
			or  a
			jr  nz, __e_d_no_paint

		.__e_d_paint
			ld  a, 1
			ld  de, (_spr_idx)
			ld  d, 0
			ld  hl, _spr_on
			add hl, de
			ld  (hl), a

			ld  hl, _spr_x
			add hl, de
			ld  a, (__en_x)
			ld  (hl), a

			ld  hl, _spr_y
			add hl, de
			ld  a, (__en_y)
			ld  (hl), a

			ld  hl, (_spr_idx)
			ld  h, 0
			add hl, hl
			ld  de, _spr_next
			add hl, de
			push hl

			ld  hl, (_spr_id)
			add hl, hl
			ld  de, _sprite_cells
			add hl, de
			pop de

			; HL -> _sprite_cells + 2*_spr_id
			; DE -> _spr_next + 2*spr_id

			ld  a, (hl)
			ld  (de), a
			inc hl
			inc de
			ld  a, (hl)
			ld  (de), a

			// JITTER
		.__e_d_paint_jitter
			ld  a, (_rdf)
			or  a
			jr  z, __e_d_no_paint

			ld  a, (_frame_counter)
			and 0x0f
			ld  c, a

			push bc

			ld  d, 0
			ld  e, a
			ld  hl, _jitter_big
			add hl, de
			ld  a, (hl)
			ld  b, a

			ld  a, c
			neg a
			add 15
			ld  e, a
			ld  hl, _jitter_big
			add hl, de
			ld  a, (hl)
			ld  c, a

			ld  de, (_spr_idx)
			ld  d, 0
			ld  hl, _spr_x
			add hl, de
			ld  a, (hl)
			add b
			ld  (hl), a

			ld  hl, _spr_y
			add hl, de
			ld  a, (hl)
			add c
			ld  (hl), a

			pop  bc			
		.__e_d_no_paint

	#endasm
}
