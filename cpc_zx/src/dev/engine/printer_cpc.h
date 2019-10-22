// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Printer

void _pal_set (unsigned char *s) {
	gpit = 16; while (gpit --) cpc_SetColour (gpit, s[gpit]);
}

void _tile_address (void) {
	#asm
			ld  a, (__y)

			add a, a	; 2		4
			add a, a	; 4		4
			add a, a	; 8		4
			ld  h, 0	;		2
			ld  l, a 	;		4
			add hl, hl  ; 16	11
			add hl, hl  ; 32	11
			;					44 t-states

			; HL = _y * 32

			ld 	a, (__x)
			ld 	e, a 
			ld 	d, 0
			add hl, de

			; HL = _y * 32 + _x

			ld  de, _nametable
			add hl, de
			
			ex  de, hl

			; DE = buffer address
	#endasm
}

void p_s (unsigned char *s) {
	#asm
			ld  a, (__x)
			ld  (_rdxx), a

			ld  a, (__y)
			ld  (_rdyy), a

			call __tile_address	; DE = buffer address

			pop bc 		// discard return address
			pop hl 		// this is *s
			push hl
			push bc 	// Put everything back in place

		._p_s_loop
			ld  a, (hl)
			or  a
			jr  z, _p_s_restore_and_return

			inc hl

			cp  0x2f	// ASCII for '/'
			jr  nz, _p_s_draw_pattern

			// Skip to next line
			ld  a, (_rdxx)
			ld  (__x), a

			ld  a, (__y)
			inc a
			ld  (__y), a
			
			push hl
			call __tile_address	; DE = buffer address
			pop  hl

			jr  _p_s_loop

		._p_s_draw_pattern
			sub 32
			ld  (de), a
			inc de

			jr  _p_s_loop

		._p_s_restore_and_return
			ld  a, (_rdxx)
			ld  (__x), a

			ld  a, (_rdyy)
			ld  (__y), a
	#endasm
}

void p_t2 (void) {
	/*
	DRAW_PATTERN_UPD (_x ++, _y, _t, DIGIT(_n/10));
	DRAW_PATTERN_UPD (_x   , _y, _t, DIGIT(_n%10));
	*/

	_d1 = DIGIT(_n/10);
	_d2 = DIGIT(_n%10); 

	#asm
			call __tile_address	; DE = buffer address

			ld  a, (__d1)
			ld  (de), a
			inc de

			ld  a, (__d2)
			ld  (de), a
			inc de

			ld  a, (__x)
			ld  e, a 
			ld  a, (__y) 
			ld  d, a
			call cpc_UpdTileTable
			inc  e 
			call cpc_UpdTileTable
	#endasm
}

void draw_tile (void) {
	#asm
			call __tile_address ; DE = buffer address

			ld  a, (__t)
			sla a 
			sla a
			ld  l, a 
			ld  h, 0
			ld  bc, _tsmaps
			add hl, bc

			; HL = metatile address

			ld  a, (__y)
			cp  SCR_Y+22

			; Draw just the top row
			jr  z, _hwa_draw_tile_b1

			cp  SCR_Y
			jr  nz, _hwa_draw_tile_b2

			; Draw just the bottom row
			inc hl
			inc hl
			ex  de, hl
			ld  bc, 32
			add hl, bc
			ex  de, hl
			jr  _hwa_draw_tile_b1

		._hwa_draw_tile_b2
			ldi
			ldi

			ld  bc, 30
			ex  de, hl
			add hl, bc
			ex  de, hl
		._hwa_draw_tile_b1
			ldi 
			ldi
	#endasm
}

void draw_tile_upd (void) {
	// First draw, then invalidate
	draw_tile ();
	#asm
			XREF cpc_UpdTileTable
			ld  a, (__x)
			ld  e, a 
			ld  a, (__y) 
			ld  d, a

			cp SCR_Y + 22
			
			; invalidate just the top row
			jr  z, _hwa_draw_tile_upd_b1

			cp SCR_Y
			jr  z, _hwa_draw_tile_upd_b2
		
			call cpc_UpdTileTable
			inc  e 
			call cpc_UpdTileTable
			dec  e
		._hwa_draw_tile_upd_b2
			inc d 
		._hwa_draw_tile_upd_b1
			call cpc_UpdTileTable
			inc  e 
			call cpc_UpdTileTable
	#endasm
}

#ifdef SPECCY
void all_sprites_out (void) {
	gpit = SW_SPRITES_ALL; while (gpit-- > rda) { if (spr_on [gpit]) SPRITE_OUT (gpit); }
}
#endif

void __FASTCALL__ cpc_clear_rect (unsigned char which) {
	#asm
		._cpc_clear_rect_whole_area
			ld  hl, _nametable
			ld  de, _nametable + 1
			ld  bc, 767
			ld  (hl), 0
			ldir
	#endasm
}

/*
void cpc_screen_update (void) {
	// Just 1 loop of bubble sort will suffice
	for (gpit = 0; gpit < SW_SPRITES_ALL - 1; gpit ++) {
		if (sp_sw [rda = spr_order [gpit]].cy > sp_sw [rdb = spr_order [gpit+1]].cy) {
			spr_order [gpit] = rdb;
			spr_order [gpit + 1] = rda;
		}
	}

	for (gpit = 0; gpit < SW_SPRITES_ALL; gpit ++) {
		(sp_sw [gpit].invfunc) ((int) (&sp_sw [gpit]));
	}

	cpc_UpdScr ();

	for (gpjt = 0; gpjt < SW_SPRITES_ALL; gpjt ++) {
		gpit = spr_order [gpjt];
		(sp_sw [gpit].updfunc) ((int) (&sp_sw [gpit]));
	}

	cpc_ShowTouchedTiles ();
	cpc_ResetTouchedTiles ();
}
*/

void cpc_screen_update (void) {
	// SPR struct is 16 bytes wide. So iteration is simple
	// if you write your code by hand ... 

	#asm

	#ifdef PLAYER_GENITAL
		// Just 1 loop of bubble sort will suffice

			ld  b, SW_SPRITES_ALL-1
		._cpc_screen_update_sort
			dec b

			ld  d, 0
			ld  e, b
			ld  hl, _spr_order
			add hl, de
			ld  a, (hl)
			ld  (_rda), a 			; rda = spr_order [gpit]

			// SW_SPRITES_ALL will be at very most = 16,
			// so we can multiply by 16 safely in 8 bits.
			sla a
			sla a
			sla a
			sla a

			// Let's point to sp_sw [rda].cy (cy is offset 9).
			add 9

			ld  e, a
			ld  hl, _sp_sw
			add hl, de
			ld  c, (hl) 			; C = sp_sw [rda].cy

			ld  d, 0
			ld  e, b
			inc e
			ld  hl, _spr_order
			add hl, de
			ld  a, (hl)
			ld  (_rdb), a 			; rdb = spr_order [gpit + 1]

			// SW_SPRITES_ALL will be at very most = 16,
			// so we can multiply by 16 safely in 8 bits.
			sla a
			sla a
			sla a
			sla a

			// Let's point to sp_sw [rdb].cy (cy is offset 9).
			add 9

			ld  e, a
			ld  hl, _sp_sw
			add hl, de
			ld  a, (hl) 			; A = sp_sw [rdb].cy
			
			cp  c
			jr  c, _cpc_screen_update_swap
			jr  _cpc_screen_update_sort_continue

		._cpc_screen_update_swap
			// spr_order [gpit] = rdb;
			// spr_order [gpit + 1] = rda;
			ld  d, 0
			ld  e, b
			ld  hl, _spr_order;
			add hl, de
			ld  a, (_rdb)
			ld  (hl), a
			inc hl
			ld  a, (_rda)
			ld  (hl), a

		._cpc_screen_update_sort_continue
			ld  a, b
			or  a
			jr  nz, _cpc_screen_update_sort

	#endif

		// Call the invalidate function for all sprites 

		/*
		for (gpit = 0; gpit < SW_SPRITES_ALL; gpit ++) {
			(sp_sw [gpit].invfunc) ((int) (&sp_sw [gpit]));
		}
		*/

			ld  b, 0
		._cpc_screen_update_inv_loop
			push bc
			// SW_SPRITES_ALL will be at very most = 16,
			// so we can multiply by 16 safely in 8 bits.
			ld  a, b
			sla a
			sla a
			sla a 
			sla a
			ld d, 0
			ld e, a
			ld  hl, _sp_sw
			add hl, de

			// Save paremeter
			ld  b, h
			ld  c, l

			// Push return address into stack
			ld  de, _cpc_screen_update_inv_ret
			push de

			// Push function pointer into stack
			// Offset 12 into the structure: invfunc
			ld  de, 12
			add hl, de
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			push de

			// __fastcall__ expects parameter in HL
			ld  h, b
			ld  l, c

			// ret will pop the function pointer from the
			// stack and jp to it. Next ret will get to 
			// _cpc_screen_update_inv_ret
			ret

		._cpc_screen_update_inv_ret
			pop bc
			inc b
			ld  a, b
			cp  SW_SPRITES_ALL
			jr  nz, _cpc_screen_update_inv_loop

		._cpc_screen_update_upd_buffer
			call cpc_UpdScr 

		// Call the drawing function for all sprites

		/*
			for (gpjt = 0; gpjt < SW_SPRITES_ALL; gpjt ++) {
				gpit = spr_order [gpjt];
				(sp_sw [gpit].updfunc) ((int) (&sp_sw [gpit]));
			}
		*/	
			ld  b, SW_SPRITES_ALL
		._cpc_screen_update_upd_loop
			dec b
			push bc
			#ifdef PLAYER_GENITAL
				ld  d, 0
				ld  e, b
				ld  hl, _spr_order
				add hl, de
				ld  a, (hl)
			#else
				ld  a, b
			#endif

			// SW_SPRITES_ALL will be at very most = 16,
			// so we can multiply by 16 safely in 8 bits.
			sla a
			sla a
			sla a 
			sla a
			ld d, 0
			ld e, a
			ld  hl, _sp_sw
			add hl, de

			// Save paremeter
			ld  b, h
			ld  c, l

			// Push return address into stack
			ld  de, _cpc_screen_update_upd_ret
			push de

			// Push function pointer into stack
			// Offset 12 into the structure: updfunc
			ld  de, 14
			add hl, de
			ld  e, (hl)
			inc hl
			ld  d, (hl)
			push de

			// __fastcall__ expects parameter in HL
			ld  h, b
			ld  l, c

			// ret will pop the function pointer from the
			// stack and jp to it. Next ret will get to 
			// _cpc_screen_update_inv_ret
			ret

		._cpc_screen_update_upd_ret
			pop bc
			xor a
			or  b
			jr  nz, _cpc_screen_update_upd_loop

		._cpc_screen_update_show
			call cpc_ShowTouchedTiles
			jp   cpc_ResetTouchedTiles

	#endasm
}

void cpc_show_updated (void) {
	cpc_UpdScr ();
	cpc_ShowTouchedTiles ();
	cpc_ResetTouchedTiles ();
}

#ifdef ENABLE_TIMED_MESSAGE
	void p_s_upd (unsigned char *s) {
		rdxx = _x; rdyy = _y;
		while (*s) {
			rdch = *s ++;
			if (rdch == '/') { rdxx = _x; rdyy ++; } else {
				cpc_SetTouchTileXY (rdxx ++, rdyy, rdch - 32);
			}
		}
	}
#endif

void unrle_adv (void) {
	nametable [gpint ++] = rdb;
}

void unrle (void) {
	rdc = *gp_aux ++; 	// run code
	gpint = 0; while (gpint < 768) {
		rda = *gp_aux ++;
		if (rda == rdc) {
			rda = *gp_aux ++;
			if (rda == 0) break;
			while (rda --) unrle_adv ();
		} else {
			rdb = rda;
			unrle_adv ();
		}
	}
}
