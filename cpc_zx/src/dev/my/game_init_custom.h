// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Contains extra initialization code executed at the end of game_init.

#ifdef ENABLE_PUMPKIN
	spr_on [4] = 0;
	spr_next [4] = ss_pumpkin;
#endif
	
#ifdef CPC
	_pal_set (level ? my_inks2 : my_inks);
#endif
springs_on = level;
