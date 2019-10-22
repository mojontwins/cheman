// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Precalculated pezon
// Copyleft 2017 by The Mojon Twins

// Needs PEZON_INCS_MAX, PEZON_INCS_FIRST_FALL and pezon_incs

	if (_en_state) {
		_en_y += pezon_incs [_PEZON_INCS_IDX];

		spr_id = PEZONS_BASE_SPRID + (_PEZON_INCS_IDX > PEZON_INCS_FIRST_FALL);
		
		if (_PEZON_INCS_IDX < PEZON_INCS_MAX) {
			_PEZON_INCS_IDX ++; 
		} else {
			_en_state = 0;
			_en_y = _en_y1;
			_PEZON_TIMER = _PEZON_MAX_TIME;
		}
	} else {
		spr_id = 0xff;
		
		if (_PEZON_TIMER) _PEZON_TIMER --; else {
			_PEZON_INCS_IDX = 0;
			_en_state = 1;
			_en_y = _en_y1;
		}
	}
	