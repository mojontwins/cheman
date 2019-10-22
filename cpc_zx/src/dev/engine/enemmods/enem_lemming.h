// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Enem. type lemming - walks, turns around on obstacles, falls.

// _en_state = 1 -> falling

if (_en_state) {
	_en_y += LEMMINGS_G;
	if (0 == (_en_y & 0xf)) {
		if (scr_attr [16 + ((_en_x >> 4) | ((_en_y - 16) & 0xf0))] & FLOOR_BITS) _en_state = 0;
	}
} else {
	// Collide / change state
	
	if (0 == (_en_x & 0xf)) {
		rdc = (_en_x >> 4) | ((_en_y - 16) & 0xf0);
		if (0 == (scr_attr [rdc + 16] & FLOOR_BITS)) _en_state = 1;
		else if (
			(_en_mx < 0 && (scr_attr [rdc - 1] & OBSTACLE_BIT)) ||
			(_en_mx > 0 && (scr_attr [rdc + 1] & OBSTACLE_BIT))
		) _en_mx = -_en_mx;
	}
	
	// walk
	if (0 == _en_state)_en_x += _en_mx;
}

spr_id = en_s [gpit] + (rda & 1);
