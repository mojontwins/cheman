// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Game functions

#ifdef SCRIPTING_ON
	void game_run_fire_script (void) {
		run_script (2 * MAX_PANTS + 2);		// Press fire in any room.
		run_script (n_pant + n_pant + 1);		// Press fire in current room.
	}
#endif

void game_shutdown_sprites (void) {
	gpit = SW_SPRITES_ALL; while (gpit --) spr_on [gpit] = 0;
}

void game_init (void) {
	#if defined(ENEMIES_CAN_DIE) && defined(PERSISTENT_DEATHS)
		enems_persistent_deaths_init ();
	#endif	

	#ifdef PERSISTENT_ENEMIES
		persistent_enems_load ();
	#endif

	#ifndef DISABLE_HOTSPOTS
		hotspots_ini ();
	#endif

	#ifdef HOTSPOT_TYPE_KEY
		bolts_load ();
	#endif	

		n_pant = c_level [PLAYER_SCR_INI]; // n_pant=4;prx = 224; px=prx<<4;
		player_init ();

		pkeys = pobjs = pbodycount = 0;

	#ifdef ONLY_ONE_OBJECT_FLAG
		flags [ONLY_ONE_OBJECT_FLAG] = 0;
	#endif
		
		on_pant = oplife = opobjs = opkeys = opbodycount = 0xff;

	#ifdef HOTSPOT_TYPE_STAR
		opstars = 0xff;
	#endif	

	#ifdef ENABLE_TILE_GET
		optile_get_ctr = 0xff;
	#endif	
		max_hotspots_type_1 = 1;	// This works for Ninjajar.

		first_time = 1;

		// DRAW GAME FRAME
		gp_aux = hud_rle; unrle ();

	#ifdef ENABLE_SPRINGS
		springs_on = 1;
	#endif

	#ifdef PERSISTENT_TILE_GET
		//gpit = MAX_PANTS*12; while (gpit) { -- gpit; tile_got [gpit] = 0; }
		#asm
			ld  hl, _tile_got
			ld  de, _tile_got + 1
			xor a
			ld  (hl), a
			ld  bc, MAX_PANTS*12-1
			ldir
		#endasm
	#endif

	// Custom inits:
	#include "my/game_init_custom.h"
	
	olevel = level;
}

void game_prepare_screen (void) {
	draw_scr ();

	#ifdef HOTSPOT_TYPE_KEY
		bolts_update_screen ();
	#endif
		
	#ifndef DISABLE_HOTSPOTS	
		hotspots_load ();
	#endif

		if (first_time) first_time = 0; else {
	#ifdef PERSISTENT_ENEMIES
			persistent_update ();
	#endif
		}

	#ifdef BREAKABLE_WALLS
		breakable_init ();
	#endif

	#ifdef FLOATY_PUSH_BOXES
		fpb_init ();
	#endif

	#ifdef PLAYER_CAN_FIRE	
		bullets_ini ();
	#endif

		enems_load ();

	#ifdef ENABLE_HITTER
		hitter_frame = 0;
	#endif

	#ifdef ENABLE_COCOS
		simplecoco_init ();
	#endif

	enems_do ();

	#ifdef SCRIPTING_ON
		f_zone_ac = 0;
		fzx1 = fzx2 = fzy1 = fzy2 = 0;
		run_script (2 * MAX_PANTS + 1);		// Entering any script
		run_script (n_pant + n_pant);			// Entering this room script
	#endif	

	#ifdef CPC
		gpit = SW_SPRITES_ALL; while (gpit --) {
			sp_sw [gpit].ox = 0;
			sp_sw [gpit].oy = 0;
		}
		cpc_ResetTouchedTiles ();
		cpc_ShowTileMap (0);
	#endif	
}

void game_loop (void) {
	#ifdef CPC
		cpc_ResetTouchedTiles ();
	#endif	
		hud_update ();
	#ifdef CPC
		cpc_ShowTouchedTiles ();
		cpc_ResetTouchedTiles ();
	#endif

	// Entering Game
	#ifdef SCRIPTING_ON
		#ifdef CLEAR_FLAGS
			msc_clear_flags ();
		#endif
		script_result = 0;
		// Entering game script
		run_script (2 * MAX_PANTS);
	#endif

	#ifdef ONLY_ONE_OBJECT_FLAG
		flags [ONLY_ONE_OBJECT_FLAG] = 0;
	#endif

	do_game = 1; pkilled = 0;
	MUSIC_PLAY (M0_C);

	#ifdef SE_BEEPER
		queued_sound = 0xff;
	#endif

	while (do_game) {
		#include "engine/mainloop/flick_screen_assembly.h"

		#asm
			ld  a, (_half_life)
			ld  c, a
			ld  a, 1
			sub c
			ld  (_half_life), a
			ld  (_hl_proc), a
			ld  hl, _frame_counter
			inc (hl)
			ld  a, (_ticker)
			inc a
		#ifdef SPECCY
			cp  25
		#endif
		#ifdef CPC
			cp  16
		#endif
			jr  nz, _mltrs
			xor a
		._mltrs
			ld  (_ticker), a
		#endasm

		#ifdef SPECCY
			pad0 = CONTROLLER_READ;
		#endif		

		pgotten = pgtmx = pgtmy = 0;
		enems_do ();

		player_move ();

		#ifdef ENABLE_COCOS
			simplecoco_do ();
		#endif		
		
		#ifdef PLAYER_CAN_FIRE
			bullets_do ();
		#endif

		#ifndef DISABLE_HOTSPOTS	
			hotspots_do ();
		#endif

		#ifdef BREAKABLE_WALLS
			breakable_do ();
		#endif

		#ifdef FLOATY_PUSH_BOXES
			fpb_do ();
		#endif		

		#ifdef ENABLE_HITTER
			hitter_do ();
		#endif

		hud_update ();
		
		#ifdef ENABLE_TIMED_MESSAGE
			timed_message_do ();
		#endif		

		// Update screen
		#ifdef SPECCY	
			/*	
			if (isrc < 2) {
				#asm
					halt
				#endasm
			}
			isrc = 0;
			*/
			#asm
				.main_loop_isrc_wait
					ld  a, (_isrc)
					cp  2
					jr  c, main_loop_isrc_wait
					xor a
					ld  (_isrc), a
			#endasm
		#endif		
		
		#ifdef CPC		
			#asm
					ld  a, (_isrc_max)
					ld  c, a
					ld  a, (_isrc)
					cp  c
					jr  c, _mlmaxisrcsk
					ld  (_isrc_max), a
				._mlmaxisrcsk

				.main_loop_isrc_wait
					ld  a, (_isrc)
					cp  18
					jr  nc, main_loop_isrc_continue
					jr main_loop_isrc_wait
				.main_loop_isrc_continue
					xor a 
					ld  (_isrc), a
			#endasm
			
		#endif

		#include "my/main_loop_custom.h"
		
		if (do_game == 0 && n_pant != on_pant) continue;

		#include "engine/mainloop/screen_update.h"

		#ifdef SE_BEEPER
			if (queued_sound != 0xff) {
				beep_fx (queued_sound);
				queued_sound = 0xff;
			}
		#endif

		#ifdef SCRIPTING_ON
			if (f_zone_ac) {
				if (pry >= fzy1 && pry <= fzy2)
					if (prx >= fzx1 && prx <= fzx2)
						game_run_fire_script ();
			}
		#endif
		
		// Moar
		if (pwashit) player_hit ();

		// Customize the ending condition		
		#include "my/game_ending_condition.h"
	}
	#ifdef SPECCY
		all_sprites_out ();
	#endif
	MUSIC_STOP;
}

void game_title (void) {

	#ifdef SPECCY	
		gp_aux = title_rle; unrle (); 

		rdc = 71;
		_x = 10; _y = 13; p_s ("1.KEYS WASDM/2.KEYS OPQA\x5c/3.KEYS QAOP\x5c/4.KEMPSTON/5.SINCLAIR");

		sp_UpdateNow (); 

		#asm
			call play_music
		#endasm

		while (1) {
			gpit = KEY_ASCII - '0';
			if (gpit >= 1 && gpit <= 4) break;
		}

		if (gpit > 2) gpit --; // Fix the joke
		controls_setup ();
	#endif	

	#ifdef CPC
		MUSIC_STOP;
		gp_aux = title_rle; unrle (); 

	game_title_forlorn:
		_x = 6; _y = 15; p_s ("PRESS ESC TO REDEFINE/PRESS ENTER TO START ");

		cpc_ShowTileMap (0);

		while (cpc_AnyKeyPressed());
		while (1) {
			if (cpc_TestKey (KEY_ESC)) {
				controls_setup (); goto game_title_forlorn;
			} 
			if (cpc_TestKey (KEY_ENTER)) {
				break;
			}
		}

	#endif
}

void game_over (void) {
	CLEAR_RECT (RECT_FULL_SCREEN);
	rdc = 71; _x = 11; _y = 12; p_s ("GAME OVER!");
	SCREEN_UPDATE_NO_SPRITES;
	//MUSIC_PLAY (M2_C);
	#ifdef SPECCY
		SFX_PLAY_DIRECT (SFX_ITEM);
	#endif
	wait_button ();
	MUSIC_STOP;
}

void game_level (void) {
	CLEAR_RECT (RECT_FULL_SCREEN);
	#ifdef SPECCY
		rdc = 71; _x = 12; _y = 12; p_s ("LEVEL:");
		DRAW_PATTERN_UPD (19, 12, 71, 17+level);
	#endif
	#ifdef CPC
		rdc = 71; _x = 12; _y = 12; p_s ("LEVEL");
		_x = 18; _y = 12; _n = level+1; p_t2 ();
	#endif
	SCREEN_UPDATE_NO_SPRITES;
	//MUSIC_PLAY (M2_C);
	#ifdef SPECCY
		SFX_PLAY_DIRECT (SFX_ITEM);
	#endif
	wait_button ();
	MUSIC_STOP;
}

void game_ending (void) {
	MUSIC_PLAY (M0_C);
	#ifdef SPECCY
		gp_aux = ending_rle; unrle ();

		sp_UpdateNow ();
		SFX_PLAY_DIRECT (SFX_ITEM);
		SFX_PLAY_DIRECT (SFX_ITEM);
		SFX_PLAY_DIRECT (SFX_ITEM);

		wait_button ();
	#endif	
	#ifdef CPC
		gp_aux = ending_rle; unrle ();

		_x =3; _y = 14; p_s ("BLOODY BATUCADAS, THEY");
		_x =3; _y = 16; p_s ("ALMOST MADE ME LATE FOR");
		_x =3; _y = 18; p_s ("THE GREATEST BAND ON EARTH");
		_x =3; _y = 20; p_s ("I HOPE THEY ROCK DA PLACE!");

		cpc_ShowTileMap (0);

		SFX_PLAY_DIRECT (SFX_ITEM);

		wait_button ();
	#endif	

	MUSIC_STOP;
	CLEAR_RECT (RECT_FULL_SCREEN);
	SCREEN_UPDATE_NO_SPRITES;
}

