// ob.h
// Checks during mainloop

	if (ob_char_y) {
		if (
			BUTTON_A (pad0) && 
			(prx + 15 >= ob_char_x && prx <= ob_char_x + 23 && pry + 23 >= ob_char_y && pry <= ob_char_y + 15)
		) {
			rda = 0; all_sprites_out (); SCREEN_UPDATE_NO_SPRITES;

			if (character_order_idx < 5) {
				if (character_order [character_order_idx] == ob_char_id ||
					ob_char_id == 0) {
					ob_run_script ();
					if (ob_char_id) character_order_idx ++;
				} else {
					_obt0 = _obt2 = ob_char_id; _obt1 = 6;
					ob_special ();
				}
			} 

			if (character_order_idx < 5) {
				_obt0 = ob_char_id; _obt1 = 7; _obt2 = character_order [character_order_idx];
			} else {
				_obt0 = ob_char_id; _obt1 = 8; _obt2 = (pobjs == MAX_HOTSPOTS_0_TYPE_1) ? 0 : 9;
			}
			ob_special ();
			
			SFX_PLAY_DIRECT (SFX_ITEM);
			while (button_pressed ());

			pan = 1; ob_draw_tapestry ();
			SCREEN_UPDATE_NO_SPRITES;
		}
	}


// (prx + 15 >= ob_char_x && prx <= ob_char_x + 23 && pry + 15 >= ob_char_y && pry <= ob_char_y + 15)
