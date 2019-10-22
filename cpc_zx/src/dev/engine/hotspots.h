// MT MK3 OM v0.6 [Cheman]
// Copyleft 2017, 2019 by The Mojon Twins

// Hotspots

void hotspots_ini (void) {
	#asm
		#ifdef HOTSPOTS_MAY_CHANGE
			ld  hl, _hotspots
			ld  b, 0
			ld  d, 0
		._hotspots_ini_loop
			ld  a, (hl)
			inc hl
			inc hl
			push hl

			ld  e, b
			ld  hl, _ht
			add hl, de
			ld  (hl), a

			ld  hl, _hact
			ld  a, 1
			add hl, de
			ld  (hl), a

			pop hl

			inc b
			ld  a, b
			or  a
			cp  3
			jr  nz, _hotspots_ini_loop
		#else
			ld  hl, _hact
			ld  a, 1
			ld  b, MAX_PANTS
		._hotspots_ini_loop
			ld  (hl), a
			inc hl
			djnz _hotspots_ini_loop			
		#endif
	#endasm
}

void hotspots_paint (void) {
	#asm
			ld  a, (_hrt)
			or  a
			ret z

		#ifdef HOTSPOT_SIMPLE_SIGNS
			and 0xf
		#endif
			add HOTSPOTS_BASE_TILE
			ld  (__t), a

			ld  a, (_hry)
			srl a
			srl a
			srl a
			sub 2
			add SCR_Y
			ld  (__y), a

			ld  a, (_hrx)
			srl a
			srl a
			srl a
			add SCR_X
			ld  (__x), a
	#endasm

	DRAW_TILE_UPD ();
}

void hotspots_load (void) {
	#asm
			ld  de, (_n_pant)
			ld  d, 0
			ld  hl, _hact
			add hl, de
			ld  a, (hl)
			or  a
			jp  z, _hotspots_load_reset

		#ifdef HOTSPOTS_MAY_CHANGE
			ld  de, (_n_pant)
			ld  d, 0
			ld  hl, _hrt
			add hl, de
			ld  a, (hl)

			ld  (_hrt), a
			ld  a, (_n_pant)
			sla a 
			inc a
			ld  e, a
			ld  d, 0
			ld  hl, _hotspots
			add hl, de
			ld  a, (hl)
			
		#else
			ld  a, (_n_pant)
			sla a
			ld  e, a
			ld  d, 0
			ld  hl, _hotspots
			add hl, de
			ld  a, (hl)
			inc hl
			ld  (_hrt), a
			ld  a, (hl)
			
		#endif

			ld  c, a
			and 0xf0
			ld  (_hry), a
			ld  a, c
			sla a
			sla a
			sla a
			sla a
			ld  (_hrx), a

			jp _hotspots_paint 

		._hotspots_load_reset
			xor a
			ld  (_hrt), a
			ret
	#endasm
}

void hotspots_do (void) {
	#asm
			ld  a, (_hrt)
			or  a
			ret z 

			// Check collision
			ld  a, (_prx)
			ld  (_cx1), a
			ld  a, (_pry)
			ld  (_cy1), a
			ld  a, (_hrx)
			ld  (_cx2), a
			ld  a, (_hry)
			ld  (_cy2), a
			call _collide  ; -> L

			xor a
			or  l
			ret z

		#ifdef HOTSPOTS_LOGIC_MORE_COMPLEX
			ld  a, 1
			ld  (_rda), a
		#endif

			ld  a, (_hrt)
		#ifdef HOTSPOT_SIMPLE_SIGNS
			and 0xf
		#endif

		._hotspots_do_selector
		#ifdef HOTSPOT_TYPE_REFILL
			cp  HOTSPOT_TYPE_REFILL
			jp  z, _hotspots_do_type_refill
		#endif

		#ifdef HOTSPOT_TYPE_OBJECT
			cp  HOTSPOT_TYPE_OBJECT
			jp  z, _hotspots_do_type_object
		#endif

		#ifdef HOTSPOT_TYPE_KEY
			cp  HOTSPOT_TYPE_KEY
			jp  z, _hotspots_do_type_key
		#endif

		#ifdef HOTSPOT_TYPE_AMMO
			cp  HOTSPOT_TYPE_AMMO
			jp  z, _hotspots_do_type_ammo
		#endif

		#ifdef HOTSPOT_SIMPLE_SIGNS
			cp  HOTSPOT_SIMPLE_SIGNS
			jp  z, _hotspots_do_simple_signs
		#endif

		#ifdef HOTSPOT_TYPE_CLOTHES
			cp HOTSPOT_TYPE_CLOTHES
			jp  z, _hotspots_do_clothes
		#endif

			jp  _hotspots_do_selector_done

		#ifdef HOTSPOT_TYPE_REFILL
		._hotspots_do_type_refill
			ld  a, (_plife)
			add LIFE_REFILL
			cp  99
			jp  c, _hotspots_do_type_refill_done
			ld  a, 99
		._hotspots_do_type_refill_done
			ld  (_plife), a

			jp _hotspots_do_selector_done
		#endif

		#ifdef HOTSPOT_TYPE_OBJECT
		._hotspots_do_type_object
			#ifdef ONLY_ONE_OBJECT_FLAG
				ld  a, (_flags + ONLY_ONE_OBJECT_FLAG)
				or  a
				jp  z, _hotspots_do_type_object_not_set
				xor a
				ld  (_rda), a
				jr _hotspots_do_type_object_one_done				
			._hotspots_do_type_object_not_set
				ld  a, 1
				ld  (_flags + ONLY_ONE_OBJECT_FLAG), a
			._hotspots_do_type_object_one_done
			#else
				ld  a, (_pobjs)
				inc a
				ld  (_pobjs), a
			#endif

			jp _hotspots_do_selector_done
		#endif

		#ifdef HOTSPOT_TYPE_KEY
		._hotspots_do_type_key
			ld  a, (_pkeys)
			inc a
			ld  (_pkeys), a

			jp _hotspots_do_selector_done
		#endif

		#ifdef HOTSPOT_TYPE_AMMO
		._hotspots_do_type_ammo
			ld  a, (_pammo)
			ld  c, a
			ld  a, AMMO_MAX
			sub c
			ld  c, AMMO_REFILL
			cp  c
			jr  c, _hotspots_to_type_ammo_maximize
			ld  a, (_pammo)
			add AMMO_REFILL
			jr _hotspots_to_type_ammo_done
		.__hotspots_to_type_ammo_maximize
			ld  a, AMMO_MAX			

		._hotspots_to_type_ammo_done	
			ld (_pammo), a

			jp _hotspots_do_selector_done
		#endif

		#ifdef HOTSPOT_SIMPLE_SIGNS
		._hotspots_do_simple_signs
			// TODO
			#endasm
				if (CONTROLLER_DOWN (pad)) {
					rdt = hrt >> 4;
					text_window ();
				}
				rda = 0;
			#asm

			jp _hotspots_do_selector_done
		#endif

		#ifdef HOTSPOT_TYPE_CLOTHES
		._hotspots_do_clothes
			xor a
			ld  (_pnude), a

			#ifdef PLAYER_FLICKERS
				ld  a, PLAYER_FLICKERS
				ld  (_pflickering), a
			#endif

			jp _hotspots_do_selector_done
		#endif

		._hotspots_do_selector_done

		#ifdef HOTSPOTS_LOGIC_MORE_COMPLEX
			ld  a, (_rda)
			or  a
			ret z
		#endif

		#endasm
			SFX_PLAY (SFX_ITEM);
		#asm

			// Delete hotspot

			ld  a, (_hry)
			srl a
			srl a
			srl a
			srl a
			dec a
			ld  (__y), a

			ld  a, (_hrx)
			srl a
			srl a
			srl a
			srl a
			ld  (__x), a

		#ifdef HOTSPOTS_RESTORE_WITH_MAP_DATA
			ld  a, (_hry)
			and 0xf0
			sub 0x10
			ld  c, a
			ld  a, (__x)
			or  c
			ld  e, a
			ld  d, 0
			ld  hl, _scr_buff
			add hl, de
			ld  a, (hl)
		#else
			xor a
		#endif

			ld  (__t), a

			call _set_map_tile ();

			ld  de, (_n_pant)
			ld  d, 0
			ld  hl, _hact
			add hl, de
			xor a
			ld  (hl), a
			ld  (_hrt), a
	#endasm

}
