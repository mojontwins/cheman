// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Printer

#ifdef SPECCY
	#include "engine/printer_speccy.h"
	#define DRAW_TILE 		draw_tile
	#define DRAW_TILE_UPD	draw_tile
#endif
#ifdef CPC
	#include "engine/printer_cpc.h"
	#define DRAW_TILE 		draw_tile
	#define DRAW_TILE_UPD	draw_tile_upd
#endif

void set_map_tile (void) {
	#asm
		ld  a, (__y)
		sla a
		sla a
		sla a
		sla a
		ld  c, a
		ld  a, (__x)
		or  c
		ld  (_rdf), a

		ld  de, (__t)
		ld  d, 0
		ld  hl, _behs
		add hl, de
		ld  a, (hl)

		ld  de, (_rdf)
		ld  d, 0
		ld  hl, _scr_attr
		add hl, de
		ld  (hl), a

		ld  a, (__t)
		ld  hl, _scr_buff
		add hl, de
		ld  (hl), a

		ld  a, (__x)
		sla a
		add SCR_X
		ld  (__x), a

		ld  a, (__y)
		sla a
		add SCR_Y
		ld (__y), a
	#endasm

	DRAW_TILE_UPD ();
}

void draw_tile_advance (void) {
	DRAW_TILE ();
	#asm
		ld  a, (_flip_flop)
		xor 1
		ld  (_flip_flop), a
		ld  a, (__x)
		add 2
		cp  MAP_CHARSW+SCR_X
		jr  nz, _draw_tile_advance_no_next_line
		ld  a, (__y)
		add 2
		ld  (__y), a
		srl a
		and 1
		ld  (_flip_flop), a
		ld  a, SCR_X

	._draw_tile_advance_no_next_line
		ld  (__x), a
	#endasm
}

/*
const unsigned char alt_tile [] = {
	16, 1, 4, 8, 4, 21, 6, 7, 8, 9, 10, 20, 12, 13, 14, 15
};
*/
void advance_worm (void) {
	_t = rdt;

	// CUSTOM { Does not apply for this game
	if (level == 1 && _t == 11 && flip_flop) _t = 0;
	// } END_OF_CUSTOM;

	rda = behs [_t];
	#ifdef FLOATY_PUSH_BOXES
		scr_buff [gpit] = (rda & PUSHABLE_BEH) ? FLOATY_PUSH_BOXES_SUBST : _t;
	#else	
		scr_buff [gpit] = _t; 
	#endif	

	scr_attr [gpit] = rda;
	draw_tile_advance (); gpit ++;
}

void scr_rand (void) {
	// Set random seed
	seed1 [0] = n_pant; seed2 [0] = n_pant + 69; srand ();
}

void draw_scr (void) {
	#ifdef CPC
		cpc_ResetTouchedTiles ();
	#endif	

	scr_rand ();

	// Find address
	gp_map = map_base_address ();

	#ifdef MAP_FORMAT_RLE44
		gpit = 0; _x = SCR_X; _y = SCR_Y;
		while (gpit < SCR_BUFFER_SIZE) {
			rdt = *gp_map ++;
			rdct = 1 + (rdt >> 4);
			rdt &= 0x0f;
			while (rdct --) advance_worm ();
		}
	#endif

	#ifdef MAP_FORMAT_RLE53	
		#asm
		._draw_scr_rle53
			xor a
			ld  (_gpit), a
			ld  a, SCR_X
			ld  (__x), a
			ld  a, SCR_Y
			ld  (__y), a

		._draw_scr_loop
			ld  a, (_gpit)
			cp  SCR_BUFFER_SIZE
			;jr  nc, _draw_scr_loop_done
			jr  z, _draw_scr_loop_done

			ld  hl, (_gp_map)
			ld  a, (hl)
			inc hl
			ld  (_gp_map), hl
			
			ld  c, a
			and 0x1f
			ld  (_rdt), a

			ld  a, c
			ld  (_rdct), a

		._draw_scr_advance_loop
			ld  a, (_rdct)
			cp  32
			jr  c, _draw_scr_advance_loop_done
			sub 32
			ld  (_rdct), a

			call _advance_worm
					
			jr _draw_scr_advance_loop

		._draw_scr_advance_loop_done
			call _advance_worm

			jr _draw_scr_loop

		._draw_scr_loop_done
		#endasm
	#endif

	#ifdef MAP_FORMAT_PACKED
		gpit = 0; _x = SCR_X; _y = SCR_Y; rde = 1;
		while (gpit < SCR_BUFFER_SIZE) {
			rdt = (*gp_map) >> 4; advance_worm ();
			rdt = (*gp_map) & 0x0f; advance_worm ();
			gp_map ++;
		}
	#endif

	#ifdef PERSISTENT_TILE_GET
		_t = TILE_GET_CLEAR_TILE; gpjt = 0;
		gpit = tile_got_offset = (n_pant << 3) + (n_pant << 2);
		for (_y = SCR_Y; _y < 24 + SCR_Y; _y += 2) {
			for (_x = 0; _x < 32; ) {
				if (tile_got [gpit] & bitmask [_x >> 2]) {
					DRAW_TILE (); _x += 2; scr_attr [gpjt] = 0; ++ gpjt;
					DRAW_TILE (); _x += 2; scr_attr [gpjt] = 0; ++ gpjt;
				} else { _x += 4; gpjt += 2; }				
			}
			++ gpit;
		}
	#endif
}

void draw_scr_buffer (void) {
	#ifdef CPC
		cpc_ResetTouchedTiles ();
	#endif	

	scr_rand ();

	gpit = 0; _x = SCR_X; _y = SCR_Y;
	gp_map = scr_buff;
	while (gpit < 160) {
		_t = scr_buff [gpit ++];
		draw_tile_advance ();
	}

	#ifdef CPC
		cpc_ShowTileMap (0);
	#endif	
}


#ifdef DEBUG
	unsigned char hexd (unsigned char n) {
		if (n < 10) return DIGIT(n);
		return 'A'-10+n-32;
	}

	void p_hex (unsigned char x, unsigned char y, unsigned char n) {
		DRAW_PATTERN_UPD (x ++, y, 71, hexd(n >> 4));
		DRAW_PATTERN_UPD (x   , y, 71, hexd(n & 0xf));
	}
#endif
