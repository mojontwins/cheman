// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Enem type walker
	if (_en_state) {
		if (_en_x1 == _en_x && _en_y1 == _en_y) _en_state = 0; else {
			if (en_washit [gpit]) en_washit [gpit] --; else if (half_life) {
				_en_x += _en_mx;
				_en_y += _en_my;
			}
		}
	} else {
		// Decide new direction
		rda = rand8 () & 3;

		do {
			_en_mx = en_dx [rda];
			_en_my = en_dy [rda];

			// Decide range
			rdb = WALKER_EXPRESSION;

			// Trim range & set destination
			rdx = _en_x >> 4; rdy = _en_y >> 4;
			rdc = 0; while (rdc < rdb) {
				_en_x1 = rdx << 4; _en_y1 = rdy << 4;
				rdx += _en_mx; rdy += _en_my;
				if (scr_attr [rdx + (rdy << 4)]) break;
				rdc ++;
			}

			// Facing
			en_facing [gpit] = (rda << 1);

			rda ++; rda &= 3;
		} while (_en_x1 == _en_x && _en_y1 == _en_y);

		_en_state = 1;
	}

	// enems_spr ();
	spr_id = WALKER_BASE_SPRITE + en_fr + en_facing [gpit];
