// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Printer

void p_s (unsigned char *s) {
	rdxx = _x;  rdyy = _y;
	while (*s) {
		rdch = *s ++;
		if (rdch == '/') { rdxx = _x;  rdyy ++; } else {
			DRAW_PATTERN (rdxx ++, rdyy, rdc, rdch - 32);
		}
	}
}

void draw_tile (void) {
	gp_aux = tsmaps + (_t << 3);
	if (_y == SCR_Y + 22) {
		sp_PrintAtInv (_y    , _x    , *gp_aux ++, *gp_aux ++);
		sp_PrintAtInv (_y    , _x + 1, *gp_aux ++, *gp_aux );
	} else if (_y == SCR_Y) {
		gp_aux += 4;
		sp_PrintAtInv (_y + 1, _x    , *gp_aux ++, *gp_aux ++);
		sp_PrintAtInv (_y + 1, _x + 1, *gp_aux ++, *gp_aux );	
	} else {
		sp_PrintAtInv (_y    , _x    , *gp_aux ++, *gp_aux ++);
		sp_PrintAtInv (_y    , _x + 1, *gp_aux ++, *gp_aux ++);
		sp_PrintAtInv (_y + 1, _x    , *gp_aux ++, *gp_aux ++);
		sp_PrintAtInv (_y + 1, _x + 1, *gp_aux ++, *gp_aux );
	}
}

void all_sprites_out (void) {
	gpit = SW_SPRITES_ALL; while (gpit-- > rda) { /*if (spr_on [gpit])*/ SPRITE_OUT (gpit); }
}

/*
void blackout (void) {
	#asm
		ld bc, 767
		ld hl, 0x5800
		ld de, 0x5801
		xor a
		ld (hl), a
		ldir
	#endasm
}

void unpack_scr (unsigned char res) {
	sp_UpdateNow ();
	blackout ();
	librarian_get_resource (res, (unsigned char *) (0x4000));
}
*/

/*
void frame_ending (unsigned char *s) {
	// Shows ending picture (or not) plus text
	
	sp_UpdateNow ();
	if (rda) {
		unpack_scr (ENDING_C); 		
	} else {
		CLEAR_RECT (RECT_FULL_SCREEN);
	}	
	rdc = 71; _x = 2; _y = 13; p_s (s);
	sp_UpdateNow ();
	wait_button ();	
	
}
*/

extern unsigned char unrle_x [0], unrle_y [0], unrle_c [0];
#asm
	._unrle_x defb 0
	._unrle_y defb 0
	._unrle_c defb 0
#endasm

void unrle_adv (void) {
	gpint --;
	if (gpint > 767) {
		//sp_PrintAtInv (_y, _x, 71, rdb);
		#asm
			LIB SPCompDListAddr
			ld a, (__x)
			ld c, a
			ld a, (_rdb)
			ld d, a
			ld a, (__y)
			push de 
			call SPCompDListAddr 
			pop de 
			inc hl
			ld (hl), d
		#endasm
	} else {
		if (gpint == 767) { _x = _y = 0; }
		#asm
			LIB SPCompDListAddr
			ld a, (__x)
			ld c, a
			ld a, (_rdb)
			ld d, a
			ld a, (__y)
			push de 
			call SPCompDListAddr 
			pop de 
			ld (hl), d
		#endasm
	}
	_x ++; if (_x == 32) { _x = 0; _y ++; }	
}

void unrle (void) {
	// Point gp_aux to rle'd data.
	rdc = *gp_aux ++;	// run code
	_x = 0; _y = 0; rdb = 0; gpint = 1536;
	while (gpint) {
		rda = *gp_aux ++;
		if (rda == rdc) {
			rda = *gp_aux ++;
			if (rda == 0) break;
			while (rda --) unrle_adv ();
		} else {			
			rdb = rda;
			unrle_adv ();
		}
	}
	sp_Invalidate (RECT_FULL_SCREEN, RECT_FULL_SCREEN);
}

void p_t2 (void) {
	DRAW_PATTERN_UPD (_x ++, _y, _t, DIGIT(_n/10));
	DRAW_PATTERN_UPD (_x   , _y, _t, DIGIT(_n%10));
}
