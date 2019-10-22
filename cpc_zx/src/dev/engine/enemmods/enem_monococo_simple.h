// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	// Monococo simple, as seen in Ninjajar!

	// After this, the mono may move as a linear enemy. That means that
	// the enemy sprite MUST be correctly set in the ponedor.

	if (_en_ct) {
		_en_ct --;
		if (0 == _en_ct) {
			rdx = _en_x + 4; rdy = _en_y + 4; simplecoco_aimed_new ();
		}
#ifdef SPECCY		
		_en_x = _en_x1 + half_life;
#endif
#ifdef CPC
		_en_y = _en_y1 - half_life;
#endif
	} else _en_x = _en_x1;

	if ((rand8 () & MONOCOCO_SIMPLE_SHOOTING_FREQ) == 1) {
		_en_ct = 25;
	}
	spr_id = en_s [gpit] + (prx > _en_x ? 1 : 0);

