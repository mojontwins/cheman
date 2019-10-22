// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Precalculated, all-integer fanty from Goddess. 

// Needs FANTY_INCS_MAX and fanty_incs
// Needs fanty_retreat_incs

// Like homing fanties but with states removed, i.e. always "pursuing"

	if (fanty_timer [gpit]) {
		fanty_timer [gpit] --;
	} else {
		// Accelerate X
		if (prx > _en_x) {
			_en_mx ++; if (_en_mx >= FANTY_INCS_MAX - 1) _en_mx = FANTY_INCS_MAX - 1;
		} else if (prx < _en_x) {
			_en_mx --; if (_en_mx <= -(FANTY_INCS_MAX - 1)) _en_mx = - (FANTY_INCS_MAX - 1);
		}

		// Move X
		rdx = _en_x; if (rand8 () & 0x7) _en_x += ADD_SIGN (_en_mx, fanty_incs [ABS (_en_mx)]);
		
		// Collide X
		if ((_en_x < 8 && _en_mx < 0) || (_en_x > 232 && _en_mx > 0)) _en_mx = -_en_mx;
#ifdef FANTY_COLLIDES
		if (_en_mx) {
			cx1 = cx2 = _en_mx < 0 ? ((_en_x + 4) >> 4) : ((_en_x + 11) >> 4);
			cy1 = (_en_y + 4) >> 4; cy2 = (_en_y + 11) >> 4;
			cm_two_points ();
			if (at1 & FLOOR_BITS || at2 & FLOOR_BITS) { _en_mx = -_en_mx; _en_x = rdx; }
		}
#endif	

		// Accelerate Y
		if (pry > _en_y) {
			_en_my ++; if (_en_my >= FANTY_INCS_MAX - 1) _en_my = FANTY_INCS_MAX - 1;
		} else if (pry < _en_y) {
			_en_my --; if (_en_my <= -(FANTY_INCS_MAX - 1)) _en_my = - (FANTY_INCS_MAX - 1);
		}

		// Move Y
		rdy = _en_y; if (rand8 () & 0x7) _en_y += ADD_SIGN (_en_my, fanty_incs [ABS (_en_my)]);

		// Collide Y
		if ((_en_y < 8 && _en_my < 0) || (_en_y > 232 && _en_my > 0)) _en_my = -_en_my;
#ifdef FANTY_COLLIDES
		if (_en_my) {
			cy1 = cy2 = _en_my < 0 ? ((_en_y + 4) >> 4) : ((_en_y + 11) >> 4);
			cx1 = (_en_x + 4) >> 4; cx2 = (_en_x + 11) >> 4;
			cm_two_points ();
			if (at1 & FLOOR_BITS || at2 & FLOOR_BITS) { _en_my = 0; _en_y = rdy; }
		}
#endif	
	}

	//spr_id = FANTY_CELL_BASE + ((_en_x >> 2) & 3);
	//spr_id = FANTY_CELL_BASE + ((_en_x > prx) << 1) + ((_en_x >> 3) & 1);
	//spr_id = FANTY_CELL_BASE + (((_en_x > prx) << 1) | half_life);
	
	spr_id = FANTY_CELL_BASE + (prx > _en_x ? 1 : 0);
	