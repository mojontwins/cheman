// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void enems_load (void) {
	#ifdef ENEMS_FORMAT_UNPACKED	
		// Each screen holds 3 enemies, each enemy takes 4 bytes, so:
		#asm
			// gp_gen = enems + (n_pant << 3) + (n_pant << 2);
			ld  hl, (_n_pant)
			ld  h, 0
			add hl, hl
			add hl, hl 
			ld  d, h 
			ld  e, l
			add hl, hl
			add hl, de
			ld  de, _enems
			add hl, de
			ld  (_gp_gen), hl
		#endasm

	// TODO: Translate
	#elif defined (ENEMS_FORMAT_COMPACTED)
		// There's a nice index
		rdc = n_pant << 1;
		rda = *(enems + rdc); rdb = *(enems + rdc + 1);
		if ((rda | rdb) != 0) {
			gp_gen = (unsigned char *) (enems + ((rdb << 8) | rda));
			rdct = 1;
		} else rdct = 0;
	#endif

	#if defined (PERSISTENT_DEATHS) || defined (PERSISTENT_ENEMIES)
		#asm
			ld  a, (_n_pant)
			ld  b, a
			add a
			add b
			ld  (_enoffs), a
			ld  (_rdc), a
		#endasm
	#endif

	#asm
		// Big loop!
		xor a
		ld  (_gpit), a
		ld  b, a
	._enems_load_big_loop

		// Loop iterator (gpit) is also in register B

		#ifdef ENEMS_FORMAT_COMPACTED
				ld  a, (_rdct)
				or  a
				jr  nz _enems_load_do
			._enems_load_skip
				ld  d, 0
				ld  e, b
				ld  hl, _en_t
				add hl, de
				ld  (hl), d
				jp  _enems_load_continue
		#endif

		#if defined (ENEMS_CAN_DIE) && defined (PERSISTENT_DEATHS)
			#ifdef ENABLE_ESPECTROS
			#else
				// Kill enemy

				ld  de, (_rdc)
				ld  d, 0
				ld  hl, _ep_killed
				add hl, de
				ld  a, (hl)
				or  a
				jp z, _enems_load_do
				ld  d, 0
				ld  e, b
				ld  hl, _en_t
				add hl, de
				ld  (hl), d
				ld  hl, (_gp_gen)
				ld  de, 4
				add hl, de
				ld  (_gp_gen), hl
				jp  _enems_load_continue
			#endif
		#endif

		._enems_load_do

			// Format is T YX1 YX2 P

			// Read type
			ld  hl, (_gp_gen)
			ld  a, (hl)
			inc hl
			ld  (_rda), a
			
			#ifdef ENEMS_FORMAT_COMPACTED
				or  a
				jr  z, _enems_load_skip
			#endif

			#ifdef ENABLE_ESPECTROS
				push hl
				ld  de, (_rdc)
				ld  d, 0
				ld  hl, _ep_killed
				add hl, de 
				ld  a, (hl)
				or  a
				jp  nz, _enems_load_no_espectro

				// Change type: dead = espectro
				ld  a, 0x60
				ld  (_rda), a
			._enems_load_no_espectro
				pop hl
			#endif

			#ifdef PERSISTENT_ENEMIES
				// YX1
				ld  a, (hl)
				inc hl
				ld  c, a
				sla a
				sla a
				sla a
				sla a
				ld (__en_x1), a
				ld  a, c
				and 0xf0
				ld (__en_y1), a

				// YX2
				ld  a, (hl)
				inc hl
				ld  c, a
				sla a
				sla a
				sla a
				sla a
				ld (__en_x2), a
				ld  a, c
				and 0xf0
				ld (__en_y2), a

				// Attribute
				ld  a, (hl)
				inc hl
				ld  (_rdb), a			
			#else
				// YX1
				ld  a, (hl)
				inc hl
				ld  c, a
				sla a
				sla a
				sla a
				sla a
				ld (__en_x), a
				ld (__en_x1), a
				ld  a, c
				and 0xf0
				ld (__en_y), a
				ld (__en_y1), a

				// YX2
				ld  a, (hl)
				inc hl
				ld  c, a
				sla a
				sla a
				sla a
				sla a
				ld (__en_x2), a
				ld  a, c
				and 0xf0
				ld (__en_y2), a

				// Attribute
				ld  a, (hl)
				inc hl
				ld  (_rdb), a
			#endif

			// Update gp_gen
			ld  (_gp_gen), hl

			#ifdef PERSISTENT_ENEMIES
				// Retrieve stored X, Y
				ld  de, (_rdc)
				ld  d, 0
				ld  hl, _ep_x
				add hl, de 
				ld  a, (hl)
				ld  (__en_x), a
				ld  hl, _ep_y
				add hl, de
				ld  a, (hl)
				ld  (__en_y), a
			#endif

			// Store type
			ld  e, b
			ld  d, 0
			ld  hl, _en_t
			add hl, de
			ld  a, (_rda)
			ld  (hl), a

			// Save enem type
			ld  c, a

			// Base sprite
			and 0x0f
			#ifdef ENEMS_WITH_FACING
				sla a
				sla a
			#else
				sla a
			#endif
			add ENEMS_CELL_BASE
			ld  hl, _en_s
			add hl, de
			ld  (hl), a

			// State and life
			xor a
			ld  (__en_state), a
			ld  a, ENEMS_GENERAL_LIFE
			ld  e, b
			ld  d, 0
			ld  hl, _en_life
			add hl, de
			ld  (hl), a

			#ifdef SPECCY
				// Assign default clipping rectangle
				#endasm
					ensClipRects [gpit].row_coord = SCR_Y + 1;
					ensClipRects [gpit].col_coord = SCR_X;
					ensClipRects [gpit].height = 22;
					ensClipRects [gpit].width = 32;
				#asm
			#endif

			// Do extra assignations based upon type
			._enems_load_t_assignations
				ld  a, c 
				and 0xf0
				
				// Jump table
				._enems_load_t_assignations_jt

				#ifdef ENABLE_LINEAR
					cp  0x10
					jp  z, _enems_load_t_10
					cp  0x20
					jp  z, _enems_load_t_20
				#endif

				#if defined (ENABLE_FANTY) || defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY) || defined (ENABLE_TIMED_FANTY)
					cp  0x30
					jp  z, _enems_load_t_30
				#endif

				#if defined ENABLE_CATACROCK
					cp  0x40
					jp  z, _enems_load_t_40
				#endif

				#if defined ENABLE_GENERATONIS
					cp  0x50
					jp  z, _enems_load_t_50
				#endif

				#if defined ENABLE_ESPECTROS
					cp  0x60
					jp  z, _enems_load_t_60
				#endif

				#if defined ENABLE_TYPE7
					cp  0x70
					jp  z, _enems_load_t_70
				#endif

				#if defined ENABLE_STEADY_SHOOTER
					cp  0x80
					jp  z, _enems_load_t_80
				#endif

				#if defined ENABLE_MONOCOCO
					cp  0x90
					jp  z, _enems_load_t_90
				#endif

				#if defined (ENABLE_WALKER) || defined (ENABLE_PRECALC_PEZON)
					cp  0xa0
					jp  z, _enems_load_t_a0
				#endif

				#if defined (ENABLE_GYROSAW) || defined (ENABLE_SAW)
					cp  0xb0
					jp  z, _enems_load_t_b0
				#endif

				#if defined (ENABLE_LEMMINGS)
					cp  0xc0
					jp  z, _enems_load_t_c0
				#endif

					jp  _enems_load_t_assignations_done

				#ifdef ENABLE_LINEAR
					._enems_load_t_10
					._enems_load_t_20
						#ifdef PERSISTENT_ENEMIES
							ld  de, (_rdc)
							ld  d, 0
							#ifdef PERSISTENT_ENEMIES_PACKED
								ld  hl, _ep_myx
								add hl, de
								ld  a, (hl)
								ld  c, a
								and 8
								jr  nz, _enems_load_t_p_pep_x_n
								ld  a, c
								and 7
								jr  _enems_load_t_p_pep_x
							._enems_load_t_p_pep_x_n
								ld  a, c 
								and 7
								neg
							._enems_load_t_p_pep_x
								ld  (__en_mx), a

								ld  a, c
								srl a
								srl a
								srl a
								srl a
								ld  c, a
								and 8
								jr  nz, _enems_load_t_p_pep_y_n
								ld  a, c
								and 7
								jr  _enems_load_t_p_pep_done
							._enems_load_t_p_pep_y_n
								ld  a, c
								and 7
								neg
							._enems_load_t_p_pep_done
								ld (__en_my), a
							#else
								ld hl, _ep_mx
								add hl, de
								ld  a, (hl)
								ld  (__en_mx), a
								ld hl, _ep_my
								add hl, de
								ld  a, (hl)
								ld  (__en_my), a
							#endif
						#else

						._enems_load_t_10_mx
							ld  a, (__en_x2)
							ld  c, a
							ld  a, (__en_x1)
							cp  c
							jr  c, _enems_load_t_10_x1_smaller
							jr  z, _enems_load_t_10_x1_same
						._enems_load_t_10_x1_bigger
							ld  a, (_rdb)
							neg a
							jr _enems_load_t_10_mx_done
						._enems_load_t_10_x1_same
							xor a
							jr _enems_load_t_10_mx_done
						._enems_load_t_10_x1_smaller
							ld  a, (_rdb)
						._enems_load_t_10_mx_done
							ld (__en_mx), a

						._enems_load_t_10_my
							ld  a, (__en_y2)
							ld  c, a
							ld  a, (__en_y1)
							cp  c
							jr  c, _enems_load_t_10_y1_smaller
							jr  z, _enems_load_t_10_y1_same
						._enems_load_t_10_y1_bigger
							ld  a, (_rdb)
							neg a
							jr _enems_load_t_10_my_done
						._enems_load_t_10_y1_same
							xor a
							jr _enems_load_t_10_my_done
						._enems_load_t_10_y1_smaller
							ld  a, (_rdb)
						._enems_load_t_10_my_done
							ld (__en_my), a
						#endif

						
							// y1 should always be smaller!
							ld  a, (__en_y1)
							ld  c, a
							ld  a, (__en_y2)
							cp  c
							jp  nc, _enems_load_t_10_not_swap_yX
							ld  (__en_y1), a
							ld  a, c
							ld  (__en_y2), a
						._enems_load_t_10_not_swap_yX

						#ifdef SPECCY
							// x1 should always be smaller!
							ld  a, (__en_x1)
							ld  c, a
							ld  a, (__en_x2)
							cp  c
							jp  nc, _enems_load_t_10_not_swap_xX
							ld  (__en_x1), a
							ld  a, c
							ld  (__en_x2), a
						._enems_load_t_10_not_swap_xX


						// Assign Custom clipping rectangle
						push bc
						#endasm
							// CUSTOM {
							
							ensClipRects [gpit].row_coord = (_en_y1 >> 3) - 2;
							ensClipRects [gpit].col_coord = (_en_x1 >> 3);
							ensClipRects [gpit].height = ((_en_y2 - _en_y1) >> 3) + 3;
							ensClipRects [gpit].width = ((_en_x2 - _en_x1) >> 3) + 2;
							
							// END_OF_CUSTOM 
						#asm
						pop bc

						#endif
						

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_FANTY
					._enems_load_t_30	
						// FIX_BITS is 4. This makes this a bit less readable but fuck you
						#ifdef FANTY_REPOSITION_NONETHELESS
							ld  a, (__en_x1)
						#else
							ld  a, (__en_x)
						#endif
						ld  h, 0
						ld  l, a
						add hl, hl
						add hl, hl
						add hl, hl
						add hl, hl
						ld  a, l
						ld  (__enf_x), a
						ld  a, h
						ld  (__enf_x+1), a

						#ifdef FANTY_REPOSITION_NONETHELESS
							ld  a, (__en_y1)
						#else
							ld  a, (__en_y)
						#endif
						ld  h, 0
						ld  l, a
						add hl, hl
						add hl, hl
						add hl, hl
						add hl, hl
						ld  a, l
						ld  (__enf_y), a
						ld  a, h
						ld  (__enf_y+1), a

						xor a
						ld  (__enf_vy), a
						ld  (__enf_vx), a

						ld  a, FANTY_TIMER_BASE
						ld  e, b
						ld  d, 0
						ld  hl, _fanty_timer
						add hl, de
						ld  (hl), a

						jp _enems_load_t_assignations_done
				#elif defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY)						
					._enems_load_t_30	
						#ifdef PERSISTENT_ENEMIES
							#ifdef FANTY_REPOSITION_NONETHELESS
								ld  a, (__en_x1)
								ld  (__en_x), a
								ld  a, (__en_y1)
								ld  (__en_y), a
							#endif							
						#endif

						xor a
						ld  (__en_mx), a
						ld  (__en_my), a

						jp _enems_load_t_assignations_done
				#elif defined (ENABLE_PRECALC_TIMED_FANTY)
					._enems_load_t_30
						#ifdef FANTY_REPOSITION_NONETHELESS
							ld  a, (__en_x1)
							ld  (__en_x), a
							ld  a, (__en_y1)
							ld  (__en_y), a
						#endif

						ld  a, FANTY_TIMER_BASE
						ld  e, b
						ld  d, 0
						ld  hl, _fanty_timer
						add hl, de
						ld  (hl), a

						xor a
						ld  (__en_mx), a
						ld  (__en_my), a
						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_CATACROCK
					._enems_load_t_40
						#ifdef PERSISTENT_ENEMIES
							ld  a, (__en_y1)
							ld  (__en_y), a
						#endif

						ld  a, (_rdb)
						sla a
						sla a
						sla a
						sla a
						sla a
						ld  (__en_mx), a  	; CATACROCK_COUNTER
						ld  (__en_my), a 	; CATACROCK_WAIT

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_GENERATONIS
					._enems_load_t_50
						#ifdef PERSISTENT_ENEMIES
							ld  a, (__en_x1)
							ld  (__en_x), a
							ld  a, (__en_y1)
							ld  (__en_y), a
						#endif

						ld  d, 0
						ld  e, b
						ld  hl, _en_s
						add hl, de
						ld  a, (hl)
						and 0x0f
						sla a
						sla a
						ld  (hl), a

						ld  a, (_rdb)
						sla a
						sla a
						sla a
						sla a
						sla a
						add 31
						ld  (__en_x2), a 	; GENERATONI_WAIT
						xor a
						ld  (__en_y2), a 	; GENERATONI_COUNTER						

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_ESPECTROS
					._enems_load_t_60
						// FIX_BITS is 4. This makes this a bit less readable but fuck you
						ld  a, (__en_x1)
						ld  h, 0
						ld  l, a
						add hl, hl
						add hl, hl
						add hl, hl
						add hl, hl
						ld  a, l
						ld  (__enf_x), a
						ld  a, h
						ld  (__enf_x+1), a

						ld  a, (__en_y1)
						ld  h, 0
						ld  l, a
						add hl, hl
						add hl, hl
						add hl, hl
						add hl, hl
						ld  a, l
						ld  (__enf_y), a
						ld  a, h
						ld  (__enf_y+1), a

						xor a
						ld  (__enf_vy), a
						ld  (__enf_vx), a
						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_TYPE7
					._enems_load_t_70
						#ifdef TYPE7_WITH_GENERATOR
							ld  e, b
							ld  d, 0
							ld  hl, _en_gen_life
							add hl, de
							ld  a, TYPE7_GENERATOR_LIFE
							ld  (hl), a
							ld  hl, _en_gen_washit
							add hl, de
							xor a
							ld  (hl), a
						#endif

						push bc
						#endasm
						// Needed. TYPE7_SPAWN_TIME may contain C
						_en_ct = TYPE7_SPAWN_TIME;
						#asm	
						pop bc					

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_STEADY_SHOOTER
					._enems_load_t_80
						// TODO: This snippet:
						push bc
						#endasm
							rda = ADD_SIGN2 (_en_x2, _en_x1, 1);
							if (rda) 
								_STEADY_SHOOTER_DIRECTION = rda + 1; 
							else 
								_STEADY_SHOOTER_DIRECTION = ADD_SIGN2 (_en_y2, _en_y1, 1) + 2;
						#asm
						pop bc

						ld  a, (_rdb)
						ld  (__en_mx), a 	; STEADY_SHOOTER_WAIT
						ld  (__en_ct), a

						// Draw it as a tile
						ld  a, (__en_x)
						srl a
						srl a
						srl a
						srl a
						ld  (__x), a
						ld  a, (__en_y)
						srl a
						srl a
						srl a
						srl a
						dec a
						ld  (__y), a
						ld  a, (__en_my) 	; STEADY_SHOOTER_DIRECTION
						add STEADY_SHOOTER_BASE_TILE
						ld  (__t), a

						call _set_map_tile

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_MONOCOCO
					._enems_load_t_90
						call rand8 ; -> L
						ld  a, l
						and 15
						ld  c, a
						ld  a, MONOCOCO_BASE_TIME_HIDDEN
						sub c

						jp _enems_load_t_assignations_done
				#elif defined (ENABLE_MONOCOCO_SIMPLE)
					._enems_load_t_90
						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_WALKER
						ld  a, 4
						ld  e, b
						ld  d, 0
						ld  hl, _en_facing
						add hl, de
						ld  (hl), a
					._enems_load_t_a0
						jp _enems_load_t_assignations_done
				#elif defined ENABLE_PRECALC_PEZON
					._enems_load_t_a0
						ld  a, (_rdb)
						sla a
						sla a 
						sla a
						add PEZON_WAIT

						ld  (__en_y2), a 	; PEZON_MAX_TIME
						ld  (__en_mx), a 	; PEZON_TIMER

						jp _enems_load_t_assignations_done
				#endif
	
				#ifdef ENABLE_GYROSAW
					._enems_load_t_b0
						xor a
						ld  (__en_mx), a 	; GYROSAW_COUNTER
						ld  a, (_rbd)
						ld  (__en_my), a 	; GYROSAW_DIRECTION

						#ifdef PERSISTENT_ENEMIES
							ld  a, (__en_x1)
							ld  (__en_x), a
							ld  a, (__en_y1)
							ld  (__en_y), a
						#endif

						jp _enems_load_t_assignations_done
				#elif defined ENABLE_SAW
					._enems_load_t_b0
					
						; TODO
						push bc
						#endasm
							// It will emerge upwards/downwards / leftwards/rightwards depending on (en_t [gpit] & 0x0f):
							// 0 is negative (up/left); 2 is positive (down/right). So type can be 0xB0 or 0xB2.
							_SAW_EMERGING_DIRECTION = (en_t [gpit] & 0x0f) - 1;
							
							// Orientation / direction of momement when the saw is OUT is defined by the trajectory in "ponedor.exe".
							rda = (_en_x1 == _en_x2);
							_SAW_MOVING_DIRECTION = (rda) ? 
								SGNC (_en_y2, _en_y1, SAW_V_DISPL) : 
								SGNC (_en_x2, _en_x1, SAW_V_DISPL);
							SAW_ORIENTATION [gpit] = rda;
							
							_en_ct = SAW_EMERGING_STEPS;
						#asm
						pop bc

						jp _enems_load_t_assignations_done
				#endif

				#ifdef ENABLE_LEMMINGS
					._enems_load_t_c0
						jp _enems_load_t_assignations_done
				#endif


			._enems_load_t_assignations_done
			// End of extra assignations based upon type

			// And finally
			xor a
			ld  e, b
			ld  d, 0
			ld  hl, _en_washit
			add hl, de
			ld  (hl), a
			ld  hl, _en_dying
			add hl, de
			ld  (hl), a

			#ifdef TYPE7_WITH_GENERATOR
				ld  hl, _en_gen_dying
				add hl, de
				ld  (hl), a
			#endif

			#ifdef ENEMS_UPSIDE_DOWN
				ld (_en_ud), a
			#endif

		._enems_load_continue
			#if defined (PERSISTENT_DEATHS) || defined (PERSISTENT_ENEMIES)
				ld  a, (_rdc)
				inc a
				ld  (_rdc), a
			#endif

			call _enems_restore_vals

			// gpit ++
			inc b
			ld  a, b
			ld  (_gpit), a
			cp  3
			jp  nz, _enems_load_big_loop
	#endasm

	// Dynamic sprite sizes. TODO: Translate into assembly
	#ifdef CPC
			/*
		for (gpit = 0; gpit < 3; gpit ++) {
			gpjt = gpit + SPR_ENEMS_BASE; 
			rdt = en_t [gpit] >> 4;	
			rds = dss_msb_ox [rdt];

*((unsigned char *) (0xE650+gpit)) = en_t [gpit];			
*((unsigned char *) (0xE660+gpit)) = rdt;
*((unsigned char *) (0xE670+gpit)) = rds;

			if (rds == 0xff) {
				rdt = en_t [gpit] & 0xf;
*((unsigned char *) (0xE680+gpit)) = 0x69;
				sp_sw [gpjt].cox = dss_lsb_ox [rdt]; 
				sp_sw [gpjt].coy = dss_lsb_oy [rdt];
				sp_sw [gpjt].invfunc = dss_lsb_invfunc [rdt];
				sp_sw [gpjt].updfunc = dss_lsb_updfunc [rdt];
			} else {
				sp_sw [gpjt].cox = rds; 
				sp_sw [gpjt].coy = dss_msb_oy [rdt];
				sp_sw [gpjt].invfunc = dss_msb_invfunc [rdt];
				sp_sw [gpjt].updfunc = dss_msb_updfunc [rdt];
			}
		}
		*/

		#asm
			ld  b, 0		// 3 enemies
		dyn_sprs_loop:
			push bc
			ld  a, b
			add a, SPR_ENEMS_BASE
			ld  (_gpjt), a

			ld  e, b
			ld  d, 0
			ld  hl,_en_t
			add hl, de
			ld  a, (hl) 	// A = en_t [gpit];
			srl a 
			srl a 
			srl a 
			srl a 
			ld  (_rdt), a

			ld  e, a
			ld  d, 0
			ld  hl, _dss_msb_ox
			add hl, de
			ld  a, (hl)
			ld  (_rds), a

			or a
			jp z, dyn_sprs_continue

			cp 0xff
			jr  z, dyn_sprs_lsb
			jr  dyn_sprs_msb

		dyn_sprs_calc_struct:
			ld  hl, (_gpjt)
			ld  h, 0
			add hl, hl 		// * 2
			add hl, hl 		// * 4
			add hl, hl 		// * 8
			add hl, hl 		// * 16
			ld  de, _sp_sw
			add hl, de
			ret

		dyn_sprs_msb:
			call dyn_sprs_calc_struct
			// HL -> sp_sw [gpjt]

			// sp_sw [gpjt].cox = rds;
			ld  bc, 6		// cox is offset 6
			add hl, bc 		// hl -> sp_sw [gpjt].cox
			ld  a, (_rds)
			ld  (hl), a

			// sp_sw [gpjt].coy = dss_msb_oy [rdt];
			inc hl 			// coy is offset 7 (next)
			ex  de, hl

			ld  bc, (_rdt)
			ld  b, 0
			ld  hl, _dss_msb_oy
			add hl, bc
			ld  a, (hl)
			
			ld  (de), a

			// sp_sw [gpjt].invfunc = dss_msb_invfunc [rdt];
			call dyn_sprs_calc_struct
			// HL -> sp_sw [gpjt]
			ld  bc, 12		// invfunc is offset 12
			add hl, bc 		// hl -> sp_sw [gpjt].invfunc

			ex  de, hl

			ld  a, (_rdt)
			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _dss_msb_invfunc
			add hl, bc
			
			ldi 			// Copy first byte
			ldi 			// Copy second byte

			// sp_sw [gpjt].updfunc = dss_msb_updfunc [rdt];
			ld  a, (_rdt)
			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _dss_msb_updfunc
			add hl, bc

			// HL -> dss_msb_updfunc [rdt]
			// DE -> sp_sw [gpjt].updfunc right away!
			ldi
			ldi

			jp  dyn_sprs_continue

		dyn_sprs_lsb:
			// rdt = en_t [gpit] & 0xf;
			ld  e, b
			ld  d, 0
			ld  hl,_en_t
			add hl, de
			ld  a, (hl) 	// A = en_t [gpit];
			and 0xf
			ld  (_rdt), a

			// sp_sw [gpjt].cox = dss_lsb_ox [rdt];
			call dyn_sprs_calc_struct
			ld  bc, 6		// cox is offset 6
			add hl, bc 		// hl -> sp_sw [gpjt].cox
			ex  de, hl

			ld  bc, (_rdt)
			ld  b, 0
			ld  hl, _dss_lsb_ox
			add hl, bc
			ld  a, (hl)

			ld  (de), a

			// sp_sw [gpjt].coy = dss_lsb_oy [rdt];
			inc de 			// coy is offset 7 (next)

			ld  bc, (_rdt)
			ld  b, 0
			ld  hl, _dss_lsb_oy
			add hl, bc
			ld  a, (hl)
			
			ld  (de), a

			// sp_sw [gpjt].invfunc = dss_lsb_invfunc [rdt];
			call dyn_sprs_calc_struct
			// HL -> sp_sw [gpjt]
			ld  bc, 12		// invfunc is offset 12
			add hl, bc 		// hl -> sp_sw [gpjt].invfunc

			ex  de, hl

			ld  a, (_rdt)
			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _dss_lsb_invfunc
			add hl, bc

			ldi 			// Copy first byte
			ldi 			// Copy second byte

			// sp_sw [gpjt].updfunc = dss_lsb_updfunc [rdt];
			ld  a, (_rdt)
			sla a
			ld  c, a
			ld  b, 0
			ld  hl, _dss_lsb_updfunc
			add hl, bc

			// HL -> dss_msb_updfunc [rdt]
			// DE -> sp_sw [gpjt].updfunc right away!
			ldi
			ldi

		dyn_sprs_continue:
			pop bc
			inc b
			ld  a, b
			cp  3
			jp  nz, dyn_sprs_loop

		#endasm
	#endif
}
