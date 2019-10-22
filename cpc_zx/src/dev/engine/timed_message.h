// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// A simple timed message.

void timed_message_vars (void) {
	_x  = TM_X; _y  = TM_Y; rdc = TM_ATTR;
}

void timed_message_do (void) {
	if (tm_ctr) {
		tm_ctr --;
		if (0 == tm_ctr) {
			timed_message_vars ();
#ifdef SPECCY
			p_s (TM_ERASE);
#endif
#ifdef CPC
			p_s_upd (TM_ERASE);
#endif
		}
	}
}

void timed_message_print (unsigned char *m) {
	timed_message_vars ();
#ifdef SPECCY
	p_s (m);
#endif
#ifdef CPC
	p_s_upd (m);
#endif
	tm_ctr = TM_FRAMES;
}
