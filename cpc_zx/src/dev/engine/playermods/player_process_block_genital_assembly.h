// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

void player_process_block (void) {
	#asm
		// if (__y) __y --;

			ld  a, (___y)
			or  a
			jr  z, _ppb_zero_y
			dec a
			ld  (___y), a
		._ppb_zero_y

		// rdc = __x + (__y << 4);
			ld  a, (___y)
			sla a
			sla a
			sla a 
			sla a
			ld  c, a
			ld  a, (___x)
			add c
			ld  (_rdc), a

		// rda = scr_attr [rdc] & 1;
			ld  d, 0
			ld  e, a
			ld  hl, _scr_attr
			add hl, de
			ld  a, (hl)
			and 1

		// if (rda) {	
			jr  z, _ppb_is_keyhole

		._ppb_is_pushblock
		#ifdef PLAYER_PUSH_BOXES
			// TODO: translate
			#endasm
				{
					#ifdef PLAYER_FIRE_TO_PUSH
						if (BUTTON_A (pad)) 
						#endif		
						{
							// push block
							pbx1 = __x; pby1 = __y;
							if (__d) {
								if (CONTROLLER_LEFT (pad)) {
									if (__x > 0) if (0 == scr_attr [__x - 1 + (__y << 4)]) pbx1 = __x - 1;
								} else if (CONTROLLER_RIGHT (pad)) {
									if (__x < 15) if (0 == scr_attr [__x + 1 + (__y << 4)]) pbx1 = __x + 1;
								}
							} else {
								if (CONTROLLER_UP (pad)) {
									if (__y > 0) if (0 == scr_attr [__x + ((__y - 1) << 4)]) pby1 = __y - 1;
								} else if (CONTROLLER_DOWN (pad)) {
									if (__y < 11) if (0 == scr_attr [__x + ((__y + 1) << 4)]) pby1 = __y + 1;
								}
							}
							if (pbx1 != __x || pby1 != __y) {
								_x = __x; _y = __y; _t = FLOATY_PUSH_BOXES_SUBST; set_map_tile ();
								_x = pbx1; _y = pby1; _t = 14; set_map_tile ();
								hotspots_paint ();
								SFX_PLAY (SFX_COCO);

								#ifdef PLAYER_PUSH_BOXES_CRUSH_CRUDE
									rdx = pbx1 << 4;
									rdy = (pby1+1) << 4;
									gpit = 3; while (gpit --) {
										if (en_t [gpit] &&
											en_x [gpit] + 15 >= rdx && en_x [gpit] <= rdx + 15 &&
											en_y [gpit] + 15 >= rdy && en_y [gpit] <= rdy + 15) {
											enems_drain ();
										}
									}
								#endif
							}

							#ifdef PLAYER_FIRE_TO_PUSH				
								pfiring = 1;
							#endif								
						}
				}
			#asm

			ret
		#endif

		._ppb_is_keyhole
		#ifdef HOTSPOT_TYPE_KEY
			// if (pkeys) {

			ld  a, (_pkeys)
			or  a
			ret z

			dec a
			ld  (_pkeys), a
			call _bolts_clear_bolt
			ld  a, (___x)
			ld  (__x), a
			ld  a, (___y)
			ld  (__y), a
			xor a
			ld  (__t), a
			call _set_map_tile
			#endasm
				SFX_PLAY (SFX_COCO);
			#asm
		#endif
	#endasm
}
