// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// main.h - You see flags

void main (void) {
	system_init ();

	while (1) {
		game_title (); 			// Set option in gpit!

		level = olevel = 0;
#ifdef HOTSPOT_TYPE_STAR		
		pstars = 0;
#endif	
		plife = LIFE_INI;
#ifdef ENABLE_TILE_GET		
		ptile_get_ctr = 0;
#endif		

		while (1) {
			game_level ();
			level_setup ();
			game_init ();
			game_loop ();			

			if (pkilled) {
				game_over ();
				break;
			} else {
				if (level < 2) {
					level ++;
				} else {
					game_ending ();
					break;
				}
			}
		}
	}
}
