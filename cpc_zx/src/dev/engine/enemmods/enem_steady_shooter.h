// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// en_mx [gpit] -> time between shots.
	// en_my [gpit] -> direction, where to shoot at.

	if (!ticker && !en_washit [gpit]) {
		if (_en_ct) _en_ct --; else {
			_en_ct = _STEADY_SHOOTER_WAIT; 		// reset timer
			rdx = _en_x + 4;					//
			rdy = _en_y + 4;					// Coordinates
			rda = _STEADY_SHOOTER_DIRECTION;	// Direction 0 left 1 up 2 right 3 down
			simplecoco_straight_new ();
		}
	}

	spr_id = 0xff;
	