// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

#ifdef CPC
	if (!ppossee && !pgotten) {
		psprid = CELL_JUMP;
	} else if (ABS (pvx) > PLAYER_VX_MIN) {
		psprid = CELL_WALK_BASE + ((prx >> 4) & 3);
	} else psprid = CELL_IDLE;

	psprid += pfacing;
#endif

#ifdef SPECCY
	if (!ppossee && !pgotten) {
		psprid = CELL_JUMP + pfacing;
	} else if (ABS (pvx) > PLAYER_VX_MIN) {
		pstep = (pstep + 1) & 7; if (pstep == 0) {
			++ pframe; if (pframe == 3) pframe = 0;
		}
		psprid = CELL_WALK_BASE + pframe + pfacing;
	} else psprid = CELL_IDLE;
#endif