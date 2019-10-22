// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Player movement & stuff

#ifdef PLAYER_SAFE
void player_register_safe_spot (void) {
	safe_prx = prx; safe_pry = pry;
	safe_n_pant = n_pant;
}

void player_restore_safe_spot (void) {
	prx = safe_prx; px = prx << FIX_BITS;
	pry = safe_pry; py = pry << FIX_BITS;
	n_pant = safe_n_pant;	
}
#endif

#ifdef ENABLE_HOLES
void player_holed (void) {
	pholed = 48; 
	pvx = ADD_SIGN(pvx, PLAYER_V_INERTIA);
	pvy = ADD_SIGN(pvy, PLAYER_V_INERTIA);
	pad = 0xff;
}
#endif

void player_reset_movement (void) {	
	#asm
		xor a

		#if defined (PVX_INT) || defined (PVY_INT)
			ld  hl, 0
		#endif

		#ifdef PVX_INT
			ld (_pvx), hl
		#else
			ld (_pvx), a
		#endif
		#ifdef PVY_INT
			ld (_pvy), hl
		#else
			ld (_pvy), a
		#endif

		ld  (_pfixct), a
		ld  (_pfiring), a
		ld  (_phit), a

		#ifdef PLAYER_MONONO
			ld  (_pvylast), a
		#endif
		#ifdef PLAYER_JUMPS	
			ld  (_pj), a 
			ld  (_pjustjumped), a
		#endif
		#ifdef PLAYER_JETPAC	
			ld  (_pthrust), a
		#endif
		#ifdef PLAYER_SPINS	
			ld  (_pspin), a
		#endif	
		#ifdef PLAYER_BUTT
			ld  (_pbutt), a
		#endif
		#ifdef ENABLE_HOLES
			ld  (_pholed), a
		#endif
		#ifdef ENABLE_FUMETTOS
			ld  (_thrustct), a
		#endif
		#ifdef ENABLE_WATER
			ld (_pwater), a
		#endif
		#ifdef PLAYER_FLOATS
			ld (_pfloat), a
		#endif
		#ifdef PLAYER_PUSH_BOXES_ANIMATE
			ld (_ppushing), a
		#endif
	#endasm
}

#ifdef PLAYER_PROCESS_BLOCK
	#ifdef PLAYER_GRAVITY
		void player_process_block (void) {
			if (__y) __y --;
			rdc = __x + (__y << 4);
			rda = scr_attr [rdc] & 1;
			if (rda) {
				#ifdef PLAYER_PUSH_BOXES		
					#ifdef PLAYER_FIRE_TO_PUSH
					if (BUTTON_A (pad)) 
					#endif		
					{
						// push block
						pbx1 = __x;
						if (CONTROLLER_LEFT (pad)) {
							if (__x > 0) if (0 == scr_attr [__x - 1 + (__y << 4)]) pbx1 = __x - 1;
						} else if (CONTROLLER_RIGHT (pad)) {
							if (__x < 15) if (0 == scr_attr [__x + 1 + (__y << 4)]) pbx1 = __x + 1;
						}
						if (pbx1 != __x) {
							#ifdef FLOATY_PUSH_BOXES
								_t = scr_buff [rdc];
								_x = __x;
								_y = __y;
								set_map_tile ();

								_t = 14;
								rdf = (__y << 4) | pbx1;
								scr_attr [rdf] = 11;
								_x = SCR_X + (pbx1 << 1); _y = SCR_Y + (__y << 1);
								DRAW_TILE_UPD ();

								fpb_add ();
							#else					
								_t = 0;
								_x = __x;
								_y = __y;
								set_map_tile (); 
								_t = 14;
								_x = pbx1;
								_y = ___y;
								set_map_tile ();
							#endif					
							hotspots_paint ();
							SFX_PLAY (SFX_COCO);
						}
						#ifdef PLAYER_PUSH_BOXES_ANIMATE
							ppushing = PLAYER_PUSH_BOXES_ANIMATE;
						#endif				

						#ifdef PLAYER_FIRE_TO_PUSH				
							pfiring = 1;
						#endif								
						}
				#endif
			} else {
				#ifdef HOTSPOT_TYPE_KEY			
					// Key hole
					if (pkeys) {
						pkeys --;
						bolts_clear_bolt ();
						_t = 0; _x = __x; _y = __y; 
						set_map_tile ();
						SFX_PLAY (SFX_COCO);
					}
				#endif				
			}
		}
	#else
		#include "engine/playermods/player_process_block_genital_assembly.h"
	#endif
#endif

void player_init (void) {
	// Init player data
	prx = c_level [PLAYER_INI_X] << 4; px = prx << FIX_BITS;
	pry = c_level [PLAYER_INI_Y] << 4; py = pry << FIX_BITS;

#ifdef PLAYER_SAFE
	player_register_safe_spot ();
#endif
	
#ifdef ENABLE_HITTER
	hitter_frame = 0;
#endif

#ifdef PLAYER_GENITAL
	pfacing = pfacingv = CELL_FACING_DOWN;		
	pfacinglast = pfacingh = CELL_FACING_RIGHT;
#else
	pfacing = CELL_FACING_RIGHT;
#endif

	player_reset_movement ();
	pkilled = 0;
	pstep = pframe = 0;
	psprid = 0;
}

void player_hit (void) {
	SCREEN_UPDATE;
	SFX_PLAY (SFX_DEATH);

#ifdef PLAYER_DIE_AND_RESPAWN
	#ifdef PLAYER_DIE_AND_RESPAWN_JUST_SPIKES
		if (evil_tile_hit)
	#endif
	{
		//player_render ();
		#ifdef SPECCY	
			pad0 = 0xff;
		#endif	
		//music_pause (1);
		delay (60);
		//music_pause (0);
		player_reset_movement ();
		player_restore_safe_spot ();
	}
#endif

#ifdef ENABLE_HOLES
	if (pholed) {
		player_reset_movement ();
		player_restore_safe_spot ();
		pholed = 0;
	}
#endif

#ifdef PLAYER_FLICKERS
	pflickering = PLAYER_FLICKERS;
#endif
	
	if (plife) {
		plife --;
	} else {
		pkilled = 1;
	}
	
	phit = PLAYER_HIT_FRAMES;

	pwashit = 0;

	#ifdef ENABLE_HITTER
		hitter_frame = 0;
	#endif
}

void player_move (void) {
	// Player state
	
	#asm
			// if (phit) phit --;

			ld  hl, _phit
			ld  a, (hl)
			or  a
			jr  z, _player_move_gl_00
			dec (hl)
		._player_move_gl_00

			// if (pflickering) pflickering --;

			ld  hl, _pflickering
			ld  a, (hl)
			or  a
			jr  z, _player_move_gl_01
			dec (hl)
		._player_move_gl_01
	#endasm

	// Refine this with use_ct, guay_ct, etc.

	#ifdef FIRE_SCRIPT_WITH_ANIMATION
		#include "engine/playermods/fire_script_with_animation.h"
	#endif 

	#ifdef SPECCY	
			pad = pad0;
	#endif
	#ifdef CPC
			pad = 0;
	#endif	

	#ifdef ENABLE_EVIL_TILE
		evil_tile_hit = 0;
	#endif

	#ifdef ENABLE_HOLES
		if (pholed) pad = 0xff;
	#endif	

	#ifdef PLAYER_PUSH_BOXES_ANIMATE
		if (ppushing) {
			pad = 0xff;
			ppushing --;
		}
	#endif

	#if defined (EVIL_TILE_MULTI) || defined (EVIL_TILE_CENTER) || defined (PLAYER_DIE_AND_RESPAWN)
		pcx = px; pcy = py;
	#endif

	// ********
	// Vertical
	// ********

	#ifdef PLAYER_GRAVITY
		#ifdef ENABLE_WATER
			if (pwater) {
				pvy += PLAYER_G_WATER;
				if (pvy > PLAYER_VY_MAX_SINK_WATER) pvy = PLAYER_VY_MAX_SINK_WATER;
			} else
		#endif
		
		// Gravity
		if (!pgotten
			#ifdef PLAYER_JETPAC
				&& !pthrust
			#endif
		) {
			if (!pj) {
				#ifdef PLAYER_FLOATS
					if (pfloat) {
						if (half_life) { if (pvy < 16) pvy ++; else pvy = 16; }
					} else
				#endif			
				//pvy += PLAYER_G; 
				if (pvy >= PLAYER_VY_FALLING_MAX - PLAYER_G) pvy = PLAYER_VY_FALLING_MAX;
				else pvy += PLAYER_G;
			} else {
				//pvy += PLAYER_G_JUMPING;
				if (pvy >= PLAYER_VY_FALLING_MAX - PLAYER_G_JUMPING) pvy = PLAYER_VY_FALLING_MAX;
				else pvy += PLAYER_G_JUMPING;
			}
		}
	#endif

	#ifdef PLAYER_GENITAL
		// Poll pad
		if (CONTROLLER_UP (pad)) {
			/*
			if (!pfixct) if (pvy > -PLAYER_VY_MAX) {
				pvy -= PLAYER_AY;			
			}
			pfacingv = CELL_FACING_UP;
			*/
			#asm
					// if (!pfixct)
					ld  a, (_pfixct)
					or  a
					jp  nz, _pm_poll_pad_vert_up_skip

					//  if (pvy > -PLAYER_VY_MAX) {
					//  Get char and expand to 16 bits into HL
					ld  hl, _pvy
					call l_gchar					
					ld  de, -PLAYER_VY_MAX
					ex  de, hl
					call l_gt
					jp  nc, _pm_poll_pad_vert_up_skip

					// pvy -= PLAYER_AY;
					ld  a, (_pvy)
					add -PLAYER_AY
					ld  (_pvy), a
				._pm_poll_pad_vert_up_skip

					// pfacingv = CELL_FACING_DOWN;	
					ld  a, CELL_FACING_UP
					ld  (_pfacingv), a
			#endasm
		} else if (CONTROLLER_DOWN (pad)) {
			if (!pfixct) if (pvy < PLAYER_VY_MAX) {
				pvy += PLAYER_AY;
			}
			pfacingv = CELL_FACING_DOWN;

			#asm
					// if (!pfixct)
					ld  a, (_pfixct)
					or  a
					jr  nz, _pm_poll_pad_vert_down_skip

					//  if (pvy < PLAYER_VY_MAX) {
					//  Get char and expand to 16 bits into HL
					ld  hl, _pvy
					call l_gchar					
					ld  de, PLAYER_VY_MAX
					ex  de, hl
					call l_lt
					jr  nc, _pm_poll_pad_vert_down_skip

					// pvy += PLAYER_AY;
					ld  a, (_pvy)
					add PLAYER_AY
					ld  (_pvy), a
				._pm_poll_pad_vert_down_skip

					// pfacingv = CELL_FACING_DOWN;	
					ld  a, CELL_FACING_DOWN
					ld  (_pfacingv), a
			#endasm
		} else {
			/*
			#ifdef ENABLE_HOLES
			if (!pholed)
			#endif
				if (pvy > 0) {
					pvy -= PLAYER_RY; if (pvy < 0) pvy = 0; 
				} else if (pvy < 0) {
					pvy += PLAYER_RY; if (pvy > 0) pvy = 0;
				}

			pfacingv = 0xff;
			*/
			#asm
				#ifdef ENABLE_HOLES
					ld  a, (_pholed)
					jr  nz, _pm_poll_pad_vert_none_skip
				#endif

				/*
				if (pvy > 0) {
					pvy -= PLAYER_RY; if (pvy < 0) pvy = 0; 
				} else if (pvy < 0) {
					pvy += PLAYER_RY; if (pvy > 0) pvy = 0;
				}
				*/
					ld  a, (_pvy)
					or  a
					jr  z, _pm_poll_pad_vert_none_skip
					cp  128
					jp  c, _pm_poll_pad_vert_none_positive

				._pm_poll_pad_vert_none_negative
					ld  a, (_pvy)
					add PLAYER_RY					
					jp  m, _pm_poll_pad_vert_none_done
					xor a				
					jp _pm_poll_pad_vert_none_done

				._pm_poll_pad_vert_none_positive
					ld  a, (_pvy)
					sub PLAYER_RY 					
					jp  p, _pm_poll_pad_vert_none_done
					xor a 					

				._pm_poll_pad_vert_none_done
					ld  (_pvy), a

				._pm_poll_pad_vert_none_skip					
					ld  a, 0xff
					ld  (_pfacingv), a
			#endasm
		}
	#endif

	// Move

	#asm
		// py += pvy;
		ld  de, (_py)
		ld  hl, _pvy
		call l_gchar
		add hl, de
		ld  (_py), hl

		// if (py < ABSOLUTE_BOTTOM<<FIX_BITS) { py = ABSOLUTE_BOTTOM<<FIX_BITS; }
		ld  de, ABSOLUTE_BOTTOM_FIX_BITS
		ex  de, hl
		call l_lt
		jr  nc, _pm_vert_move_topb_done
		ld  de, ABSOLUTE_BOTTOM_FIX_BITS
		ld  (_py), de
		jp  _pm_vert_move_botb_done
	._pm_vert_move_topb_done

		// else if (py > (PRY_MAX<<FIX_BITS)) { py = PRY_MAX<<FIX_BITS; }
		ld  hl, PRY_MAX_FIX_BITS
		call l_gt
		jr  nc, _pm_vert_move_botb_done
		ld  de, PRY_MAX_FIX_BITS
		ld  (_py), de
	._pm_vert_move_botb_done

		// pry = py >> FIX_BITS;
		// de <- py
		ld  l, 4
		call l_asr
		ld  a, l
		ld  (_pry), a
	#endasm

	// Collision
	#include "engine/playermods/collision_vert_assembly.h"

	// Floor detections: Conveyors
		
	#ifdef PLAYER_GRAVITY
		// Floor detections: possee

		cy1 = cy2 = (pry + 16) >> 4;
		cm_two_points ();
		ppossee = ((at1 & FLOOR_BITS) || (at2 & FLOOR_BITS)) && pvy >= 0 && ((pry & 0xf) == 0);
		
		#ifdef PLAYER_JUMPS	
			if (ppossee || pgotten) {
				pjustjumped = 0;
				#ifdef PLAYER_DOUBLE_JUMP
					njumps = 0;
				#endif		
			}
		#endif	

		#ifdef ENABLE_CONVEYORS
			if (ppossee) {
				if (at1 & CONVEYOR_BIT) { if (at1 & EVIL_BIT) pgtmx = CONVEYOR_SPEED; else pgtmx = -CONVEYOR_SPEED; pgotten = 1; }
				if (at2 & CONVEYOR_BIT) { if (at2 & EVIL_BIT) pgtmx = CONVEYOR_SPEED; else pgtmx = -CONVEYOR_SPEED; pgotten = 1; }
			}
		#endif	

		// Floor detections: Propellers

		#ifdef ENABLE_PROPELLERS
			if ((at1 & PROPELLERS_BIT) || (at2 & PROPELLERS_BIT)) {
				pvy -= PLAYER_G + PLAYER_AY_PROPELLER;
				if (pvy < -PLAYER_VY_PROPELLER_MAX) pvy = -PLAYER_VY_PROPELLER_MAX;
			}
		#endif

		// Floor dertections: springs

		#ifdef ENABLE_SPRINGS
			if (springs_on) {
				_t = SPRINGS_TILE; _x = 0xff;
				if (t1 == SPRINGS_TILE_DETECT) {
					_y = cy1 - 2; _x = cx1; set_map_tile ();
				}
				if (t2 == SPRINGS_TILE_DETECT) {
					_y = cy1 - 2; _x = cx2; set_map_tile ();
				}
				if (_x != 0xff) SFX_PLAY (SPRINGS_SOUND);
			}
		#endif

		// Floor detections: Evil tile

		#ifdef ENABLE_EVIL_TILE
			#ifdef EVIL_TILE_ON_FLOOR
				cy1 = cy2 = (pry + 12) >> 4;	// Let it bleed a bit
				cm_two_points ();
				if (at1 == 1 || at2 == 1) evil_tile_hit = 1;
			#endif	
		#endif

		// Floor detections: Slippery

		#ifdef ENABLE_SLIPPERY
			pslips = ppossee && ((at1 & SLIPPERY_BIT) || (at2 & SLIPPERY_BIT));
		#endif
	#endif	

	// Jump!

	#ifdef PLAYER_JUMPS
		
		if (BUTTON_B(pad)
		#if defined (SPECCY) & defined (JUMP_WITH_UP)
			|| CONTROLLER_UP (pad)
		#endif
		) {
			if (!pjb) {
				pjb = 1;
				#ifdef ENABLE_WATER
					if (pwater) {
						if (ppossee) player_register_safe_spot ();
						pvy -= PLAYER_AY_SWIM;
						if (pvy < -PLAYER_VY_SWIM_MAX) pvy = -PLAYER_VY_SWIM_MAX;
						pwaterthrustct ++;
						if (rand8 () & 0xf) hearts_create ();
					} else
				#endif			
				if (!pj) {
					if (
						(pgotten || ppossee || phit)
						#ifdef PLAYER_DOUBLE_JUMP
							|| (njumps < 2)
						#endif
					) {
						#ifdef PLAYER_DOUBLE_JUMP					
							if (njumps) {
								fumettos_add ();
								pctj = 2;
							} else
						#endif					
						pctj = 0; 

						#ifdef PLAYER_DOUBLE_JUMP
						njumps ++;
						#endif			

						pj = 1; pjustjumped = 1;
						pvy = -PLAYER_VY_JUMP_INITIAL;

						SFX_PLAY (SFX_JUMP);

						#ifdef PLAYER_DIE_AND_RESPAWN
							if (ppossee) {
								player_register_safe_spot ();
							}
						#endif					
					}
				} 
			}
			if (pj) {
				pctj ++; if (pctj == PLAYER_VY_JUMP_A_STEPS) pj = 0;
			}
		} else {
			pjb = 0;
			if (pj) {
				if (pvy < -PLAYER_VY_JUMP_RELEASE) pvy = -PLAYER_VY_JUMP_RELEASE;
				pj = 0;
			}
		}
	#endif

	// Monono!

	#ifdef PLAYER_MONONO
		if (!(BUTTON_B(pad) || CONTROLLER_UP(pad))) { pj = 0; pvylast = -PLAYER_VY_JUMP_INITIAL; } else {
			if (ppossee || pgotten) {
				pvy = SATURATE_N (pvylast - PLAYER_AY_JUMP, -PLAYER_VY_JUMP_MAX);
				pvylast = pvy;
				pj = 1;
				//sfx_play (SFX_JUMP, SC_PLAYER);
			}
		}
	#endif	

	// Jet Pac

	#ifdef PLAYER_JETPAC
		if (BUTTON_B(pad) || CONTROLLER_UP(pad)) {
			pvy = SATURATE_N (pvy - PLATER_AY_JETPAC, -PLAYER_VY_JETPAC_MAX);		
			pthrust = 1;
			if (!(thrustct)) fumettos_add ();
					thrustct ++; if (thrustct == 7) thrustct = 0; // so it stays out of phase
		} else thrustct = pthrust = 0;
	#endif

	// Spin

	#ifdef PLAYER_SPINS
		//if (!pvy < 0) pspin = 0;
		if (CONTROLLER_DOWN (pad)) {
			if (ppossee && ABS (pvx) > PLAYER_VX_MIN) {
				pspin = 1; //sfx_play (SFX_BUTT_FALL, SC_PLAYER);
			}
		}
	#endif

	// **********
	// Horizontal
	// **********
	
	// Poll pad

	if (CONTROLLER_LEFT (pad)) {
		/*
		if (!pfixct) {
			#ifdef ENABLE_SLIPPERY
				if (pslips) {
					if (half_life) pvx --;
				} else
			#endif
			pvx -= PLAYER_AX;
			#ifdef ENABLE_WATER
				if (pwater) { if (pvx < -PLAYER_VX_MAX_SWIMMING) pvx = -PLAYER_VX_MAX_SWIMMING; } else
			#endif
			if (pvx < -PLAYER_VX_MAX) pvx = -PLAYER_VX_MAX;
		}
		#ifdef PLAYER_GENITAL
			pfacinglast = pfacingh = CELL_FACING_LEFT;
		#else
			pfacing = CELL_FACING_LEFT;

		#endif*/

		#asm
			// if (!pfixct)
			ld  a, (_pfixct)
			or  a
			jp  nz, _pm_poll_pad_horz_left_skip

		#ifdef ENABLE_SLIPPERY
			ld  a, (pslips)
			or  a
			jp  z, _pm_poll_pad_horz_left_slip_else
			ld  a, (half_life)
			or  a
			jp  z, _pm_poll_pad_horz_left_pvx_set
			ld  hl, _pvx
			dec (hl)
			jp _pm_poll_pad_horz_left_pvx_set
		._pm_poll_pad_horz_left_slip_else
		#endif

			ld  a, (_pvx)
			sub PLAYER_AX
			ld  (_pvx), a
		._pm_poll_pad_horz_left_pvx_set

		#ifdef ENABLE_WATER
			ld  a, (pwater)
			or  a
			jr  z, _pm_poll_pad_horz_left_water_else
			// if (pvx < -PLAYER_VX_MAX_SWIMMING)
			ld  hl, _pvx
			call l_gchar
			ld  de, -PLAYER_VX_MAX_SWIMMING
			ex  de, hl
			call l_lt
			jp  nc, _pm_poll_pad_horz_left_pvx_limited
			ld  a, -PLAYER_VX_MAX_SWIMMING
			ld  (_pvx), a
		._pm_poll_pad_horz_left_water_else
		#endif

			// if (pvx < -PLAYER_VX_MAX)
			ld  hl, _pvx
			call l_gchar
			ld  de, -PLAYER_VX_MAX
			ex  de, hl 
			call l_lt
			jp  nc, _pm_poll_pad_horz_left_pvx_limited
			ld  a, -PLAYER_VX_MAX
			ld  (_pvx), a

		._pm_poll_pad_horz_left_pvx_limited

		._pm_poll_pad_horz_left_skip

			// pfacing = CELL_FACING_LEFT;
			ld  a, CELL_FACING_LEFT			
		#ifdef PLAYER_GENITAL
			ld  (_pfacingh), a
			ld  (_pfacinglast), a
		#else
			ld  (_pfacing), a
		#endif

		#endasm
	} else if (CONTROLLER_RIGHT (pad)) {
		/*
		if (!pfixct) {
			#ifdef ENABLE_SLIPPERY
				if (pslips) {
					if (half_life) pvx ++;
				} else
			#endif
			pvx += PLAYER_AX;
			#ifdef ENABLE_WATER
				if (pwater) { if (pvx > PLAYER_VX_MAX_SWIMMING) pvx = PLAYER_VX_MAX_SWIMMING; } else
			#endif
			if (pvx > PLAYER_VX_MAX) pvx = PLAYER_VX_MAX;

		}
		#ifdef PLAYER_GENITAL		
			pfacinglast = pfacingh = CELL_FACING_RIGHT;		
		#else
			pfacing = CELL_FACING_RIGHT;
		#endif	
		*/

		#asm
			// if (!pfixct)
			ld  a, (_pfixct)
			or  a
			jp  nz, _pm_poll_pad_horz_right_skip

		#ifdef ENABLE_SLIPPERY
			ld  a, (pslips)
			or  a
			jp  z, _pm_poll_pad_horz_right_slip_else
			ld  a, (half_life)
			or  a
			jp  z, _pm_poll_pad_horz_right_pvx_set
			ld  hl, _pvx
			inc (hl)
			jp _pm_poll_pad_horz_right_pvx_set
		._pm_poll_pad_horz_right_slip_else
		#endif

			ld  a, (_pvx)
			add PLAYER_AX
			ld  (_pvx), a
		._pm_poll_pad_horz_right_pvx_set

		#ifdef ENABLE_WATER
			ld  a, (pwater)
			or  a
			jr  z, _pm_poll_pad_horz_right_water_else
			// if (pvx > PLAYER_VX_MAX_SWIMMING)
			ld  hl, _pvx
			call l_gchar
			ld  de, PLAYER_VX_MAX_SWIMMING
			ex  de, hl
			call l_gt
			jp  nc, _pm_poll_pad_horz_right_pvx_limited
			ld  a, PLAYER_VX_MAX_SWIMMING
			ld  (_pvx), a
		._pm_poll_pad_horz_right_water_else
		#endif

			// if (pvx > PLAYER_VX_MAX)
			ld  hl, _pvx
			call l_gchar
			ld  de, PLAYER_VX_MAX
			ex  de, hl 
			call l_gt
			jp  nc, _pm_poll_pad_horz_right_pvx_limited
			ld  a, PLAYER_VX_MAX
			ld  (_pvx), a

		._pm_poll_pad_horz_right_pvx_limited

		._pm_poll_pad_horz_right_skip

			// pfacing = CELL_FACING_RIGHT;
			ld  a, CELL_FACING_RIGHT
		#ifdef PLAYER_GENITAL
			ld  (_pfacingh), a
			ld  (_pfacinglast), a
		#else
			ld  (_pfacing), a
		#endif

		#endasm			
	} else {
		/*
		#ifdef PLAYER_SPINS
			if (!pspin)
		#endif

		#ifdef ENABLE_HOLES
			if (!pholed)
		#endif			
			if (pvx > 0) {
				#ifdef ENABLE_SLIPPERY
					if (pslips) {
						if (half_life) pvx --;
					} else
				#endif
				pvx -= PLAYER_RX; 
				if (pvx < 0) pvx = 0;
			} else if (pvx < 0) {
				#ifdef ENABLE_SLIPPERY
					if (pslips) {
						if (half_life) pvx ++;
					} else
				#endif
				pvx += PLAYER_RX; 
				if (pvx > 0) pvx = 0;
			}
		#ifdef PLAYER_GENITAL
			pfacingh = 0xff;
		#endif		
		*/
		#asm
		#ifdef PLAYER_SPINS
			// if (!pspin)
			ld  a, _pspin
			or  a
			jr  nz, _pm_poll_pad_horz_none_skip
		#endif

		#ifdef ENABLE_HOLES
			// if (!pholed)
			ld  a, _pholed
			or  a
			jr  nz, _pm_poll_pad_horz_none_skip
		#endif

			ld  a, (_pvx)
			or  a
			jr  z, _pm_poll_pad_horz_none_skip
			cp  128
			jp  c, _pm_poll_pad_horz_none_positive

		._pm_poll_pad_horz_none_negative
		#ifdef ENABLE_SLIPPERY
			ld  a, (_pslips)
			or  a
			jr  z, _pm_poll_pad_horz_none_slip_n_else
			ld  a, (_half_life)
			or  a
			jr  z, _pm_poll_pad_horz_none_skip
			ld  hl, _pvx
			inc (hl)
			jp  _pm_poll_pad_horz_none_done
		._pm_poll_pad_horz_none_slip_n_else
		#endif

			ld  a, (_pvx)
			add PLAYER_RX
			jp  m, _pm_poll_pad_horz_none_done
			xor a
			jp  _pm_poll_pad_horz_none_done

		._pm_poll_pad_horz_none_positive
		#ifdef ENABLE_SLIPPERY
			ld  a, (_pslips)
			or  a
			jr  z, _pm_poll_pad_horz_none_slip_p_else
			ld  a, (_half_life)
			or  a
			jr  z, _pm_poll_pad_horz_none_skip
			ld  hl, _pvx
			dec (hl)
			jp  _pm_poll_pad_horz_none_done
		._pm_poll_pad_horz_none_slip_n_else
		#endif

			ld  a, (_pvx)
			sub PLAYER_RX
			jp  p, _pm_poll_pad_horz_none_done
			xor a

		._pm_poll_pad_horz_none_done
			ld  (_pvx), a

		._pm_poll_pad_horz_none_skip
		#ifdef PLAYER_GENITAL
			// pfacingh = 0xff
			ld  a, 0xff
			ld  (_pfacingh), a
		#endif
		#endasm
	}

	// Move

	#asm
			ld  de, (_px)

			// if (pgotten) px += pgtmx;
			ld  a, (_pgotten)
			or  a
			jr  z, _pm_horz_move_pgotten_done
			ld  hl, _pgtmx
			call l_gchar
			add hl, de
			ex  de, hl
		._pm_horz_move_pgotten_done

			// px += pvx;		
			ld  hl, _pvx
			call l_gchar
			add hl, de
			ld  (_px), hl

			//if (px < (4<<FIX_BITS)) px = 4<<FIX_BITS;
			ld  de, 64
			ex  de, hl
			call l_lt
			jr  nc, _pm_horz_move_lefb_done
			ld  de, 64
			ld  (_px), de
			jp  _pm_horz_move_rigb_done
		._pm_horz_move_lefb_done

			// else if (px > (PRX_MAX<<FIX_BITS)) px = PRX_MAX<<FIX_BITS;
			ld  hl, PRX_MAX_FIX_BITS
			call l_gt
			jr  nc, _pm_horz_move_rigb_done
			ld  de, PRX_MAX_FIX_BITS
			ld  (_px), de
		._pm_horz_move_rigb_done

			// prx = px >> FIX_BITS;
			// de <- px
			ld  l, 4
			call l_asr
			ld  a, l
			ld  (_prx), a
	#endasm

	// Collision

	#include "engine/playermods/collision_horz_assembly.h"

	// Once the player has moved, center point detections

	#ifdef PLAYER_ENABLE_CENTER_DETECTIONS
		#asm

			/*
			cx1 = cx2 = (prx + 4) >> 4;
			cy1 = cy2 = (pry + 8) >> 4;
			cm_two_points ();
			*/
			
				ld  a, (_prx)
				add 4
				srl a
				srl a
				srl a
				srl a
				ld  (_cx1), a
				ld  (_cx2), a

				ld  a, (_pry)
				add 8
				srl a
				srl a
				srl a
				srl a
				ld  (_cy1), a
				ld  (_cy2), a

				call _cm_two_points

			#ifdef EVIL_TILE_CENTER
				// evil_tile_hit = (at1 & EVIL_BIT);
				ld  a, (_at1)
				and EVIL_BIT
				ld  (_evil_tile_hit), a
			#endif

			#ifdef ENABLE_WATER
				/*
				rda = pwater;
				pwater = (at1 & WATER_BIT);
				if (pwater != rda) //sfx_play (SFX_FLUSH, SC_PLAYER);
				if (!pwater && rda) pvy = -PLAYER_VY_OUT_OF_WATER;
				*/

				ld  a, (_pwater)
				ld  c, a
				ld  a, (_at1)
				and WATER_BIT
				ld  (_pwater), a

				cp  c
				jr  z, _pm_center_water_nosound
				#endasm
					SFX_PLAY (SFX_FLUSH);
				#asm
			._pm_center_water_nosound

				or  a
				jr  nz, _pm_center_water_exit_done
				xor a
				or  c
				jr  z, _pm_center_water_exit_done

				ld  a, -PLAYER_VY_OUT_OF_WATER
				ld  (_pvy), a
			._pm_center_water_exit_done
			#endif
		#endasm

		#ifdef ENABLE_TILE_GET
			if (at1 & TILE_GET_BIT) {

				_x = cx1; _y = cy1 - 1, _t = TILE_GET_CLEAR_TILE;
				set_map_tile ();
				SFX_PLAY (SFX_COIN);

				#ifdef TILE_GET_COUNT_ON_FLAG
					flags [TILE_GET_COUNT_ON_FLAG] ++;
				#else 
					ptile_get_ctr ++;
					#ifdef TILE_GET_LIFE_REFILL
						if (ptile_get_ctr == TILE_GET_LIFE_REFILL) {
							ptile_get_ctr = 0; 
							plife ++;
							#ifdef ENABLE_TIMED_MESSAGE			
								timed_message_print (TIMED_MESSAGE);
								SCREEN_UPDATE;
							#endif			
							SFX_PLAY (SFX_ITEM);
						}
					#endif
				#endif	

				#ifdef PERSISTENT_TILE_GET
					gpit = tile_got_offset + (cy1 - 1);
					rda = tile_got [gpit];
					tile_got [gpit] = rda | bitmask [cx1 >> 1];
				#endif
			}
		#endif

	#endif

	// Evil tile (continued)

	#ifdef ENABLE_EVIL_TILE
		if (evil_tile_hit) {
			#ifdef PLAYER_SPINS
				pspin = 0;
			#endif
			#ifdef PLAYER_JUMPS
				pjustjumped = 0;
			#endif
			#ifdef EVIL_TILE_ON_FLOOR
				pvy = -PLAYER_V_REBOUND; 
			#endif
			#ifdef EVIL_TILE_MULTI
				px = pcx; py = pcy;
			#endif
			#if defined (EVIL_TILE_CENTER) && !defined (PLAYER_DIE_AND_RESPAWN) && !defined (PLAYER_GENITAL)
				px = pcx; py = pcy;
				pvy = -PLAYER_V_REBOUND_MULTI;
			#endif
			#if defined (EVIL_TILE_CENTER) && !defined (PLAYER_DIE_AND_RESPAWN) && defined (PLAYER_GENITAL)
				px = pcx; py = pcy;
				if (ABS (pvx) > ABS (pvy)) pvx = ADD_SIGN (-pvx, PLAYER_V_REBOUND_MULTI);
				else pvy = ADD_SIGN (-pvy, PLAYER_V_REBOUND_MULTI);
			#endif

			if (
				#ifdef PLAYER_FLICKERS
					!pflickering
				#else				
					!phit
				#endif
			) {
				pwashit = 1;
			}
			#if defined (PLAYER_DIE_AND_RESPAWN)
				else {
					px = pcx; py = pcy;
					pvy = -PLAYER_V_REBOUND_MULTI;
				}
			#endif
		}
	#endif	

	// Hidden

	#ifdef ENABLE_ESPECTROS
		cx1 = cx2 = (prx + 4) >> 4;
		cy1 = cy2 = (pry + 8) >> 4;
		cm_two_points ();
		phidden = (ABS (pvy) < PLAYER_VY_MIN) && (ABS (pvx) < PLAYER_VX_MIN) && (at1 & PLAYER_HIDES_BIT);
	#endif

	// Spinning

	#ifdef PLAYER_SPINS
		if (!pvx && ppossee) pspin = 0;
	#endif

	// Can't remember

	#ifdef PLAYER_TURRET
		if (pfixct) pfixct --;
	#endif

	// Float

	#ifdef PLAYER_FLOATS	
		if (!ppossee && !pj && (CONTROLLER_DOWN (pad))) {
			if (!pfloat) pvy = 0;
			pfloat = 1;
		} else pfloat = 0;
	#endif

	// Launch script

	#ifdef SCRIPTING_ON
		#ifdef ACTION_KEY_DOWN
			if (CONTROLLER_DOWN (pad)) {
				if (down_debounce == 0) {
					#ifdef FIRE_SCRIPT_WITH_ANIMATION
						if (ppossee){
							player_reset_movement ();
							use_ct = 1;
						} 
					#else
						game_run_fire_script ();
						if (commands_executed) pfiring = 1;
					#endif
				}
				down_debounce = 1;
			} else down_debounce = 0;
		#endif
	#endif

	// PAD B Stuff!
	// In order:
	// 1. containers
	// 2. scripting
	// 3. fire

	// If you are using "FIRE_SCRIPT_WITH_ANIMATION", well...
	// that's incompatible with PLAYER_CAN_FIRE. Unless you work it out.

	// For genital games you *should* change PAD_B to PAD_A

	if (BUTTON_A(pad)) {
		#ifdef ENABLE_CONTAINERS
			commands_executed = containers_get = 0;
			if (!pfiring) {
				containers_do ();
				#ifdef CONTAINERS_HAS_GOT_FLAG			
					flags [CONTAINERS_HAS_GOT_FLAG] = containers_get;
				#endif
				if (containers_get) {
					#ifdef FIRE_SCRIPT_WITH_ANIMATION
						player_reset_movement ();
						use_ct = 1;
					#else
						rda = flags [PLAYER_INV_FLAG];
						flags [PLAYER_INV_FLAG] = flags [containers_get];
						flags [containers_get] = rda;
					#endif
					#ifdef CONTAINER_ACTION_STOPS_CHECKS
						pfiring = 1;
					#endif
				}
			}
		#endif

		#ifdef SCRIPTING_ON
			#ifdef ACTION_KEY_FIRE
				if (!pfiring) {
					#ifdef FIRE_SCRIPT_WITH_ANIMATION
						if (ppossee) {
							player_reset_movement ();
							use_ct = 1;
						} 
					#else
						game_run_fire_script ();
						if (commands_executed) pfiring = 1;
					#endif
				}
			#endif
		#endif

		#ifdef PLAYER_PUAS
			if (!pfiring) {
				//sfx_play (SFX_SHOOT, SC_PLAYER);
				puas_create ();
			}
		#endif

		#ifdef PLAYER_CAN_FIRE
			if (!pfiring) {
				bullets_fire ();
				#ifdef PLAYER_TURRET		
					pfixct = TURRET_FRAMES;
				#endif	
			}
		#endif

		#ifdef ENABLE_FABOLEES
			if (!pfiring) fabolee_new ();
		#endif

		#ifdef PLAYER_PUNCHES
			if (0 == hitter_frame && !pfiring) {
				hitter_frame = 1;
			}
		#endif

		pfiring = 1;
	} else pfiring = 0;

	/*
	#ifdef PLAYER_CAN_FIRE
		if (BUTTON_A (pad)) {
			if (!pfiring) bullets_fire ();
			pfiring = 1;
	#ifdef PLAYER_TURRET		
			pfixct = TURRET_FRAMES;
	#endif		
		} else pfiring = 0;
	#endif	
	*/

	// Butt

	#ifdef PLAYER_BUTT
		if (ppossee || phit 
		#ifdef ENABLE_WATER
			|| pwater
		#endif
		) pbutt = 0; else {
			if (BUTTON_B(pad)) {
				if (!pbutt) {
					pbutt = 1; pj = 0;
					//sfx_play (SFX_BUTT_FALL, SC_PLAYER);			
				}
			}
		}
	#endif	

	// Hitter todo
	/*
	if ((BUTTON_B(pad)) && !hitter_on && pstatespradder) {
		hitter_on = 1; hitter_frame = 0;
		//sfx_play (SFX_SHOOT, SC_PLAYER);
	}
	*/
	
	// Solve facing
	#ifdef PLAYER_GENITAL	
		#ifdef GENITAL_HORIZONTAL_PREFERED
			if (pfacingh != 0xff) pfacing = pfacingh; else if (pfacingv != 0xff) pfacing = pfacingv;
		#else
			if (pfacingv != 0xff) pfacing = pfacingv; else if (pfacingh != 0xff) pfacing = pfacingh;
		#endif
	#endif

	// Sprite cell selection is usually pretty custom...
	#include "my/player_cell_selection.h"

	spr_on [SPR_PLAYER] = (pflickering == 0) || half_life;
	spr_x [SPR_PLAYER] = prx - 4;
	spr_y [SPR_PLAYER] = pry;
	spr_next [SPR_PLAYER] = sprite_cells [psprid];

	#ifdef ENABLE_PUMPKIN
		// CUSTON {
		// The pumpkin!
		if (flags [ONLY_ONE_OBJECT_FLAG]) {
			#asm
				ld  a, 1
				ld  (_spr_on + 4), a
				ld  a, (_spr_x + SPR_PLAYER)
				ld  c, a
				ld  a, (_pfacing)
				or  a
				jr  nz, _add_pumpkin_facing_left
			
			._add_pumpkin_facing_right
				ld  a, c
				sub 4
				jr  _add_pumpkin_facing_done

			._add_pumpkin_facing_left
				ld  a, c
				add 4

			._add_pumpkin_facing_done
				cp  236
				jr  c, _add_pumpkin_set_x

				ld  a, c

			._add_pumpkin_set_x
				ld  (_spr_x + 4), a

				ld  a, (_pry)
				#ifdef CPC
					sub 12
				#endif
				#ifdef SPECCY
					sub 8
				#endif
				cp  16
				jr  nc, _add_pumpkin_set_y

				ld  a, 16

			._add_pumpkin_set_y
				ld (_spr_y + 4), a
			#endasm

			spr_next [4] = ss_pumpkin;
		} else spr_on [4] = 0;
		// } END_OF_CUSTOM	
	#endif

}
