// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Contains extra checks and stuff performed at the end of main loop
// Before updating the sprites!

/*
if ( 
	(level == 0 && (n_pant == 2 || n_pant == 7 || n_pant == 12 || n_pant == 17)) ||
	(level == 1 && n_pant == 18)
) {
*/

#asm
		ld  a, (_level)
		or  a
		jr  nz, _main_loop_custom_level_1

	._main_loop_custom_level_0
		ld  a, (_n_pant)
		
		cp  2
		jr  z, _main_loop_custom_level_0_totem_check

		cp  7
		jr  z, _main_loop_custom_level_0_totem_check

		cp  12
		jr  z, _main_loop_custom_level_0_totem_check

		cp  17
		jr  z, _main_loop_custom_level_0_totem_check

		jp  _main_loop_custom_end

	._main_loop_custom_level_1
		ld  a, (_n_pant)

		cp  18
		jp  nz, _main_loop_custom_end

	._main_loop_custom_level_1_totem_check

		// && pry >= 160, cancel if <
		ld  a, (_pry)
		cp  128
		jr  c,  _main_loop_custom_end

		jr  _main_loop_custom_level_X_totem_check
	._main_loop_custom_level_0_totem_check

		// && pry >= 160, cancel if <
		ld  a, (_pry)
		cp  160
		jr  c,  _main_loop_custom_end

	._main_loop_custom_level_X_totem_check
		// if (prx >= 7*16-4, cancel if < (carry set)
		ld  a, (_prx)
		cp  7*16-4
		jr  c,  _main_loop_custom_end

		// && prx <= 7*16+15+4, or 7*16+15+4 >= prx, cancel if <		
		ld  a, (_prx)
		ld  c, a
		ld  a, 7*16+15+4
		cp  c
		jr  c,  _main_loop_custom_end

		// if (flags [ONLY_ONE_OBJECT_FLAG]
		ld  a, (_flags + ONLY_ONE_OBJECT_FLAG)
		or  a
		jr  z, _main_loop_custom_end

		// Remove
		xor a
		ld  (_flags + ONLY_ONE_OBJECT_FLAG), a

		// Increase objects
		ld  a, (_pobjs)
		inc a
		ld  (_pobjs), a

		// Sound
		#endasm
			SFX_PLAY (SFX_ITEM);
		#asm

	._main_loop_custom_end
#endasm
