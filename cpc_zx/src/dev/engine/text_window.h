// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Text window

// Encoded text is 5bit escaped, 0x1f is ESC.
//       c = 0x00->0x1e translates to ASCII c + 32
// ESC + c = 0x00->0x1f translates to ASCII c.

// Exceptions: 
// '%' means "new line"
// ' ' is converted to '[' so you don't need a 0x1f, 0x00 sequence for spaces
// '[' is rendered as a " ".
// '\' is renderer as a "Ñ".
// ']' is rendered as a "¿".
// '^' is rendered as a "¡".
// '_' is rendered as a "º".

// First decoded 5 bits value contains the # of lines.

unsigned char *text_buff = TEXTBUFF;
extern unsigned char tbi [0];
#asm 
	._tbi defb 0
#endasm

void text_window (void) {
	// Show text #rdt

	tbi [0] = rdt << 1;

	#asm
		ld	a, (_tbi);
		ld	e, a
		ld 	d, 0

		; For 16 bit indexes...
		; ld 	a, (_tbi + 1)
		; ld 	d, a

		ld 	hl, _text_pool
		add hl, de 
		ld 	c, (hl)
		inc hl 
		ld 	b, (hl)
		;push bc 
		;pop hl
		ld 	hl, _text_pool 
		add hl, bc

		ld 	de, TEXTBUFF

		; 5-bit scaped depacker by na_th_an
		; Contains code by Antonio Villena
		
		ld 	a, $80

	.fbsd_mainb
		call fbsd_unpackc
		ld 	c, a
		ld 	a, b
		and a
		jr 	z, fbsd_fin
		call fbsd_stor
		ld 	a, c
		jr 	fbsd_mainb	

	.fbsd_stor
		cp 	31
		jr 	z, fbsd_escaped
		add a, 32
		jr fbsd_stor2
	.fbsd_escaped
		ld 	a, c
		call fbsd_unpackc
		ld 	c, a
		ld 	a, b
	.fbsd_stor2
		ld 	(de), a
		inc de
		ret

	.fbsd_unpackc
		ld      b, 0x08
	.fbsd_bucle
		call    fbsd_getbit
		rl      b
		jr      nc, fbsd_bucle
		ret

	.fbsd_getbit
		add     a, a
		ret     nz
		ld      a, (hl)
		inc     hl
		rla
		ret        
		
	.fbsd_fin
		ld (de), a	

	#endasm

#ifdef SPECCY
	rda = 0; all_sprites_out ();
#endif

#ifdef CPC
	SCREEN_UPDATE
#endif	

	// Draw frame:
	rda = text_buff [0] - 32;
	_x  = 3; rdc = 7; _y  = 4 + (rda << 1); 	

#ifdef SPECCY
	while (3 < _y --) p_s ("                          ");
#endif
#ifdef CPC
	while (3 < _y --) {
		_x  = 3; gpit = 26; 
		while (gpit --) DRAW_PATTERN_UPD (_x  ++, _y , 0, 0);
		SCREEN_UPDATE;
	}
#endif	

	_y  = 4; _x  = 4; rdct = 1;
	gp_gen = text_buff + 1;
	while (rdch = *gp_gen ++) {
		if (rdch == 5) {  // '%' - 32 = 5
			_x  = 4; _y  += 2;
		} else {
			DRAW_PATTERN_UPD (_x , _y , 71, rdch);
			_x  ++;
		}

		// Pause / show
		if (rdct) {
#ifdef SPECCY
			#asm
				halt
				halt
				halt
			#endasm
#endif
#ifdef CPC
			halt_me ();
			halt_me ();
			halt_me ();
#endif				
			SCREEN_UPDATE;
		}

		if (button_pressed ()) rdct = 0;
	}
	SCREEN_UPDATE;
	SFX_PLAY (SFX_ITEM);
	wait_button ();
	draw_scr_buffer ();
	hotspots_load ();
}
