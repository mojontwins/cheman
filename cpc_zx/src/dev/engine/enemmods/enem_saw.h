// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Saws

// This is a reimplementation of the original saws as found on MK1NES. I'll try
// to make them better this time. Less space and stuff, you know. This is NROM!

// Saws have 4 states. 0 Emerging, 1 out, 2 disappearing, 3 returning. 
// Even and odd states are simmilar, yet in opposite directions. Let's take that
// in advance.

// Two sprites must be added: one to occlude the saw, one for the actual saw.
// The occluding sprite follows _en_x, _en_y;
// The saw sprite must be offset vertically by an amount.

	rda = SAW_ORIENTATION [gpit];	// 0 = horizontal, 1 = vertical

	switch (_en_state) {
		case 0:
			// Emerging
			if (half_life) {
				if (_en_ct --) {
					if (rda) {
						_en_x += _SAW_EMERGING_DIRECTION;
					} else {
						_en_y += _SAW_EMERGING_DIRECTION;
					}
				} else {
					_en_state = 1;
					_en_ct = SAW_EMERGING_STEPS;
				}
			}
			break;
		case 1:
			// Onwards
			if (rda) {
				_en_y += _SAW_MOVING_DIRECTION;
				if (_en_y == _en_y2) _en_state = 2;
			} else {
				_en_x += _SAW_MOVING_DIRECTION;
				if (_en_x == _en_x2) _en_state = 2;
			}
			break;
		case 2:
			// Sinking
			if (half_life) {
				if (_en_ct --) {
					if (rda) {
						_en_x -= _SAW_EMERGING_DIRECTION;
					} else {
						_en_y -= _SAW_EMERGING_DIRECTION;
					}
				} else {
					_en_state = 3;
					_en_ct = SAW_EMERGING_STEPS;
				}
			}
			break;
		case 3:
			// Retreating
			if (rda) {
				_en_y -= _SAW_MOVING_DIRECTION;
				if (_en_y == _en_y1) _en_state = 0;
			} else {
				_en_x -= _SAW_MOVING_DIRECTION;
				if (_en_x == _en_x1) _en_state = 0;
			}
			break;
	}

	// Occlusion
	if (_en_state == 3) spr_id = 0xff; else {
		if (rda) {
			oam_index = oam_meta_spr (_en_x1, _en_y + SPRITE_ADJUST, oam_index, SAW_CELL_OCCLUSION);
		} else {
			oam_index = oam_meta_spr (_en_x, _en_y1 + SPRITE_ADJUST, oam_index, SAW_CELL_OCCLUSION);
		}

		// enems_spr ();
		spr_id = SAW_CELL_BASE | half_life;		// Make SAW_CELL_BASE even so this works.
	}
	