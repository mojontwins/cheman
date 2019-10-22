// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

	xor a
	ld  (_rdt), a
	ld  hl, _en_t
	add hl, de
	ld  (hl), a

#ifdef PERSISTENT_DEATHS
._enems_kill_store
	ld  a, (_enoffs)
	add b
	ld  e, a
	ld  d, 0
	ld  hl, _ep_killed
	add hl, de
	ld  a, 1
	ld  (hl), a
#endif

#ifdef COUNT_KILLED_ON_FLAG
	ld  a, (_flags + COUNT_KILLED_ON_FLAG)
	inc a
	ld  (_flags + COUNT_KILLED_ON_FLAG), a
#endif

	ld  a, (_pbodycount)
	inc a
	ld  (_pbodycount), a

#ifdef ENABLE_FABOLEES
	// TODO
#endif
	
