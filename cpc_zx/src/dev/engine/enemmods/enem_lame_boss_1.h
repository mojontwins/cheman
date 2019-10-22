// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Lame boss 1. A very simple patterned boss 
// just to get the hang of it. But I will probably use scripting
// for more complex bosses in the future.

// This boss has two 'vertical' states. straight, arc. Horizontally,
// it travels back and forth. If state == vertical, 2px per frame;
// 1px per frame otherwise.

	// Custom! Won't move until flags [31] is SET

	if (en_life [gpit] == 0) {
		pal_col (26, half_life ? 0x16 : 0x1b);
	}

	spr_id = LAME_BOSS_1_CELL_BASE + ((frame_counter >> 3) & 1) + (((frame_counter >> 4) & 1) << 1);
	if (flags [31]) {
		if (_en_state == 2) {
			if (_en_x == _en_x1 && _en_y <= _en_y1) {
				_en_state = 0; _en_mx = -1;
			} else {
				_en_x += (_en_x1 > _en_x) ? 1 : -1;
				_en_y --;
			}
			if (half_life) spr_id = 0xff;
		} else {
			// Horizontal:
			_en_x += _en_mx;
			if (_en_state) _en_x += _en_mx;

			if ((_en_x == 16 && _en_mx == -1) || (_en_x == 208 && _en_mx == 1)) {
				_en_mx = -_en_mx;
				rda = rand8 () & 3;
				if (rda == 0 || _en_ct == 2) {
					_en_state = 1;
					_en_ct = 0;
				} else {
					_en_state = 0;
					_en_ct ++;
				}
				_en_my = 0;
				_en_y = _en_y1;
			}

			// Vertical. _en_my == index to lb_yinc_arc
			if (_en_state) {
				_en_y += (_en_my < 48) ?
					lb_yinc_arc [_en_my] : 
					-lb_yinc_arc [95 - _en_my];
				_en_my ++;
			} else {
				// Coco
				if ((rand8 () & 7) < 1) {
					rdx = _en_x + 4; rdy = _en_y + 4; simplecoco_aimed_new ();
				}
			}
			spr_id = LAME_BOSS_1_CELL_BASE + ((_en_x >> 3) & 1) + ((_en_mx < 0) << 1);
		}
	} 

	// sprite
	// enems_spr ();
	