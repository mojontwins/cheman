// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void enems_do (void) {
	//genflipflop = half_life;
	gpit = 3; while (gpit --) {
		spr_idx = SPR_ENEMS_BASE + gpit;
		spr_on [spr_idx] = 0;

		// Consider this a sort of "local copy"

		#asm
			ld  de, (_gpit)
			ld  d, 0

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
		#endasm

		// TODO: Translate this
		#ifdef ENEMIES_NEED_FP
			_enf_x = enf_x [gpit]; _enf_y = enf_y [gpit];
			_enf_vx = enf_vx [gpit]; _enf_vy = enf_vy [gpit];
		#endif
		
		// End of copy. Now use the copies.

		#ifdef ENEMIES_CAN_DIE
			#if defined (ENABLE_TYPE7) && defined (TYPE7_WITH_GENERATOR)
				// TODO
				/*
				if (en_gen_dying [gpit]) {
					en_gen_dying [gpit] --;
					oam_index = oam_meta_spr (_en_x1, _en_y1 + SPRITE_ADJUST, oam_index, EXPLOSION_CELL_BASE);
				}
				*/
			#endif

			if (en_washit [gpit] || en_dying [gpit]) {
				rda = frame_counter & 0xf;

				#ifdef EXPLOSION_CELL_BASE
					spr_next [spr_idx] = sprite_cells [EXPLOSION_CELL_BASE];
					spr_on [spr_idx] = 1;
					spr_x [spr_idx] = _en_x + jitter_big [rda];
					spr_y [spr_idx] = _en_y + jitter_big [15 - rda];
				#else
					spr_on [spr_idx] = half_life;
					spr_x [spr_idx] = _en_x;
					spr_y [spr_idx] = _en_y;
				#endif
				

				if (en_dying [gpit]) { en_dying [gpit] --; continue; }
				if (en_washit [gpit]) en_washit [gpit] --;
			}
		#endif	

		// Enemies can be switch off by raising bit 3

		if (_en_t & 0x08) _en_t = 0;

		rdt = _en_t & 0xf0;
		if (rdt) {
			#ifdef ENABLE_PLATFORMS
				is_platform = (rdt == 0x20);
				if (is_platform) {
					rda = _en_x;
					pregotten = (prx + 9 >= rda && prx <= rda + 17);
				}
			#endif

			// Upside down

			#ifdef ENEMS_UPSIDE_DOWN
				// TODO
				/*
				if (_en_ud) {
					rda = frame_counter & 0xf;
					oam_index = oam_meta_spr (
						_en_x + jitter [rda], _en_y + SPRITE_ADJUST + jitter [15 - rda], 
						oam_index, 
						spr_enems [en_s [gpit] + UPSIDE_DOWN_OFFSET + ((frame_counter >> 4) & 1)]);

					cx1 = (_en_x + 4) >> 4;
					cx2 = (_en_x + 11) >> 4;
					cy1 = cy2 = (_en_y + 15) >> 4;
					cm_two_points ();
					if (at1 | at2) {
						if (rdt == 0x90) enems_drain ();
					} else {
						_en_y ++;
					}

					if (CL (prx, pry, _en_x, _en_y)) {
						if (BUTTON_B(pad) || CONTROLLER_UP(pad)) {
							pj = 1; pctj = 0; 
							pvy = -PLAYER_VY_JUMP_INITIAL;
						} else pvy = -PLAYER_VY_JUMP_FROM_ENEM;

						enems_drain ();
					} 

					enems_restore_vals ();
					continue;
				}
				*/ 
			#endif

			spr_id = 0xff;

			switch (rdt) {

				#ifdef ENABLE_MONOCOCO_SIMPLE
					case 0x90:
						#include "engine/enemmods/enem_monococo_simple.h"
						// No break. Run linear afterwards!
				#endif

				#ifdef ENABLE_LINEAR				
					case 0x10:
					case 0x20:
						//#include "engine/enemmods/enem_linear.h"
						#include "engine/enemmods/enem_linear_assembly.h"
						break;
				#endif

				#ifdef ENABLE_FANTY
					case 0x30:
						#include "engine/enemmods/enem_fanty.h"
						break;
				#elif defined(ENABLE_PRECALC_HOMING_FANTY)					
					case 0x30:
						#include "engine/enemmods/enem_precalc_homing_fanty.h"
						break;
				#elif defined(ENABLE_PRECALC_FANTY)
					case 0x30:
						#include "engine/enemmods/enem_precalc_fanty.h"
						break;
				#elif defined (ENABLE_PRECALC_TIMED_FANTY)
					case 0x30:
						#include "engine/enemmods/enem_precalc_timed_fanty.h"
						break;					
				#endif

				#ifdef ENABLE_CATACROCK
					case 0x40:
						#include "engine/enemmods/enem_catacrock.h"
						break;
				#elif defined (ENABLE_NUBE)
					case 0x40:
						#include "engine/enemmods/enem_nube.h"
						break;					
				#endif

				#ifdef ENABLE_GENERATONIS
					case 0x50:
						#include "engine/enemmods/enem_generatoni.h"
						break;
				#endif

				#ifdef ENABLE_ESPECTROS
					case 0x60:
						#include "engine/enemmods/enem_espectro.h"
						break;
				#endif

				#ifdef ENABLE_TYPE7				
					case 0x70:
						#ifdef TYPE7_WITH_GENERATOR				
							enems_draw_generator ();
						#endif					
						#include "engine/enemmods/enem_type_7_assembly.h"
						break;
				#endif

				#ifdef ENABLE_STEADY_SHOOTER
					case 0x80:
						#include "engine/enemmods/enem_steady_shooter.h"
						break;
				#endif

				#ifdef ENABLE_MONOCOCO
					case 0x90:
						#include "engine/enemmods/enem_monococo.h"
						break;
				#endif

				#ifdef ENABLE_WALKER					
					case 0xa0:
						#include "engine/enemmods/enem_walker.h"
						break;
				#elif defined (ENABLE_PRECALC_PEZON)
					case 0xa0:
						#include "engine/enemmods/enem_precalc_pezon.h"
						break;
				#endif

				#ifdef ENABLE_GYROSAW
					case 0xb0:
						#include "engine/enemmods/enem_gyrosaw.h"
						break;
				#elif defined (ENABLE_SAW)
					case 0xb0:
						#include "engine/enemmods/enem_saw.h"
						break;					
				#endif

				#ifdef ENABLE_LEMMINGS
					case 0xc0:
						#include "engine/enemmods/enem_lemming.h"
						break;
				#endif					

				#ifdef ENABLE_LAME_BOSS_1
					case 0xf0:
						#include "engine/enemmods/enem_lame_boss_1.h"
						break;
				#elif defined (ENABLE_VIRAS)
					case 0xf0:
						#include "engine/enemmods/enem_viras.h"
						break;
				#endif

			}

			// Paint

			#if defined (ENABLE_TYPE7) && defined (TYPE7_WITH_GENERATOR)
				if (rdt == 0x70) enems_draw_generator ();
			#endif		

			if (spr_id != 0xff && spr_on [spr_idx] == 0)  {
				spr_on [spr_idx] = 1;
				spr_x [spr_idx] = _en_x;
				spr_y [spr_idx] = _en_y;
				spr_next [spr_idx] = sprite_cells [spr_id];
			}

			// Moving platforms

			#ifdef ENABLE_PLATFORMS			
				if (is_platform) {
					if (pregotten && !pgotten && !(pj && pvy <= 0)) {
						// Horizontal moving platforms
						if (_en_mx) {
							if (pry + 18 >= _en_y && pry + 12 <= _en_y) {
								pgotten = 1;
								pgtmx = _en_mx << (FIX_BITS - _en_state);
								pry = _en_y - 16; py = pry << FIX_BITS;
								pvy = 0;
							}
						}
						
						// Vertical moving platforms
						if (
							(_en_my < 0 && pry + 17 >= _en_y && pry + 12 <= _en_y) ||
							(_en_my > 0 && pry + 16 + _en_my >= _en_y && pry + 12 <= _en_y)
						) {
							pgotten = 1;
							pgtmy = _en_my << (FIX_BITS - _en_state);
							pry = _en_y - 16; py = pry << FIX_BITS;
							pvy = 0;
						}
					}

					enems_restore_vals ();
					continue;
				}
			#endif

			// Enems <-> Evil tile collision handling

			#ifdef ENEMS_DIE_ON_EVIL_TILE
				// attr at the middle of the 16x16 sprite. Unreadably optimized.
				if (
					(scr_attr [((_en_y - 7) & 0xf0) | ((_en_x + 7) >> 4)] & 1)
					&& (
						#ifdef ENABLE_LINEAR
							rdt == 0x10
						#endif

						#if defined (ENABLE_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY) || defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_TIMED_FANTY)
							|| rdt == 0x30
						#endif

						#ifdef ENABLE_LAME_BOSS_1
							|| (rdt == 0xf0 && _en_state != 2)
						#endif

					)
				) {
					#ifdef ENABLE_LAME_BOSS_1
						if (rdt == 0xf0) _en_y -= LAME_BOSS_HIT_DISPLACEMENT;
					#endif
					enems_drain (); 
					enems_restore_vals ();
					continue;
				}
			#endif		

			// Enems <-> Player collision handling

			#ifdef PLAYER_STEPS_ON_ENEMIES
				if (prx + 7 >= _en_x && prx <= _en_x + 15 && pry + 15 >= _en_y && pry + 8 <= _en_y
					&& pvy >= 0
					#ifdef PLAYER_BUTT
						&& pbutt
					#endif
					#if defined (ENABLE_SAW) || defined (ENABLE_GYROSAW)
						&& rdt != 0xb0 
					#endif
				) {

					#ifdef PLAYER_JUMPS_ON_ENEMIES
						if (BUTTON_B(pad) || CONTROLLER_UP(pad)) {
							pj = 1; pctj = 0; 
							pvy = -PLAYER_VY_JUMP_INITIAL;
						} else
					#endif
					pvy = -PLAYER_VY_BUTT_REBOUND;

					#ifdef PLAYER_DOUBLE_JUMP
						njumps = 1;
					#endif

					#ifdef ENABLE_FUMETTOS				
						fumettos_add ();
					#endif				
					//sfx_play (SFX_BUTT_HIT, SC_LEVEL);

					// Affect enemies
					switch (rdt) {
						case 0x10:
							_en_my = ABS (_en_my);
							break;

						#if defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY) || defined (ENABLE_PRECALC_TIMED_FANTY)
							case 0x30:
								_en_my = FANTY_INCS_MAX - 1;
								break;
						#endif

						#ifdef ENABLE_LAME_BOSS_1
							case 0xf0:
								_en_y += LAME_BOSS_HIT_DISPLACEMENT;
								break;
						#endif
					}

					#ifdef PLAYER_STEPS_KILLS
						#ifdef KILLABLE_CONDITION
								if (KILLABLE_CONDITION)
						#endif
								{
									enems_drain ();
									enems_restore_vals ();
									continue;
								}
					#endif
				} else 
			#endif	

			if (
				#ifdef TALL_PLAYER
					CL_TALL (prx, pry, _en_x, _en_y)
				#else
					CL (prx, pry, _en_x, _en_y)
				#endif
				#ifdef ENABLE_MONOCOCO
					&& (rdt != 0x90 || _en_state == 2)
				#endif
				#ifdef ENABLE_MONOCOCO_SIMPLE
					&& (rdt != 0x90 || (_en_mx | _en_my) == 0)
				#endif
				#ifdef ENABLE_CATACROCK
					&& (rdt != 0x40 || _en_state == 1)
				#endif
				#ifdef ENABLE_GENERATONIS
					&& (rdt != 0x50 || _en_state)
				#endif
				#ifdef ENABLE_TYPE7
					&& (rdt != 0x70 || _en_state)
				#endif
				#ifdef ENABLE_LAME_BOSS_1
					&& (rdt != 0xf0 || _en_state == 1)
				#endif
				#ifdef ENABLE_STEADY_SHOOTER
					&& (rdt != 0x80)
				#endif
			) {
				#ifdef PLAYER_SPINS_KILLS
					if ((pjustjumped || pspin)
					) {
						pvy = -pvy;
						enems_drain ();
						enems_restore_vals ();
						continue;
					} else
				#endif			

				#ifdef PLAYER_FLICKERS
					if (	
						!pflickering	
					) 
				#endif					
				{
					
					#ifdef PLAYER_REBOUNDS					
						#ifdef PLAYER_REBOUND_REVERSE_DIRECTION	
							if (pvx || pvy) {
								if (ABS (pvx) > ABS (pvy)) {
									pvx = ADD_SIGN (-pvx, PLAYER_V_REBOUND);
								} else {
									pvy = ADD_SIGN (-pvy, PLAYER_V_REBOUND);
								}
							} else 
						#endif
						{
							pvx = ADD_SIGN (_en_mx, PLAYER_V_REBOUND);
							pvy = ADD_SIGN (_en_my, PLAYER_V_REBOUND);
						}
					#endif					

					#ifdef ENABLE_ESPECTROS
						if (rdt == 0x60) {
							_en_state = 3; _en_ct = ticks;
						}
					#endif

					#if defined (ENEMIES_CAN_DIE) && defined (ENEMS_SUFFER_WHEN_HITTING_PLAYER)
						enems_drain ();
					#endif

					#ifdef ENABLE_GENERATONIS
						if (rdt == 0x50) _en_mx = -_en_mx;
					#endif
					
					pwashit = 1;
				}
			}

			// Enems <-> Stuff collision handling

			// Puas

			#ifdef ENABLE_PUAS
				bi = PUAS_MAX; while (bi --) if (puas_y [bi] != 240) {
					if (COLLIDE (puas_x [bi], puas_y [bi], _en_x, _en_y)) {
						enems_drain ();
						puas_y [bi] = 240;
					}
				}
			#endif

			// Bullets

			#ifdef PLAYER_CAN_FIRE
				bi = BULLETS_MAX; while (bi --) if (b_ac [bi]) {
					if (COLLIDE (b_x [bi] - 4, b_y [bi] - 4, _en_x, _en_y)) {
						switch (rdt) {
							#ifdef ENABLE_TYPE7						
								case 0x70:
									if (_en_state) {
										enems_drain (); bullets_destroy ();
									}
									break;
							#endif

							#ifdef ENABLE_STEADY_SHOOTER
								case 0x80:
									en_washit [gpit] = TYPE7_MINION_HIT_FRAMES;
									break;
							#endif

							#ifdef ENABLE_WALKER							
								case 0xa0:
									en_washit [gpit] = WALKER_HIT_FRAMES;
									pwashit = 1;
									bullets_destroy ();
									break;
							#endif							
							
							default:
								enems_drain ();
								bullets_destroy ();
								break;
						}
					} 

					#if defined (ENABLE_TYPE7) && defined (TYPE7_WITH_GENERATOR)
						if (b_ac [bi]) {
							if (rdt == 0x70) if (COLLIDE (b_x [bi] - 4, b_y [bi] - 4, _en_x1, _en_y1)) {
								bullets_destroy ();
								if (en_gen_life [gpit]) {
									en_gen_life [gpit] --;
									en_gen_washit [gpit] = TYPE7_GENERATOR_HIT_FRAMES;
								} else {
									enems_drain ();
									//infested --;
									en_gen_dying [gpit] = TYPE7_GENERATOR_DYING_FRAMES;
									if (_en_state) en_dying [gpit] = TYPE7_MINION_DYING_FRAMES;
								}
							}
						}
					#endif				
				}
			#endif			

			// Fabolees

			#ifdef ENABLE_FABOLEES
				if (!_en_ud) {
					bi = FABOLEES_MAX; while (bi --) if (fbl_ct [bi]) {
						if (
							1
							#ifdef ENABLE_MONOCOCO
								&& (rdt != 0x90 || en_state [gpit] == 2)
							#endif
							#if defined(ENABLE_GYROSAW) || defined(ENABLE_SAW)
								&& (rdt != 0xb0)
							#endif
						) {
							if (COLLIDE (fbl_x [bi], fbl_y [bi], _en_x, _en_y)) {
								_en_ud = 1;
								fbl_lock_on [bi] = gpit;
							}
						}
					}
				}
			#endif

			// Hitter

			#ifdef ENABLE_HITTER
				if (hitter_hs_x >= _en_x && hitter_hs_x <= _en_x + 15 &&
					hitter_hs_y >= _en_y && hitter_hs_y <= _en_y + 15) {
					enems_drain ();
				}
			#endif

			// Done thing

		}

		// And when you are done, just undo the copy

		enems_restore_vals ();

		// That's it.
	}
}

