// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Sets up control

const unsigned int keyscancodes [] = {
	0x02fb, 0x02fd, 0x01fd, 0x04fd, 0x087f, 0x047f,		// WSADMN
	0x01fb, 0x01fd, 0x02df, 0x01df, 0x017f, 0x017f 		// QAOP_s
};

#ifdef SPECCY
void controls_setup (void) {
	#define JUMP_WITH_UP
	switch (gpit) {
		case 1:
		case 2:
			joyfunc = sp_JoyKeyboard;
			gpjt = gpit == 2 ? 6 : 0;
			keys.up = keyscancodes [gpjt ++];
			keys.down = keyscancodes [gpjt ++];
			keys.left = keyscancodes [gpjt ++];
			keys.right = keyscancodes [gpjt ++];
			key_jump = keyscancodes [gpjt ++];
			keys.fire = keyscancodes [gpjt];
			break;
		case 3:
			joyfunc = sp_JoyKempston;
			break;
		case 4:
			joyfunc = sp_JoySinclair1;
			break;
	}
}
#endif

#ifdef CPC
	// Key order is left right down up action jump.
	// If your game does not use all key assignations
	// you have to skip those you don't use in the for loop.

	#define LASTKEY 6
	
	// CUSTOM {
	/*
	unsigned char ktext_0 [] = "LEFT ";
	unsigned char ktext_1 [] = "RIGHT";
	unsigned char ktext_2 [] = "DOWN ";
	unsigned char ktext_3 [] = "UP   ";
	unsigned char ktext_4 [] = "ACTION";
	unsigned char ktext_5 [] = "JUMP  ";
	unsigned char *ktexts [] = {
		ktext_0, ktext_1, ktext_2, ktext_3, ktext_4, ktext_5
	};
	*/
	unsigned char ktext_0 [] = "LEFT ";
	unsigned char ktext_1 [] = "RIGHT";
	unsigned char ktext_2 [] = "JUMP ";
	unsigned char *ktexts [] = {
		ktext_0, ktext_1, 0, 0, 0, ktext_2
	};
	// } END_OF_CUSTOM

	void controls_setup (void) {
		// Redefinition code
		_x = 6; _y = 15; p_s ("                     /                     ");

		// First of all, clear up definitions so no collision is possible:
		for (gpit = 0; gpit <= KEY_BUTTON_B; gpit ++) cpc_AssignKey (gpit, 0);
		
		while (cpc_AnyKeyPressed ());
		_x = 8; _y = 15; p_s ("PRESS A KEY FOR:");
		for (gpit = 0; gpit < LASTKEY; gpit ++) {
			// CUSTOM { SKIP TO JUMP!
			if (gpit == 2) gpit = 5;
			// } END OF CUSTOM
			_x = 13; _y = 16; p_s (ktexts [gpit]);
			cpc_ShowTileMap (0);
			cpc_RedefineKey (gpit);
			//while (cpc_TestKey (gpit));			
		}
	}
#endif
