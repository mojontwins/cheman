// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void enems_drain (void) {
	if (en_dying [gpit]) return;
	if (en_washit [gpit]) return;

	#ifdef ENEMS_MIN_KILLABLE	
		if (en_t [gpit] < ENEMS_MIN_KILLABLE) return;	// Very, very bad
	#endif	

	#if ENEMS_GENERAL_LIFE > 1
		//sfx_play (SFX_BUTT_HIT, SC_LEVEL);
		// Substract life from enemy (type 7 minion in this game)
		if (en_life [gpit]) {
			en_life [gpit] --;
			en_washit [gpit] = ENEMS_GENERAL_HIT_FRAMES;
		} else {
			en_washit [gpit] = 0;
			switch (rdt) {
				case 0x10:
				case 0x20:
					en_dying [gpit] = ENEMS_GENERAL_DYING_FRAMES;
					#include "engine/enemmods/enems_kill.h"
					break;
				#ifdef ENABLE_TYPE7
					case 0x70:
						_en_state = 0; _en_ct = TYPE7_SPAWN_TIME;
						en_dying [gpit] = TYPE7_MINION_DYING_FRAMES;
						break;
				#endif
			}
		}
	#else
		en_washit [gpit] = 0;
		en_dying [gpit] = ENEMS_GENERAL_DYING_FRAMES;
		#include "engine/enemmods/enems_kill.h"
	#endif	

	SFX_PLAY (SFX_ENEMY_HIT);
}
