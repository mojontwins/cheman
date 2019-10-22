// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins
	if (!phidden) _en_state = 1;

	switch (_en_state) {
		case 0:
			// Idling
			_enf_vx = _enf_vy = 0;
			break;

		case 1:
			// Pursuing
			if (!half_life) {
				if (_enf_x > px) {
					_enf_vx -= (ESPECTRO_A+ESPECTRO_A); if (_enf_vx < -ESPECTRO_MAXV) _enf_vx = -ESPECTRO_MAXV;
				} else if (_enf_x < px) {
					_enf_vx += (ESPECTRO_A+ESPECTRO_A); if (_enf_vx > ESPECTRO_MAXV) _enf_vx = ESPECTRO_MAXV;
				}
				if (_enf_y > py) {
					_enf_vy -= (ESPECTRO_A+ESPECTRO_A); if (_enf_vy < -ESPECTRO_MAXV) _enf_vy = -ESPECTRO_MAXV;
				} else if (_enf_y < py) {
					_enf_vy += (ESPECTRO_A+ESPECTRO_A); if (_enf_vy > ESPECTRO_MAXV) _enf_vy = ESPECTRO_MAXV;
				}
			}

			if (phidden) _en_state = 2;
			break;

		case 2:
			// Retreating
			if (!half_life) {
				_enf_vx = (_enf_x > px) ? ESPECTRO_V_RETREATING : -ESPECTRO_V_RETREATING;
				_enf_vy = (_enf_y > py) ? ESPECTRO_V_RETREATING : -ESPECTRO_V_RETREATING;
			}

			if (_enf_x < 0 | 
				_enf_x > 240 << FIX_BITS ||
				_enf_y < 0 ||
				_enf_y > 192 << FIX_BITS) _en_state = 0;

			break;
		case 3:
			// Stopped
			_enf_vx = _enf_vy = 0;
			if (_en_ct) _en_ct --; else _en_state = 2;
			break;
	}

	// Horizontal
	_enf_x += _enf_vx; 
	_enf_y += _enf_vy; 
	
	_en_x = _enf_x >> FIX_BITS;
	_en_y = _enf_y >> FIX_BITS;
	
	spr_id = _en_state ? ESPECTRO_CELL_BASE + ((frame_counter >> 3) & 3) : 0xff;
	// enems_spr ();
