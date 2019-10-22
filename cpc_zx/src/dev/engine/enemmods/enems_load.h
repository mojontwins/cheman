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
		rdc = enoffs = n_pant + n_pant + n_pant;
	#endif

	for (gpit = 0; gpit < 3; gpit ++) {
		#ifdef ENEMS_FORMAT_COMPACTED
			if (0 == rdct) {
				en_t [gpit] = 0;
				continue;
			}
		#endif

		#if defined(ENEMIES_CAN_DIE) && defined(PERSISTENT_DEATHS)	
			#ifdef ENABLE_ESPECTROS
			#else
				// Kill enemy
				if (ep_killed [rdc]) {
					en_t [gpit] = 0;	// Inactive
					gp_gen += 4; 		// Next enemy
				} else 
			#endif
		#endif		
		{
			// T YX1 YX2 P
			// Type 
			rda = *gp_gen ++;

			#ifdef ENEMS_FORMAT_COMPACTED
				if (0 == rda) {
					en_t [gpit] = 0;
					rdct = 0;
					continue;
				}
			#endif

			#ifdef ENABLE_ESPECTROS
				if (ep_killed [rdc]) en_t [gpit] = 0x60; else 
			#endif
			en_t [gpit] = rda; 

			#ifdef ENEMS_WITH_FACING
				en_s [gpit] = ENEMS_CELL_BASE + ((en_t [gpit] & 0x0f) << 2);
			#else
				en_s [gpit] = ENEMS_CELL_BASE + ((en_t [gpit] & 0x0f) << 1);
			#endif
			rdt = en_t [gpit] & 0xf0;

			#ifdef PERSISTENT_ENEMIES
				// YX1
				rdb = *gp_gen ++;
				_en_x1 = rdb << 4;
				_en_y1 = rdb & 0xf0;

				// YX2
				rdb = *gp_gen ++;
				_en_x2 = rdb << 4;
				_en_y2 = rdb & 0xf0;

				// Attribute
				rdb = *gp_gen ++;

				// But...
				_en_x = ep_x [rdc];
				_en_y = ep_y [rdc];
			#else
				// YX1
				rdb = *gp_gen ++;
				_en_x1 = _en_x = rdb << 4;
				_en_y1 = _en_y = rdb & 0xf0;

				// YX2
				rdb = *gp_gen ++;
				_en_x2 = rdb << 4;
				_en_y2 = rdb & 0xf0;

				// Attribute
				rdb = *gp_gen ++;
			#endif
			
			_en_state = 0;
			en_life [gpit] = ENEMS_GENERAL_LIFE;

			// Define as per type
			switch (rdt) {
				#ifdef ENABLE_MONOCOCO_SIMPLE
					case 0x90:
				#endif

				#ifdef ENABLE_LEMMINGS
					case 0xc0:
				#endif

				#ifdef ENABLE_LINEAR
					case 0x10:
					case 0x20:
					
						#ifdef PERSISTENT_ENEMIES
							#ifdef PERSISTENT_ENEMIES_PACKED
								_en_mx = ep_myx [rdc] & 0x07; if (ep_myx [rdc] & 0x08) _en_mx = -_en_mx;
								_en_my = (ep_myx [rdc] >> 4) & 0x07; if (ep_myx [rdc] & 0x80) _en_my = -_en_my;
							#else
								_en_mx = ep_mx [rdc];
								_en_my = ep_my [rdc];
							#endif
						#else
							_en_mx = ADD_SIGN2 (_en_x2, _en_x1, rdb);
							_en_my = ADD_SIGN2 (_en_y2, _en_y1, rdb);
						#endif

						// This comes handy when jumping on enemies
						#ifdef PLAYER_STEPS_ON_ENEMIES
							if (_en_y1 > _en_y2) {
								rda = _en_y1; _en_y1 = _en_y2; _en_y2 = rda;
							}
						#endif
						break;
				#endif

				#ifdef ENABLE_FANTY
					case 0x30:
						#ifdef FANTY_REPOSITION_NONETHELESS
							_enf_x = _en_x1 << FIX_BITS;
							_enf_y = _en_y1 << FIX_BITS;
						#else
							_enf_x = _en_x << FIX_BITS;
							_enf_y = _en_y << FIX_BITS;
						#endif
						
						_enf_vy = 0;
						_enf_vx = (_en_x1 < 128) ? -(FANTY_MAXV+FANTY_MAXV) : FANTY_MAXV+FANTY_MAXV;
						fanty_timer [gpit] = FANTY_TIMER_BASE;
						break;

				#elif defined (ENABLE_PRECALC_FANTY) || defined (ENABLE_PRECALC_HOMING_FANTY)
					case 0x30:
						#ifdef FANTY_REPOSITION_NONETHELESS
							_en_x = _en_x1;
							_en_y = _en_y1;
						#endif

						_en_mx = _en_my = 0;
						break;

				#elif defined (ENABLE_PRECALC_TIMED_FANTY)
					case 0x30:
						_en_x = _en_x1;
						_en_y = _en_y1;
						_en_mx = _en_my = 0;
						fanty_timer [gpit] = FANTY_TIMER_BASE;
						break;
				#endif				

				#ifdef ENABLE_CATACROCK
					case 0x40:
						#ifdef PERSISTENT_ENEMIES
							_en_y = _en_y1;
						#endif
						_CATACROCK_WAIT = _CATACROCK_COUNTER = rdb << 5;	// In frames
						break;
				#elif defined (ENABLE_NUBE)
					case 0x40:
						_en_mx = rdb;
						break;
				#endif

				#ifdef ENABLE_GENERATONIS
					case 0x50:
						en_s [gpit] = (en_t [gpit] & 0x0f) << 2;
						_GENERATONI_WAIT = 31 + (rdb << 5);
						_GENERATONI_COUNTER = 0;
						_en_y = _en_y1; _en_x = _en_x1;
						break;
				#endif

				#ifdef ENABLE_ESPECTROS
					case 0x60:
						_enf_x = _en_x1 << FIX_BITS;
						_enf_y = _en_y1 << FIX_BITS;
						_enf_vx = _enf_vy = 0;
						break;
				#endif

				#ifdef ENABLE_TYPE7				
					case 0x70:
						#ifdef TYPE7_WITH_GENERATOR				
							en_gen_life [gpit] = TYPE7_GENERATOR_LIFE;
							en_gen_washit [gpit] = 0;
						#endif					
						_en_ct = TYPE7_SPAWN_TIME;
						//infested ++;
						break;
				#endif

				#ifdef ENABLE_STEADY_SHOOTER
					case 0x80:
						// Let's calculate where to shoot at: 
						rda = ADD_SIGN2 (_en_x2, _en_x1, 1);
						if (rda) 
							_STEADY_SHOOTER_DIRECTION = rda + 1; 
						else 
							_STEADY_SHOOTER_DIRECTION = ADD_SIGN2 (_en_y2, _en_y1, 1) + 2;

						// Seconds between shoots.
						_STEADY_SHOOTER_WAIT = rdb;	
						_en_ct = rdb; 
						// And draw it (as tile)
						_x = _en_x >> 4;
						_y = (_en_y >> 4) - 1;
						_t = STEADY_SHOOTER_BASE_TILE + _STEADY_SHOOTER_DIRECTION;
						set_map_tile ();
						break;
				#endif

				#ifdef ENABLE_MONOCOCO
					case 0x90:
						_MONOCOCO_COUNTER = MONOCOCO_BASE_TIME_HIDDEN - (rand8 () & 0x15);
						break;
				#endif

				#ifdef ENABLE_WALKER
					case 0xa0:
						en_facing [gpit] = 4;
						break;
	
				#elif defined (ENABLE_PRECALC_PEZON)
					case 0xa0:
						_PEZON_TIMER = _PEZON_MAX_TIME = PEZON_WAIT + (rdb << 3); 
						break;
				#endif

				#ifdef ENABLE_GYROSAW
					case 0xb0:
						_GYROSAW_COUNTER = 0; 		// Counter
						_GYROSAW_DIRECTION = rdb; 	// clockwise = 1; counter-clockwise = 0
						_en_x = _en_x1;
						_en_y = _en_y1;
						break;

				#elif defined (ENABLE_SAW)
					case 0xb0:
						// About SAWs:
						
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

						break;					
				#endif

			}

			// Finally
			en_washit [gpit] = 0;
			en_dying [gpit] = 0;

			#ifdef ENEMS_UPSIDE_DOWN
				_en_ud = 0;
			#endif

			#ifdef TYPE7_WITH_GENERATOR			
				en_gen_dying [gpit] = 0;
			#endif			
		}
		#if defined (PERSISTENT_DEATHS) || defined (PERSISTENT_ENEMIES)
			rdc ++;
		#endif

		enems_restore_vals ();
	}
}
