// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// All hail the monococo!
	
	// x1, y1 is where it appears.
	// mx is state. my is counter.


	// Counter & state change
	_MONOCOCO_COUNTER --; if (!_MONOCOCO_COUNTER) {
		_en_state = (_en_state + 1) & 3; _MONOCOCO_COUNTER = monococo_state_times [_en_state] - (rand8 () & 0x15);
	}

	// Shoot
	if (_en_state == 2 && _MONOCOCO_COUNTER == MONOCOCO_FIRE_COCO_AT) {
		rdx = _en_x + 4; rdy = _en_y + 4; simplecoco_aimed_new ();
		//sfx_play (SFX_SHOOT, SC_ENEMS);
	}

	// Sprite

	// Appearing / disappearing (Sonic Bad, etc):
	if (!_en_state || (_en_state != 2 && half_life)) spr_id = 0xff; else spr_id = MONOCOCO_CELL_BASE + (_en_state == 2) + (prx < _en_x ? 2 : 0);

	// Cheril Perils / Yun style:
	/*
	if (_en_state < 2)
		spr_id = MONOCOCO_CELL_BASE + _en_state;
	else
		spr_id = MONOCOCO_CELL_BASE + 2 + ((frame_counter >> 4) & 1);
	*/
