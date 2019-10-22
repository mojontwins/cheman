// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

#define COLLISION_BITS (EVIL_BIT | PLATFORM_BIT | OBSTACLE_BIT)

#ifdef TYPE7_WITH_GENERATOR
	if (en_gen_washit [gpit]) en_gen_washit [gpit] --;
#endif	

	if (_en_state) {
		// Minion on
		if (!en_washit [gpit]) if (!phit /*&& (en_hl [gpit] || half_life)*/ && !en_fishing [gpit] && !pflickering ) {
			// Pursue relentlessly
			rdx = prx & 0xfc; rdy = pry & 0xfc;
			rdc = en_v [gpit];
			if (rdx > _en_x) _en_mx = rdc;
			else if (rdx < _en_x) _en_mx = -rdc;
			else _en_mx = 0;
			if (rdy > _en_y) _en_my = rdc;
			else if (rdy < _en_y) _en_my = -rdc;
			else _en_my = 0;

			// Move, check colision. Use what fits your needs!			
			if (_en_mx) {
				_en_x += _en_mx;
				
				cy1 = (_en_y + 8) >> 4; cy2 = (_en_y + 15) >> 4;
				if (_en_mx < 0) {
					cx1 = cx2 = (_en_x + 4) >> 4;
					rdb = ((cx1 + 1) << 4) - 4;
				} else if (_en_mx > 0) {
					cx1 = cx2 = (_en_x + 11) >> 4;
					rdb = ((cx1 - 1) << 4) + 4;
				}
				cm_two_points ();
				if ((at1 & COLLISION_BITS) || (at2 & COLLISION_BITS)) _en_x = rdb;
			}

			if (_en_my) {
				_en_y += _en_my;

				cx1 = (_en_x + 4) >> 4; cx2 = (_en_x + 11) >> 4;
				if (_en_my < 0) {
					cy1 = cy2 = (_en_y + 8) >> 4;
					rdb = ((cy1 + 1) << 4) - 8;
				} else if (_en_my > 0) {
					cy1 = cy2 = (_en_y + 15) >> 4;
					rdb = ((cy1 - 1) << 4);
				}
				cm_two_points ();
				if ((at1 & COLLISION_BITS) || (at2 & COLLISION_BITS)) _en_y = rdb;
				
			}

			if ((rand8 () & TYPE7_STOP_RATE) == 2) en_fishing [gpit] = TYPE7_STOP_FRAMES + (rand8 () & TYPE7_STOP_FRAMES);
		}

		if (en_fishing [gpit]) en_fishing [gpit] --;
		
		//spr_id = en_s [gpit] + ((_en_mx > 0) ? 0 : 2) + ((frame_counter >> 4) & 1);
		// CUSTOM {
		spr_id = en_s [gpit] + ((_en_x >> 3) & 1);
		// } END_OF_CUSTOM
		
		#ifdef ENEMS_WITH_FACING
			spr_id += (_en_mx ? ((_en_mx > 0) ? 0 : 2) : ((_en_my > 0) ? 0 : 2));
		#endif
	} else {
		// This makes life easier later on and somewhere else
		_en_x = _en_x1; 
		_en_y = _en_y1;
		// Idling
		if (_en_ct) _en_ct --; else {
			//if (generators_active) { // this is custom
				// Velocities 1 2 4 1				
				rda = rand8 () & 3;
				if (rda == 3) rda = 0;
				en_v [gpit] = 1 << rda;
				// } END_OF_CUSTOM

				// Type
#ifdef TYPE7_FIXED_SPRITE
				en_s [gpit] = TYPE7_FIXED_SPRITE << 2;
#else			
				// CUSTOM {
				en_s [gpit] = ENEMS_CELL_BASE + ((rand8 () & 3) << 2);
				// } END_OF_CUSTOM
#endif				
				_en_state = 1;
				en_life [gpit] = TYPE7_MINION_LIFE;
			//}
		}

		spr_id = 0xff;
		if (_en_ct < TYPE7_SMOKE_TIME) {
			_en_x = _en_x1; 
			_en_y = _en_y1;
			spr_id = EXPLOSION_CELL_BASE;
		} 
	}

	// enems_spr ();
	
