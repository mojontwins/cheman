// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// Generatonis
	// Generates stupid enemies which walk, turn, and fall.

	switch (_en_state) {
		case 0:
			if (GENERATONI_COUNTER [gpit]) GENERATONI_COUNTER [gpit] --; else {
				_en_state = 1;
				GENERATONI_HL [gpit] = (rand8 () & 1);
				_en_mx = (rand8 () & 1) ? 1 : -1;
			}
			break;
		case 1:
			// General walk.
			rda = _en_x;
			if (!GENERATONI_HL [gpit] || half_life) _en_x += _en_mx;

			// Detect a state change:
			cx1 = (_en_x + 4) >> 4; cx2 = (_en_x + 12) >> 4;
			cy1 = cy2 = (_en_y + 16) >> 4;
			cm_two_points ();
			if (!(at1 | at2)) {
				_en_state = 2;	// Falling
				enf_y [gpit] = _en_y << FIX_BITS; enf_vy [gpit] = 0;
			}

			cy1 = _en_y >> 4; cy2 = (_en_y + 15) >> 4;
			if (_en_mx < 0) {
				cx1 = cx2 = (_en_x + 4) >> 4;
			} else {
				cx1 = cx2 = (_en_x + 12) >> 4;
			}
			cm_two_points ();
			if (at1 || at2 || _en_x == 0 || _en_x >= 240) { 
				_en_x = rda;
				_en_mx = -_en_mx;
			}
			break;

		case 2:
			enf_vy [gpit] += GENERATONI_G; if (enf_vy [gpit] > GENERATONI_MAXV) enf_vy [gpit] = GENERATONI_MAXV;
			enf_y [gpit] += enf_vy [gpit];
			_en_y = enf_y [gpit] >> FIX_BITS;

			cx1 = (_en_x + 4) >> 4; cx2 = (_en_x + 12) >> 4;
			cy1 = cy2 = (_en_y + 15) >> 4;

			cm_two_points ();
			if ((at1 & 1) || (at2 & 1)) {
				enems_kill ();
			} else if (at1 || at2) {
				_en_y = (cy1 - 1) << 4;
				enf_y [gpit] = _en_y << FIX_BITS;
				_en_state = 1;
			}
			break;
	}

	if (_en_state) {
		en_facing [gpit] = (_en_mx > 0) ? 0 : 2;
		spr_id = en_s [gpit] + en_fr + en_facing [gpit];		
	} else {
		if (GENERATONI_COUNTER [gpit] < 60) {
			_en_y = _en_y1; _en_x = _en_x1;
			spr_id = 16;
		} else spr_id = 0xff; 
	}
	// enems_spr ();
	
