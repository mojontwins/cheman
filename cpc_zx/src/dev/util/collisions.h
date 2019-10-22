// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Collisions

void cm_two_points (void) {
	// Calculates at1 & at2 from cx1, cy1 & cx2, cy2
	/*
	if (cy1 > TY_MAX || cy2 > TY_MAX) { at1 = at2 = 0; return; }
	at1 = scr_attr [cx1 | ((cy1 ? cy1 - 1 : 0) << 4)];
	at2 = scr_attr [cx2 | ((cy2 ? cy2 - 1 : 0) << 4)];
	*/

	#asm 
			ld  a, (_cy1)
			cp  TY_MAX+1
			jr  c, cm_two_points_keep_comparing
			jr  cm_two_points_do
		.cm_two_points_keep_comparing
			ld  a, (_cy2)
			cp  TY_MAX+1
			jr  c, cm_two_points_go_on
		.cm_two_points_do 
			
			// at1 = at2 = 0 (out of bounds)
			
			xor a
			ld  (_at1), a
			ld  (_at2), a 
			ret

		.cm_two_points_go_on

			// Calculate at1

			ld  a, (_cy1)
			jr  z, cm_two_points_at1_1
			dec a
		.cm_two_points_at1_1
			
			ld  c, a
			sla c
			sla c
			sla c
			sla c

			ld  a, (_cx1)
			or  c

			ld  e, a 
			ld  d, 0
			ld  hl, _scr_attr
			add hl, de 

			ld  a, (hl)
			ld  (_at1), a

			ld  hl, _scr_buff
			add hl, de

			ld  a, (hl)
			ld  (_t1), a

			// Calculate at2

			ld  a, (_cy2)
			jr  z, cm_two_points_at2_1
			dec a
		.cm_two_points_at2_1
			
			ld  c, a
			sla c
			sla c
			sla c
			sla c

			ld  a, (_cx2)
			or  c

			ld  e, a 
			ld  d, 0
			ld  hl, _scr_attr
			add hl, de 

			ld  a, (hl)
			ld  (_at2), a

			ld  hl, _scr_buff
			add hl, de

			ld  a, (hl)
			ld  (_t2), a
	#endasm
}

unsigned char collide (void) {
	#asm
		// x1 + 7  >= x2 && 
		// x2 + 15 >= x1 && 
		// y1 + 7  >= y2 && 
		// y2 + 15 >= y1

		// Will fail if any of these is true:
		// A          C
		// x1 + 7   < x2
	    // x2 + 15  < x1
	    // y1 + 7   < y2
	    // y2 + 15  < y1
			ld  a, (_cx2)
			ld  c, a
			ld  a, (_cx1)
			add 7
			cp  c
			jr  c, _collide_reset

			ld  a, (_cx1)
			ld  c, a 
			ld  a, (_cx2) 
			add 15 
			cp  c 
			jr  c, _collide_reset

			ld  a, (_cy2)
			ld  c, a
			ld  a, (_cy1)
			add 7
			cp  c 
			jr  c, _collide_reset

			ld  a, (_cy1)
			ld  c, a
			ld  a, (_cy2)
			add 15
			cp  c
			jr  c, _collide_reset

		._collide_set
			ld  hl, 1
			jr  _collide_done

		._collide_reset
			ld  hl, 0

		._collide_done
			ret
	#endasm	
}
