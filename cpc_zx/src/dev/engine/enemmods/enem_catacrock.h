// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// Catacrock. Appears, falls, and catacrocks.

	switch (_en_state) {
		case 0:
			if (_CATACROCK_COUNTER) _CATACROCK_COUNTER --; else {
				_en_state = 1;
				enf_y [gpit] = _en_y << FIX_BITS; enf_vy [gpit] = 0; }
			break;
		case 1:
			enf_vy [gpit] += CATACROCK_G; if (enf_vy [gpit] > CATACROCK_MAXV) enf_vy [gpit] = CATACROCK_MAXV;
			enf_y [gpit] += enf_vy [gpit];
			_en_y = enf_y [gpit] >> FIX_BITS;
			if (_en_y > _en_y2) {
				_en_state = 2;
				_CATACROCK_COUNTER = CATACROCK_CROCK_FRAMES;
				_en_y = _en_y2;
			}
			break;
		case 2:
			if (_CATACROCK_COUNTER) _CATACROCK_COUNTER --; else {
				_en_state = 0;
				_CATACROCK_COUNTER = _CATACROCK_WAIT;
				_en_y = _en_y1;
			}
			break;
	}

	spr_id = CATACROCK_CELL_BASE + _en_state;
	// enems_spr ();
