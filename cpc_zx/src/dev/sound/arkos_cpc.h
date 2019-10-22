// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Simple arkos interface (CPC)
#define ARKOS_SFX_CHANNEL 1	

void music_play (unsigned char n) {
	// Unpack song to buffer.
	librarian_get_resource (n, (unsigned char *)(BASE_MUSIC));

	// Call PLY_INIT
	#asm
		ld de, BASE_MUSIC
		call PLY_INIT
	#endasm

	// Sound bank.
	#asm
		ld de, BASE_SFX
		call PLY_SFX_INIT
	#endasm

	// Turn on arkos play routine
	#asm
		ld a, 175
		ld (PLY_PLAY), a
	#endasm

}

void sfx_play (unsigned char n) {
	#asm
		ld a, ARKOS_SFX_CHANNEL
		ld h, 15
		ld e, 50
		ld d, 0
		ld bc, 0
		call PLY_SFX_PLAY
	#endasm
}

void music_stop (void) {
	#asm
		call PLY_STOP

		; Turn off arkos play routine
		ld a, 201
		ld (PLY_PLAY), a
	#endasm
}
