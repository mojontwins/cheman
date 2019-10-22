// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Precalculated, all-integer fanty from Goddess. 

// Needs FANTY_INCS_MAX and fanty_incs
// Needs fanty_retreat_incs

	// States are:
	// FANTY_ST_IDLE 0 - stays idle. 
	// FANTY_ST_PURSUING 1 - pursues player.
	// FANTY_ST_RETREATING 2 - retreats to original position.

	// IDLE -> PURSUING if player_in_range
	// PURSUING -> RETREATING if !player_in_range
	// RETREATING -> IDLE if x = x1 && y = y1

	rdd = (prx < _en_x) ? _en_x - prx : prx - _en_x;
	rdb = rdd < FANTY_SIGHT_DISTANCE;
	
	switch (_en_state) {
		case FANTY_ST_IDLE:
			if (rdb) {
				_en_state = FANTY_ST_PURSUING;
				_en_mx = 0;	_en_my = 0;
			}
			break;

		case FANTY_ST_PURSUING:
			if (!rdb) {
				_en_state = FANTY_ST_RETREATING;
				_en_mx = 0;	_en_my = 0;
			} else {
				// Accelerate X
				if (prx > _en_x) {
					_en_mx ++; if (_en_mx >= FANTY_INCS_MAX - 1) _en_mx = FANTY_INCS_MAX - 1;
				} else if (prx < _en_x) {
					_en_mx --; if (_en_mx <= -(FANTY_INCS_MAX - 1)) _en_mx = - (FANTY_INCS_MAX - 1);
				}

				// Move X
				rdx = _en_x; if (rand8 () & 0xf) _en_x += ADD_SIGN (_en_mx, fanty_incs [ABS (_en_mx)]);
				
				// Collide X
				if ((_en_x < 8 && _en_mx < 0) || (_en_x > 232 && _en_mx > 0)) _en_mx = -_en_mx; 
#ifdef FANTY_COLLIDES
				if (_en_mx) {
					rdx = _en_x;
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
				rdy = _en_y; if (rand8 () & 0xf) _en_y += ADD_SIGN (_en_my, fanty_incs [ABS (_en_my)]);

				// Collide Y
				if ((_en_y < 8 && _en_my < 0) || (_en_y > 232 && _en_my > 0)) _en_my = -_en_my;
#ifdef FANTY_COLLIDES
				if (_en_my) {
					cy1 = cy2 = _en_my < 0 ? ((_en_y + 4) >> 4) : ((_en_y + 11) >> 4);
					cx1 = (_en_x + 4) >> 4; cx2 = (_en_x + 11) >> 4;
					cm_two_points ();
					if (at1 & FLOOR_BITS || at2 & FLOOR_BITS) { _en_my = -_en_my; _en_y = rdy; }
				}
#endif			
			}
			break;

		case FANTY_ST_RETREATING:
			if (rdb) {
				_en_state = FANTY_ST_PURSUING;
				_en_mx = 0; _en_my = 0;
			} else {
				_en_mx = (_en_mx + 1) & 3; rds = fanty_retreat_incs [_en_mx];
				if (_en_x != _en_x1) _en_x += (_en_x > _en_x1 ? -rds : rds);
				if (_en_y != _en_y1) _en_y += (_en_y > _en_y1 ? -rds : rds);
				if (_en_x == _en_x1 && _en_y == _en_y1)	_en_state = FANTY_ST_IDLE;
			}
			break;
	}

	spr_id = FANTY_CELL_BASE + (prx > _en_x ? 1 : 0);
	// enems_spr ();
