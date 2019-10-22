// MT MK3 ZX
// Copyleft 2017 by The Mojon Twins

// script interpreter
// generated by msc4_sp.exe from ..\script\ninjajar_B.spt

#define SCRIPT_LEVEL3_OFFSET 0x0000

const unsigned int level_script_offsets [] = {
    SCRIPT_LEVEL3_OFFSET
};

#ifdef CLEAR_FLAGS
void msc_clear_flags (void) {
	gpit = MAX_FLAGS; while (gpit --) flags [gpit] = 0;
}
#endif

unsigned char read_byte (void) {
	return *script ++;
}

unsigned char read_vbyte (void) {
	sc_c = *script ++;
	if (sc_c & 128) return flags [sc_c & 127];
	return sc_c;
}

void readxy (void) {
	rdx = read_byte ();
	rdy = read_byte ();
}

void readvxy (void) {
	rdx = read_vbyte ();
	rdy = read_vbyte ();
}

void run_script (unsigned char whichs) {
	commands_executed = 0;
    script_result = 0;

    gp_gen = (unsigned char *) (scripts_index + (whichs << 1));
    rda = *gp_gen ++; rdb = *gp_gen;
	if ((rda | rdb) == 0) return;
	script = scripts + ((rdb << 8) | rda);

	// todo : update selected item flag

	while ((sc_c = read_byte ()) != 0xff) {
		next_script = script + sc_c;
		sc_terminado = sc_continuar = 0;
		while (!sc_terminado) {
			switch (read_byte ()) {
				case 0x10:
					// IF FLAG rdx = sc_n
					// Opcode: 10 rdx sc_n
					readvxy ();
					sc_terminado = (flags [rdx] != rdy);
					break;
				case 0x13:
					// IF FLAG rdx <> sc_n
					// Opcode: 13 rdx sc_n
					readvxy ();
					sc_terminado = (flags [rdx] == rdy);
					break;
				case 0x20:
					// IF PLAYER_TOUCHES x, y
					// Opcode: 20 rdx rdy
					readvxy ();
					sc_terminado = ((prx + 4) >> 4) != rdx || ((pry + 8) >> 4) != rdy;
					break;
				case 0x21:
					// IF PLAYER_IN_X x1, x2
					// Opcode: 21 x1 x2
					readxy ();
					sc_terminado = (!(prx >= rdx && prx <= rdy));
					break;
				case 0xff:
					// then
					// opcode: ff
					sc_terminado = sc_continuar = 1;
					break;
			}
		}

		if (sc_continuar) {
			sc_terminado = 0;
			commands_executed = 1;
			while (!sc_terminado) {
				switch (sc_n = read_byte ()) {
					case 0x01:
						// SET FLAG rdx = sc_n
						// Opcode: 01 rdx sc_n
						readvxy ();
						flags [rdx] = rdy;
						break;
					case 0x15:
						// FLIPFLOP rdx
						// Opcode: 15 rdx
						rdx = read_vbyte ();
						flags [rdx] = 1 - flags [rdx];
						break;
					case 0x19:
					case 0x1a:
						flags [read_vbyte ()] = sc_n & 1;
						break;
					case 0x20:
						// SET TILE (rdx, rdy) = sc_n
						// Opcode: 20 rdx rdy sc_n
						readvxy ();
						rdt = read_vbyte ();
						set_map_tile ();
						break;
					case 0x30:
						// INC LIFE sc_n
						// Opcode: 30 sc_n
						plife += read_vbyte ();
						break;
					case 0x50:
						// PRINT_TILE_AT (rdx, rdy) = sc_n
						// Opcode: 50 rdx rdy sc_n
						readvxy ();
						rdt = read_vbyte ();
						draw_tile ();
						break;
					case 0x51:
						// SET_FIRE_ZONE x1, y1, x2, y2
						// Opcode: 51 x1 y1 x2 y2
						fzx1 = read_byte ();
						fzy1 = read_byte ();
						fzx2 = read_byte ();
						fzy2 = read_byte ();
						f_zone_ac = 1;
						break;
					case 0x6F:
						// REENTER
						// Opcode: 6F
						//do_respawn = 0;
						on_pant = 99; 
						return;
					case 0x80:
						// ENEM n ON
						// Opcode: 0x80 n
						en_t [read_vbyte ()] &= 0xf7;
						break;
					case 0x81:
						// ENEM n OFF
						// Opcode: 0x81 n
						en_t [read_vbyte ()] |= 0x08;
						break;
					case 0xE0:
						// SOUND sc_n
						// Opcode: E0 sc_n
						SFX_PLAY (read_vbyte ());
						break;
					case 0xE1:
						// SHOW
						// Opcode: E1
						SCREEN_UPDATE;
						break;
					case 0xED:
						// TEXTWINDOW sc_n
						// Opcode: 0xED sc_n
						rdt = read_byte () - 1;
						text_window ();
						break;
					case 0xE5:
						// PAUSE sc_n
						// Opcode: 0xE5 sc_n
                        delay (read_vbyte ());
						break;
					case 0xE9:
						// SET SAFE n, x, y
						// Opcode: 0xE9 n x y
						safe_n_pant = read_byte ();
						safe_prx = read_byte () << 4;
						safe_pry = read_byte () << 4;
						break;
					case 0xF1:
						// WIN
						// Opcode: 0xF1
						script_result = 1;
						return;
					case 0xff:
						sc_terminado = 1;
						break;
				}
			}
		}
		script = next_script;
	}
}
