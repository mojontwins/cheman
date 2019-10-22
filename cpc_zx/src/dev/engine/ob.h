// ob.h
// Routines

void ob_init (void) {
	// Try and randomize
	#asm
		ld a, r
		ld (_seed1), a
		xor a 
		ld (_seed2), a
	#endasm
	srand ();
	gpit = 5; while (gpit --) character_order [gpit] = gpit + 1;
	gpit = 10; while (gpit --) {
		rda = rand8 () & 7; if (rda > 4) rda -= 5;
		rdb = rand8 () & 7; if (rdb > 4) rdb -= 5;
		rdc = character_order [rda]; character_order [rda] = character_order [rdb]; character_order [rdb] = rdc;
	}
	character_order_idx = 0;	
}

void ob_draw_tapestry (void) {
	gp_map = pan ? (scr_buff + 66) : box_buff;
	_x = 4; _y = 9; gpit = 48; while (gpit --) {
		_t = *gp_map ++;
		DRAW_TILE (); 
		_x += 2; if (_x == 28) { 
			_x = 4; _y +=2; 
			if (pan) gp_map += 4;
		}
	}
}

void ob_draw_text (void) {
	// Draws text rda;
	ob_text_pt = texts0 + (rda << 4) + (rda << 1) + rda; // rda*19
	gpit = 19; while (gpit --) {
		DRAW_PATTERN (rdx ++, rdy, 71, *ob_text_pt ++ - 32);
	}
}

void ob_special (void) {
	pan = 0; ob_draw_tapestry ();
	rdy = 10; rdx = 5; rda = _obt0; ob_draw_text ();
	rdy = 12; rdx = 7; rda = _obt1; ob_draw_text (); SCREEN_UPDATE_NO_SPRITES; SFX_PLAY_DIRECT (SFX_ENEMY_HIT);
	if (_obt2) rdy = 13; rdx = 7; rda = _obt2; ob_draw_text (); SCREEN_UPDATE_NO_SPRITES; SFX_PLAY_DIRECT (SFX_ENEMY_HIT);
	SFX_PLAY_DIRECT (SFX_ITEM);
	wait_button ();	
}

void ob_run_script (void) {
	gp_gen = scripts [ob_char_id];
	while ((rdc = *gp_gen ++) != 0xfe) {
		pan = 0; ob_draw_tapestry ();
		rdy = 10; rdx = 5; rda = rdc; ob_draw_text ();
		rdy = 12; 
		gpjt = 4; while (gpjt --) {
			rdx = 7; if (rda = *gp_gen ++) ob_draw_text ();
			rdy ++;
			SCREEN_UPDATE_NO_SPRITES;
			SFX_PLAY_DIRECT (SFX_ENEMY_HIT);
		}		

		SFX_PLAY_DIRECT (SFX_ITEM);
		wait_button ();
	}
	SCREEN_UPDATE_NO_SPRITES;
}

