// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Misc stuff

#ifdef SPECCY
void pad_read (void) {
	// Thanks for this, Nicole & nesdev!
	// https://forums.nesdev.com/viewtopic.php?p=179315#p179315
	pad_this_frame = pad0;
	pad0 = ((joyfunc) (&keys));			// Read pads here.
	pad_this_frame = (pad_this_frame ^ pad0) & pad0;
}
#endif

unsigned char *map_base_address (void) {
#ifdef MAP_FORMAT_NOINDEX
	#ifdef MAP_FORMAT_PACKED
		return (unsigned char *) (map + n_pant * 96);
	#else
		return (unsigned char *) (map + n_pant * 192);
	#endif
#else
	/*
	rdc = n_pant << 1;
	rda = *(map + rdc); rdb = *(map + rdc + 1);
	return (unsigned char *) (map + ((rdb << 8) | rda));
	*/
	#asm
		ld  a, (_n_pant)
		sla a
		ld  d, 0
		ld  e, a
		ld  hl, _map
		add hl, de 		; HL = map + (n_pant << 1)
		ld  e, (hl)
		inc hl
		ld  d, (hl) 	; DE = index
		ld  hl, _map
		add hl, de      ; HL = map + index
	#endasm
#endif
}

#ifdef MAP_FORMAT_PACKED
void map_tile_address_packed (void) {
	rdi = rdx + (rdy + (rdy << 1) + (rdy << 2) + (rdy << 3));
	gp_map = map_base_address ();
	gp_gen = gp_map + (rdi >> 1);
}
#endif

void alter_map (void) {
#ifdef MAP_FORMAT_PACKED
	map_tile_address_packed ();
	rda = *gp_gen;
	if (rdi & 1) rda = (rda & 0xf0) | rdt; 
	else rda = (rda & 0x0f) | (rdt << 4);
	*gp_gen = rda;
#endif

#ifdef MAP_FORMAT_UNPACKED
	*((unsigned char *) (map_base_address () + rdx + (rdy + (rdy << 1) + (rdy << 2) + (rdy << 3)))) = rdt;
#endif
}

void button_pressed (void) {
#ifdef SPECCY	
	return (sp_GetKey () || ((((joyfunc) (&keys)) & sp_FIRE) == 0));
#endif
#ifdef CPC
	return cpc_AnyKeyPressed ();
#endif
}

void wait_button (void) {
	while (button_pressed ());
	while (0==button_pressed ());
}

void delay (unsigned char cycles) {
#ifdef SPECCY
	isrc = 0;
	while (isrc < cycles);
#endif
#ifdef CPC
	isrc = 0;
	while (isrc < cycles);
#endif
}
