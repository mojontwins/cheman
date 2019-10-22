// NES MK1 v1.0
// Copyleft Mojon Twins 2013, 2015, 2017, 2018

// Jumpin' Pezon

// Set occluding sprite @ origin
oam_index = oam_meta_spr (
	_en_x1, _en_y1 + SPRITE_ADJUST, 
	oam_index, 
	spr_enems [ENEMS_OCCLUDING_CELL]
);

switch (_en_state) {
	case 0:	// Idling
		if (_en_mx) {
			-- _en_mx;
		} else {
			_en_state = 1;
			_enf_y = _en_y1 << 6;
			_enf_vy = -PEZON_THRUST;
			sfx_play (SFX_FLOAT, 1);
		}
		break;

	case 1: // on air
		_enf_vy += PEZON_G;
		if (_enf_vy > PEZON_VY_FALLING_MAX) _enf_vy = PEZON_VY_FALLING_MAX;
		_enf_y += _enf_vy;
		_en_y = _enf_y >> 6;

		if (_en_y >= _en_y1) {
			_en_state = 0;
			_en_mx = _en_my;
			
		} else {
			en_spr = PEZONS_BASE_SPRID + (_enf_vy >= -64);
		}
		break;
}

_en_facing = 0;
