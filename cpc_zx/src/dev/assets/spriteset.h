// Static cell pointer definition
// Generated by mkcellpointers v0.1 20190312
// Target: zx, block size = 16 bytes, but add 1 block per dimension

extern const unsigned char *sprite_cells [0];

#asm
	._sprite_cells
	// 9 cells for the main player, 2x3
	defw _ss_main + 0x0000
	defw _ss_main + 0x00c0
	defw _ss_main + 0x0180
	defw _ss_main + 0x0240
	defw _ss_main + 0x0300
	defw _ss_main + 0x03c0
	defw _ss_main + 0x0480
	defw _ss_main + 0x0540
	defw _ss_main + 0x0600

	// 6 cells for the enemies, 2x3
	defw _ss_enems + 0x0000
	defw _ss_enems + 0x00c0
	defw _ss_enems + 0x0180
	defw _ss_enems + 0x0240
	defw _ss_enems + 0x0300
	defw _ss_enems + 0x03c0

	// 2 cells for the platform & explosion, 2x3
	defw _ss_extra + 0x0000
	defw _ss_extra + 0x00c0

	// 1 cell for the custom pumpkin, 2x2
	defw _ss_pumpkin + 0x0000

	// 1 cell for the bullet, 1x1
	defw _ss_small + 0x0000
#endasm

