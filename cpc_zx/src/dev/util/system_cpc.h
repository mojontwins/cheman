// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// System Initializacion file

void halt_me (void) {
	#asm
		halt
		halt
		halt
		halt
		halt
	#endasm
}

void system_init (void) {
	#asm
		di
	#endasm

	// Init arkos (turn it off, in fact!)

	#asm
		; Turn off arkos play routine
		ld a, 201				; Insert a RET!
		ld (PLY_PLAY), a
	#endasm

	// Init interrupts

	#asm
		ld a, 195
		ld (0x38), a

		ld hl,(0x0039)
		ld (_int_original),HL 

		ld HL,_interrupcion
		ld (0x0039),HL
		
		jp term
	._int_original  
		defw 0
	._interrupcion
		push af
		push bc
		push hl
		push de
		push ix
		push iy
		exx
		ex af, af
		push af
		push bc
		push de
		push hl
		
		ld a, (_isrc)
		inc a
		ld (_isrc), a

	.___reduce
		cp  6
		jr  c, ___noreduce
		sub 6
		jr  ___reduce
	.___noreduce		

		;and 0x1f
		;or  0x40
		;ld  bc, 0x7F10
		;out (c), c
		;out (c), a


		ld a, (_arkc)
		inc a

		cp 6
		jp nz, _noplayer

		call PLY_PLAY

		xor a
	._noplayer
		ld (_arkc), a

		pop hl 
		pop de 
		pop bc
		pop af 
		ex af, af
		exx
		pop iy
		pop ix
		pop de 
		pop hl 
		pop bc 
		pop af
		ei

		ret
	.term
	#endasm
	//halt_me ();

	// Border 0

	#asm
		ld 	a, 0x54
		ld  bc, 0x7F11
		out (c), c
		out (c), a
	#endasm

	#ifndef TAPE
		// Decompress ARKOS player and SFX
		// The binary ARKOS+SFX is loaded @ BASE_MUSIC
		// Which is the buffer where we descompress music later on

		unpack ((unsigned char *) (BASE_MUSIC+SIZE_ARKOS_COMPRESSED), (unsigned char *) (BASE_SFX));
		unpack ((unsigned char *) (BASE_MUSIC), (unsigned char *) (BASE_ARKOS));		
	#endif
	
	// Get the LUT in place
	librarian_get_resource (TRPIXLUTC, (unsigned char *) (BASE_LUT));
		
	// Default keys are punched directly in CPCRSLIB: ADSWMN ENTER ESC

	// Set palette

	_pal_set (my_inks);
	//halt_me ();

	// Set mode

	cpc_SetMode (0);

	// Set tweaked mode 
	// (thanks Augusto Ruiz for the code & explanations!)
	
	#asm
		; Horizontal chars (32), CRTC REG #1
		ld    b, 0xbc
		ld    c, 1			; REG = 1
		out   (c), c
		inc   b
		ld    c, 32			; VALUE = 32
		out   (c), c

		; Horizontal pos (42), CRTC REG #2
		ld    b, 0xbc
		ld    c, 2			; REG = 2
		out   (c), c
		inc   b
		ld    c, 42			; VALUE = 42
		out   (c), c

		; Vertical chars (24), CRTC REG #6
		ld    b, 0xbc
		ld    c, 6			; REG = 6
		out   (c), c
		inc   b
		ld    c, 24			; VALUE = 24
		out   (c), c
	#endasm

	// Sprite allocation

	gpit = SW_SPRITES_ALL; while (gpit --) {		
		sp_sw [gpit].cx = sp_sw [gpit].ox = 0;
		sp_sw [gpit].cy = sp_sw [gpit].oy = 0;
		spr_order [gpit] = gpit;

		// This game: sprites 0 - 3 are 8x24 - albeit they can change dinamicly.
		// Sprite 4 is 8x16
	
		if (gpit < 4) {
			sp_sw [gpit].sp0 = (int) (ss_main);
			sp_sw [gpit].sp1 = (int) (ss_main);			
			sp_sw [gpit].invfunc = cpc_PutSpTileMap8x24;
			sp_sw [gpit].updfunc = cpc_PutTrSp8x24TileMap2b;
			sp_sw [gpit].cox = 0;
			sp_sw [gpit].coy = -8;
		} else {
			sp_sw [gpit].sp0 = (int) (ss_pumpkin);
			sp_sw [gpit].sp1 = (int) (ss_pumpkin);
			sp_sw [gpit].invfunc = cpc_PutSpTileMap8x16;
			sp_sw [gpit].updfunc = cpc_PutTrSp8x16TileMap2b;
			sp_sw [gpit].cox = 0;
			sp_sw [gpit].coy = 0;
		}
	}

	//halt_me ();

	#asm
		ei
	#endasm
}
