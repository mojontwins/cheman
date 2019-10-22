// NES MK1 v1.0
// Copyleft Mojon Twins 2013, 2015, 2017, 2018

// Cutscenes, title screen, etc.

void bat_in (void) {
	pal_bright (0);
	ppu_on_all ();
	while (pad_poll (0));
	fade_delay = 4;
	fade_in ();
}

void bat_out (void) {
	fade_out ();
	oam_clear ();
	ppu_off ();
}

void pres (const unsigned char *p, void (*func) (void)) {
	cls ();
	pal_bg (p);
	(*func) ();
	bat_in ();
	while (1) {
		pad_read ();
		if (pad_this_frame & (PAD_A|PAD_B|PAD_START)) break;
	}
	bat_out ();
}

void pres_title (void) {
	unrle_vram (title_rle, 0x2000);
	pal_spr (palss0);
	
	oam_hide_rest (
		oam_meta_spr (
			144, 95, 4, sspl_05_a
		)
	);


	_x = 5; _y = 18; pr_str ("SELECT AND PUSH START!");
	_x = 14; _y = 21; pr_str ("GAME A%%GAME B");
	_x = 5;  _y = 26; pr_str ("@ 2018 THE MOJON TWINS"); 

	pal_bg (paltscuts);
	bat_in ();

	while (1) {
		oam_spr (12*8, 159 + (level << 4), 0, 0, 0);
		ppu_waitnmi ();
		pad_read ();
		rda = level;
		if (pad_this_frame & (PAD_SELECT|PAD_DOWN|PAD_UP)) {
			level = 1 - level;
			sfx_play (SFX_USE, 0);
		}
		if (pad_this_frame & (PAD_START|PAD_A)) break;
	}
	sfx_play (SFX_START, 0); delay (20);

	bat_out ();
}

void scr_game_over (void) {
	_x = 11; _y = 15; pr_str ("GAME OVER!");
}

void scr_game_ending (void) {
	unrle_vram (ending_rle, 0x2000);

	oam_hide_rest (
		oam_meta_spr(
			80, 87, 4, sspl_01_a
		)
	);

	switch (lang_offs) {
		case 0:
			_x =3; _y = 18; pr_str ("PUTOS BATUCADAS, PENSE QUE");
			       _y = 20; pr_str ("NO LLEGABA AL CONCIERTO DE");
			       _y = 22; pr_str ("LOS MAS GRANDES, CAGUEN...");
			       _y = 24; pr_str ("A VER SI ESTOS SE PORTAN!!");
			break;
		case 4:
			_x =3; _y = 18; pr_str ("BLOODY BATUCADAS, THEY");
			       _y = 20; pr_str ("ALMOST MADE ME LATE FOR");
			       _y = 22; pr_str ("THE GREATEST BAND ON EARTH");
			       _y = 24; pr_str ("I HOPE THEY ROCK DA PLACE!");
			break;
		case 8:
			_x =3; _y = 18; pr_str ("KACK BATUCADAS, ICH DACHTE,");
			       _y = 20; pr_str ("ICH KAEM NICHT ZUM KONZERT");
			       _y = 22; pr_str ("DER ALLERGROESSTEN, YEAH!!");
			       _y = 24; pr_str ("MAL SEHEN OB SIE ROCKEN!");
			break;
	}
}

void language_select (void) {
	pal_bg (pallang);
	pal_spr (palss0);	
	unrle_vram (lang_rle, 0x2000);
	lang_offs = 0;

	bat_in ();

	while (1) {
		pad_read ();

		if (pad_this_frame & PAD_UP) {
			if (lang_offs) lang_offs -= 4; else lang_offs = 8;
		}
		if (pad_this_frame & (PAD_DOWN|PAD_SELECT)) {
			if (lang_offs < 8) lang_offs += 4; else lang_offs = 0;
		}

		if (pad_this_frame & (PAD_A|PAD_B|PAD_START)) break;

		oam_hide_rest (
			oam_spr (
				80, 12*8 + (lang_offs << 2),
				0, 0, 0
			)
		);

		ppu_waitnmi ();
	}

	bat_out ();	
}
