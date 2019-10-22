// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

pad = 0xff;
if (use_ct) {
	psprid = CELL_USE_BASE + use_ct;
	if (fr_ct) fr_ct --; else {
		use_ct ++;
		if (use_ct == 7) {
			if (containers_get) {
				//sfx_play (SFX_GET_ITEM, SC_LEVEL);
				if (flags [PLAYER_INV_FLAG] != flags [containers_get]) {
					rda = flags [PLAYER_INV_FLAG];
					flags [PLAYER_INV_FLAG] = flags [containers_get];
					flags [containers_get] = rda;
					commands_executed = 1;
				}
#ifdef CONTAINER_ACTION_STOPS_CHECKS
			} else {
#else
			}
			if (0 == commands_executed) {
#endif
				game_run_fire_script ();
			}
		}
		if (use_ct == 13 && !commands_executed) {
			use_ct = 0;
			pfacing = CELL_FACING_RIGHT;
			no_ct = ticks;
		}
		if (use_ct == 18) use_ct = 0;
		fr_ct = 6;
	}
} else if (guay_ct) {
	guay_ct --;
	if (guay_ct == 0) pflickering = ticks;
} else
