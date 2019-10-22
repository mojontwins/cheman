// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void enems_drain (void) {
	#asm
		// It's a good thing gpit is copied to b
		ld  d, 0
		ld  e, b
		ld  hl, _en_dying
		add hl, de
		ld  a, (hl)
		or  a
		ret nz
		ld  hl, _en_washit
		add hl, de
		ld  a, (hl)
		or  a
		ret nz

		#ifdef ENEMS_MIN_KILLABLE
			ld  a, (__en_t)
			cp  ENEMS_MIN_KILLABLE
			ret c
		#endif

		#if ENEMS_GENERAL_LIFE > 1
			// Note that de already contains gpit
			ld  hl, _en_life
			add hl, de
			ld  a, (hl)
			or  a
			jr  z, _enems_drain_kill

			dec a
			ld  (hl), a
			ld  hl, _en_washit
			add hl, de
			ld  a, ENEMS_GENERAL_HIT_FRAMES
			ld  (hl), a
			jp _enems_drain_honk

		._enems_drain_kill
			ld  hl, _en_washit
			add hl, de
			xor a
			ld  (hl), a

			#ifdef ENABLE_TYPE7
				ld  a, (_rdt)
				cp  0x70
				jr  nz, _enems_drain_kill_general

			._enems_drain_kill_minion
				xor a
				ld  (__en_state), a
				push bc
				push de
				#endasm
				// Needed. TYPE7_SPAWN_TIME may contain C
				_en_ct = TYPE7_SPAWN_TIME;
				#asm	
				pop bc
				pop de

				ld  hl, _en_dying
				add hl, de
				ld  a, TYPE7_MINION_DYING_FRAMES
				ld  (hl), a

				jr _enems_drain_honk
			#endif

		._enems_drain_kill_general
			// Note that de already contains gpit
			ld  hl, _en_dying
			add hl, de
			ld  a, ENEMS_GENERAL_DYING_FRAMES
			ld  (hl), a

			#include "engine/enemmods/enems_kill_assembly.h"
		#else
			// Note that hl already points to en_washit [gpit]
			xor a
			ld  (hl), a

			// Note that de already contains gpit
			ld  hl, _en_dying
			add hl, de
			ld  a, ENEMS_GENERAL_DYING_FRAMES
			ld  (hl), a

			#include "engine/enemmods/enems_kill_assembly.h"
		#endif
	
	._enems_drain_honk
	push bc
	#endasm
		SFX_PLAY (SFX_ENEMY_HIT);
	#asm
	pop bc
	#endasm
}
