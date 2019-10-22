;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Mon Sep 30 11:43:45 2019



	MODULE	mk3.c


	INCLUDE "z80_crt0.hdr"


;	SECTION	text

._my_inks
	defm	""
	defb	19

	defm	""
	defb	3

	defm	""
	defb	21

	defm	""
	defb	22

	defm	""
	defb	18

	defm	""
	defb	25

	defm	""
	defb	12

	defm	""
	defb	14

	defm	""
	defb	7

	defm	""
	defb	28

	defm	""
	defb	0

	defm	""
	defb	11

	defm	""
	defb	4

	defm	""
	defb	24

	defm	""
	defb	5

	defm	""
	defb	20

;	SECTION	code


;	SECTION	text

._my_inks2
	defm	""
	defb	19

	defm	""
	defb	3

	defm	""
	defb	21

	defm	""
	defb	22

	defm	""
	defb	18

	defm	""
	defb	25

	defm	""
	defb	12

	defm	""
	defb	14

	defm	""
	defb	7

	defm	""
	defb	28

	defm	""
	defb	6

	defm	""
	defb	11

	defm	""
	defb	4

	defm	""
	defb	24

	defm	""
	defb	5

	defm	""
	defb	20

;	SECTION	code


	._trpixlutc
	BINARY "../ports/cpc/bin/trpixlutc.bin"
	._m0_c
	BINARY "../ports/cpc/bin/m0.c.bin"
	._level0_map_c
	BINARY "../ports/cpc/bin/level0/map.c.bin"
	._level0_locks_c
	BINARY "../ports/cpc/bin/level0/locks.c.bin"
	._level0_enems_c
	BINARY "../ports/cpc/bin/level0/enems.c.bin"
	._level0_hotspots_c
	BINARY "../ports/cpc/bin/level0/hotspots.c.bin"
	._level0_ts_patterns_c
	BINARY "../ports/cpc/bin/level0/ts.patterns.c.bin"
	._level0_ts_tilemaps_c
	BINARY "../ports/cpc/bin/level0/ts.tilemaps.c.bin"
	._level0_behs_c
	BINARY "../ports/cpc/bin/level0/behs.c.bin"
	._level1_map_c
	BINARY "../ports/cpc/bin/level1/map.c.bin"
	._level1_enems_c
	BINARY "../ports/cpc/bin/level1/enems.c.bin"
	._level1_hotspots_c
	BINARY "../ports/cpc/bin/level1/hotspots.c.bin"
	._level1_ts_patterns_c
	BINARY "../ports/cpc/bin/level1/ts.patterns.c.bin"
	._level1_ts_tilemaps_c
	BINARY "../ports/cpc/bin/level1/ts.tilemaps.c.bin"
	._level1_behs_c
	BINARY "../ports/cpc/bin/level1/behs.c.bin"
;	SECTION	text

._library
	defw	0
	defw	_trpixlutc
	defw	_m0_c
	defw	_level0_map_c
	defw	_level0_locks_c
	defw	_level0_enems_c
	defw	_level0_hotspots_c
	defw	_level0_ts_patterns_c
	defw	_level0_ts_tilemaps_c
	defw	_level0_behs_c
	defw	_level1_map_c
	defw	_level1_enems_c
	defw	_level1_hotspots_c
	defw	_level1_ts_patterns_c
	defw	_level1_ts_tilemaps_c
	defw	_level1_behs_c

;	SECTION	code

	;; Patterns and tilemaps for the metatileset
	XDEF _ts
	XDEF tiles
	._ts
	.tiles
	BINARY "../ports/cpc/bin/ts.bin" ; 64 patterns (512 bytes)
	._ts0
	defs 1536 ; space for 96 patterns (1536 bytes)
	._tsmaps
	; Space to define up to 48 metatiles (384 bytes).
	; defs 384
	defs 384
	._behs
	; Space to describe up to 48 metatiles (48 bytes).
	; defs 48
	; In this game, there is only one level.
	defs 48
	;; Sprite cells
	._ss_main
	; First, space for / include the main characters
	; 12 cells, 96 bytes each
	BINARY "../ports/cpc/bin/ssch.bin"
	._ss_empty
	; a 100% transparent sprite
	BINARY "../ports/cpc/bin/ssempty.bin"
	._ss_enems
	; Second, space for the enemies / etc.
	; 0 masked cells (144 * EXTRA_SPRITES)
	; defs 0 * 64
	; 6 cells, 96 bytes each
	BINARY "../ports/cpc/bin/ssen.bin"
	._ss_extra
	; Third, assorted extra stuff
	; 2 cells, 96 bytes
	BINARY "../ports/cpc/bin/ssextra.bin"
	._ss_pumpkin
	BINARY "../ports/cpc/bin/sspumpkin.bin"
	._ss_small
	; Small sprites
	; defs 1 * 64
	; 1 cell, 16 bytes
	BINARY "../ports/cpc/bin/sssmall.bin"
	;; Map data + index
	._map
	defs 1900 ; should be enough!
	._locks
	; You can adjust the amount of reserved bytes to the size of your
	; biggest set of locks.
	; defs 16
	defs 12 ; make room for 6 locks
	;; Enems data + index
	._enems
	; You can adjust the amount of reserved bytes to the size of you.
	; biggest set of enemies.
	; defs 20*12
	defs 20*12 ; 20 rooms, 3 enems per room, 4 bytes each
	;; Hotspots
	._hotspots
	; reserve two bytes per screen
	;defs 2*20
	defs 20*2 ; 20 rooms, 2 bytes per room
	;; Fixed screens
	._title_rle
	BINARY "../ports/cpc/bin/title.rle.bin"
	._hud_rle
	BINARY "../ports/cpc/bin/hud.rle.bin"
	._ending_rle
	BINARY "../ports/cpc/bin/ending.rle.bin"
;	SECTION	text

._level0
	defm	""
	defb	0

	defm	""
	defb	13

	defm	""
	defb	3

	defm	""
	defb	19

	defm	""
	defb	5

	defm	""
	defb	15

	defm	""
	defb	3

	defm	""
	defb	4

	defm	""
	defb	5

	defm	""
	defb	6

	defm	""
	defb	9

	defm	""
	defb	7

	defm	""
	defb	8

	defm	""
	defb	25

;	SECTION	code


;	SECTION	text

._level1
	defm	""
	defb	0

	defm	""
	defb	9

	defm	""
	defb	3

	defm	""
	defb	16

	defm	""
	defb	4

	defm	""
	defb	15

	defm	""
	defb	10

	defm	""
	defb	0

	defm	""
	defb	11

	defm	""
	defb	12

	defm	""
	defb	15

	defm	""
	defb	13

	defm	""
	defb	14

	defm	""
	defb	25

;	SECTION	code


;	SECTION	text

._levels
	defw	_level0
	defw	_level1

;	SECTION	code

	._sprite_cells
	defw _ss_main + 0x0000
	defw _ss_main + 0x0060
	defw _ss_main + 0x00c0
	defw _ss_main + 0x0120
	defw _ss_main + 0x0180
	defw _ss_main + 0x01e0
	defw _ss_main + 0x0240
	defw _ss_main + 0x02a0
	defw _ss_main + 0x0300
	defw _ss_main + 0x0360
	defw _ss_main + 0x03c0
	defw _ss_main + 0x0420
	defw _ss_empty + 0x0000
	defw _ss_enems + 0x0000
	defw _ss_enems + 0x0060
	defw _ss_enems + 0x00c0
	defw _ss_enems + 0x0120
	defw _ss_enems + 0x0180
	defw _ss_enems + 0x01e0
	defw _ss_extra + 0x0000
	defw _ss_extra + 0x0060
	defw _ss_pumpkin + 0x0000
	defw _ss_small + 0x0000
;	SECTION	text

._jitter_big
	defm	""
	defb	255

	defm	""
	defb	255

	defm	""
	defb	255

	defm	""
	defb	252

	defm	""
	defb	4

	defm	""
	defb	253

	defm	""
	defb	0

	defm	""
	defb	252

	defm	""
	defb	254

	defm	""
	defb	3

	defm	""
	defb	253

	defm	""
	defb	2

	defm	""
	defb	1

	defm	""
	defb	255

	defm	""
	defb	0

	defm	""
	defb	254

;	SECTION	code


;	SECTION	text

._bitmask
	defm	""
	defb	1

	defm	""
	defb	2

	defm	""
	defb	4

	defm	""
	defb	8

	defm	""
	defb	16

	defm	" @"
	defb	128

;	SECTION	code


;	SECTION	text

._dss_msb_ox
	defm	""
	defb	0

	defm	""
	defb	255

	defm	""
	defb	255

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	255

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._dss_msb_oy
	defm	""
	defb	0

	defm	""
	defb	255

	defm	""
	defb	255

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	255

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._dss_msb_invfunc
	defw	0,0,0,0,0,0,0,0,0,0
	defw	0,0,0,0,0,0
;	SECTION	code


;	SECTION	text

._dss_msb_updfunc
	defw	0,0,0,0,0,0,0,0,0,0
	defw	0,0,0,0,0,0
;	SECTION	code


;	SECTION	text

._dss_lsb_ox
	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._dss_lsb_oy
	defm	""
	defb	250

	defm	""
	defb	248

	defm	""
	defb	248

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

	defm	""
	defb	0

;	SECTION	code


;	SECTION	text

._dss_lsb_invfunc
	defw	cpc_PutSpTileMap8x24
	defw	cpc_PutSpTileMap8x24
	defw	cpc_PutSpTileMap8x24
	defw	cpc_PutSpTileMap8x16
	defw	0,0,0,0,0,0,0,0,0,0
	defw	0,0
;	SECTION	code


;	SECTION	text

._dss_lsb_updfunc
	defw	cpc_PutTrSp8x24TileMap2b
	defw	cpc_PutTrSp8x24TileMap2b
	defw	cpc_PutTrSp8x24TileMap2b
	defw	cpc_PutTrSp8x16TileMap2b
	defw	0,0,0,0,0,0,0,0,0,0
	defw	0,0
;	SECTION	code


	; aPPack decompressor
	; original source by dwedit
	; very slightly adapted by utopian
	; optimized by Metalbrain
	;hl = source
	;de = dest
	.depack
	ld ixl,128
	.apbranch1
	ldi
	.aploop0
	ld ixh,1 ;LWM = 0
	.aploop
	call ap_getbit
	jr nc,apbranch1
	call ap_getbit
	jr nc,apbranch2
	ld b,0
	call ap_getbit
	jr nc,apbranch3
	ld c,16 ;get an offset
	.apget4bits
	call ap_getbit
	rl c
	jr nc,apget4bits
	jr nz,apbranch4
	ld a,b
	.apwritebyte
	ld (de),a ;write a 0
	inc de
	jr aploop0
	.apbranch4
	and a
	ex de,hl ;write a previous byte (1-15 away from dest)
	sbc hl,bc
	ld a,(hl)
	add hl,bc
	ex de,hl
	jr apwritebyte
	.apbranch3
	ld c,(hl) ;use 7 bit offset, length = 2 or 3
	inc hl
	rr c
	ret z ;if a zero is encountered here, it is EOF
	ld a,2
	adc a,b
	push hl
	ld iyh,b
	ld iyl,c
	ld h,d
	ld l,e
	sbc hl,bc
	ld c,a
	jr ap_finishup2
	.apbranch2
	call ap_getgamma ;use a gamma code * 256 for offset, another gamma code for length
	dec c
	ld a,c
	sub ixh
	jr z,ap_r0_gamma ;if gamma code is 2, use old r0 offset,
	dec a
	;do I even need this code?
	;bc=bc*256+(hl), lazy 16bit way
	ld b,a
	ld c,(hl)
	inc hl
	ld iyh,b
	ld iyl,c
	push bc
	call ap_getgamma
	ex (sp),hl ;bc = len, hl=offs
	push de
	ex de,hl
	ld a,4
	cp d
	jr nc,apskip2
	inc bc
	or a
	.apskip2
	ld hl,127
	sbc hl,de
	jr c,apskip3
	inc bc
	inc bc
	.apskip3
	pop hl ;bc = len, de = offs, hl=junk
	push hl
	or a
	.ap_finishup
	sbc hl,de
	pop de ;hl=dest-offs, bc=len, de = dest
	.ap_finishup2
	ldir
	pop hl
	ld ixh,b
	jr aploop
	.ap_r0_gamma
	call ap_getgamma ;and a new gamma code for length
	push hl
	push de
	ex de,hl
	ld d,iyh
	ld e,iyl
	jr ap_finishup
	.ap_getbit
	ld a,ixl
	add a,a
	ld ixl,a
	ret nz
	ld a,(hl)
	inc hl
	rla
	ld ixl,a
	ret
	.ap_getgamma
	ld bc,1
	.ap_getgammaloop
	call ap_getbit
	rl c
	rl b
	call ap_getbit
	jr c,ap_getgammaloop
	ret
	._ram_address
	defw 0
	._ram_destination
	defw 0

._unpack
	ld	de,_ram_address
	ld	hl,6-2	;const
	call	l_gintsp	;
	call	l_pint
	ld	de,_ram_destination
	ld	hl,4-2	;const
	call	l_gintsp	;
	call	l_pint
	di
	ld hl, (_ram_address)
	ld de, (_ram_destination)
	call depack
	ei
	ret


	._seed1 defw 0
	._seed2 defw 0
	._randres defb 0

._rand8
	.rnd
	ld hl,0xA280
	ld de,0xC0DE
	ld a,h ; t = x ^ (x << 1)
	add a,a
	xor h
	ld h,l ; x = y
	ld l,d ; y = z
	ld d,e ; z = w
	ld e,a
	rra ; t = t ^ (t >> 1)
	xor e
	ld e,a
	ld a,d ; w = w ^ ( w << 3 ) ^ t
	add a,a
	add a,a
	add a,a
	xor d
	xor e
	ld e,a
	ld (rnd+1),hl
	ld (rnd+4),de
	ld (_randres), a
	ld	hl,(_randres)
	ld	h,0
	ret



._srand
	ld hl, (_seed1)
	ld (rnd+1),hl
	ld hl, (_seed2)
	ld (rnd+4),hl
	ret



._map_base_address
	ld a, (_n_pant)
	sla a
	ld d, 0
	ld e, a
	ld hl, _map
	add hl, de ; HL = map + (n_pant << 1)
	ld e, (hl)
	inc hl
	ld d, (hl) ; DE = index
	ld hl, _map
	add hl, de ; HL = map + index
	ret



._alter_map
	ret



._button_pressed
	call	cpc_AnyKeyPressed
	ret



._wait_button
.i_19
	call	_button_pressed
	ld	a,h
	or	l
	jp	nz,i_19
.i_20
.i_21
	call	_button_pressed
	ld	a,h
	or	l
	jp	z,i_21
.i_22
	ret



._delay
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_isrc),a
.i_23
	ld	de,(_isrc)
	ld	d,0
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ult
	jp	c,i_23
.i_24
	ret



._librarian_get_resource
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_25
	ld	hl,_library
	push	hl
	ld	hl,6	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,4	;const
	call	l_gintsp	;
	push	hl
	call	_unpack
	pop	bc
	pop	bc
.i_25
	ret



._halt_me
	halt
	halt
	halt
	halt
	halt
	ret



._system_init
	di
	; Turn off arkos play routine
	ld a, 201 ; Insert a RET!
	ld (34868+0x000A), a
	ld a, 195
	ld (0x38), a
	ld hl,(0x0039)
	ld (_int_original),HL
	ld HL,_interrupcion
	ld (0x0039),HL
	jp term
	._int_original
	defw 0
	._interrupcion
	push af
	push bc
	push hl
	push de
	push ix
	push iy
	exx
	ex af, af
	push af
	push bc
	push de
	push hl
	ld a, (_isrc)
	inc a
	ld (_isrc), a
	.___reduce
	cp 6
	jr c, ___noreduce
	sub 6
	jr ___reduce
	.___noreduce
	;and 0x1f
	;or 0x40
	;ld bc, 0x7F10
	;out (c), c
	;out (c), a
	ld a, (_arkc)
	inc a
	cp 6
	jp nz, _noplayer
	call 34868+0x000A
	xor a
	._noplayer
	ld (_arkc), a
	pop hl
	pop de
	pop bc
	pop af
	ex af, af
	exx
	pop iy
	pop ix
	pop de
	pop hl
	pop bc
	pop af
	ei
	ret
	.term
	ld a, 0x54
	ld bc, 0x7F11
	out (c), c
	out (c), a
	ld	hl,1	;const
	push	hl
	ld	hl,65024	;const
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,_my_inks
	push	hl
	call	__pal_set
	pop	bc
	ld	hl,0	;const
	call	cpc_SetMode
	; Horizontal chars (32), CRTC REG #1
	ld b, 0xbc
	ld c, 1 ; REG = 1
	out (c), c
	inc b
	ld c, 32 ; VALUE = 32
	out (c), c
	; Horizontal pos (42), CRTC REG #2
	ld b, 0xbc
	ld c, 2 ; REG = 2
	out (c), c
	inc b
	ld c, 42 ; VALUE = 42
	out (c), c
	; Vertical chars (24), CRTC REG #6
	ld b, 0xbc
	ld c, 6 ; REG = 6
	out (c), c
	inc b
	ld c, 24 ; VALUE = 24
	out (c), c
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_26
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_27
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,10
	add	hl,bc
	ld	(hl),#(0 % 256 % 256)
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,9
	add	hl,bc
	push	hl
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,11
	add	hl,bc
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	pop	de
	ld	a,l
	ld	(de),a
	ld	de,_spr_order
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_gpit
	ld	a,(hl)
	ld	(de),a
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_28
	jp	nc,i_28
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_ss_main
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	push	hl
	ld	hl,_ss_main
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,12
	add	hl,bc
	push	hl
	ld	hl,cpc_PutSpTileMap8x24
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,14
	add	hl,bc
	push	hl
	ld	hl,cpc_PutTrSp8x24TileMap2b
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,7
	add	hl,bc
	push	hl
	ld	hl,65528	;const
	ld	a,l
	call	l_sxt
	pop	de
	ld	a,l
	ld	(de),a
	jp	i_29
.i_28
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_ss_pumpkin
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	push	hl
	ld	hl,_ss_pumpkin
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,12
	add	hl,bc
	push	hl
	ld	hl,cpc_PutSpTileMap8x16
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,14
	add	hl,bc
	push	hl
	ld	hl,cpc_PutTrSp8x16TileMap2b
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,7
	add	hl,bc
	push	hl
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	pop	de
	ld	a,l
	ld	(de),a
.i_29
	jp	i_26
.i_27
	ei
	ret



._cm_two_points
	ld a, (_cy1)
	cp 12+1
	jr c, cm_two_points_keep_comparing
	jr cm_two_points_do
	.cm_two_points_keep_comparing
	ld a, (_cy2)
	cp 12+1
	jr c, cm_two_points_go_on
	.cm_two_points_do
	xor a
	ld (_at1), a
	ld (_at2), a
	ret
	.cm_two_points_go_on
	ld a, (_cy1)
	jr z, cm_two_points_at1_1
	dec a
	.cm_two_points_at1_1
	ld c, a
	sla c
	sla c
	sla c
	sla c
	ld a, (_cx1)
	or c
	ld e, a
	ld d, 0
	ld hl, _scr_attr
	add hl, de
	ld a, (hl)
	ld (_at1), a
	ld hl, _scr_buff
	add hl, de
	ld a, (hl)
	ld (_t1), a
	ld a, (_cy2)
	jr z, cm_two_points_at2_1
	dec a
	.cm_two_points_at2_1
	ld c, a
	sla c
	sla c
	sla c
	sla c
	ld a, (_cx2)
	or c
	ld e, a
	ld d, 0
	ld hl, _scr_attr
	add hl, de
	ld a, (hl)
	ld (_at2), a
	ld hl, _scr_buff
	add hl, de
	ld a, (hl)
	ld (_t2), a
	ret



._collide
	ld a, (_cx2)
	ld c, a
	ld a, (_cx1)
	add 7
	cp c
	jr c, _collide_reset
	ld a, (_cx1)
	ld c, a
	ld a, (_cx2)
	add 15
	cp c
	jr c, _collide_reset
	ld a, (_cy2)
	ld c, a
	ld a, (_cy1)
	add 7
	cp c
	jr c, _collide_reset
	ld a, (_cy1)
	ld c, a
	ld a, (_cy2)
	add 15
	cp c
	jr c, _collide_reset
	._collide_set
	ld hl, 1
	jr _collide_done
	._collide_reset
	ld hl, 0
	._collide_done
	ret
	ret


;	SECTION	text

._keyscancodes
	defw	763,765,509,1277,2175,1151,507,509,735,479
	defw	383,383
;	SECTION	code


;	SECTION	text

._ktext_0
	defm	"LEFT "
	defb	0

;	SECTION	code



;	SECTION	text

._ktext_1
	defm	"RIGHT"
	defb	0

;	SECTION	code



;	SECTION	text

._ktext_2
	defm	"JUMP "
	defb	0

;	SECTION	code



;	SECTION	text

._ktexts
	defw	_ktext_0
	defw	_ktext_1
	defw	0
	defw	0
	defw	0
	defw	_ktext_2

;	SECTION	code


._controls_setup
	ld	a,#(6 % 256 % 256)
	ld	(__x),a
	ld	a,#(15 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+0
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_37
.i_35
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_37
	ld	a,(_gpit)
	cp	#(5 % 256)
	jr	z,i_36_ule
	jp	nc,i_36
.i_36_ule
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	ld	hl,0	;const
	push	hl
	call	cpc_AssignKey
	pop	bc
	pop	bc
	jp	i_35
.i_36
.i_38
	call	cpc_AnyKeyPressed
	ld	a,h
	or	l
	jp	nz,i_38
.i_39
	ld	a,#(8 % 256 % 256)
	ld	(__x),a
	ld	a,#(15 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+44
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_42
.i_40
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_42
	ld	a,(_gpit)
	cp	#(6 % 256)
	jp	z,i_41
	jp	nc,i_41
	ld	a,(_gpit)
	cp	#(2 % 256)
	jp	nz,i_43
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_43
	ld	a,#(13 % 256 % 256)
	ld	(__x),a
	ld	a,#(16 % 256 % 256)
	ld	(__y),a
	ld	hl,_ktexts
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0	;const
	call	cpc_ShowTileMap
	ld	hl,(_gpit)
	ld	h,0
	call	cpc_RedefineKey
	jp	i_40
.i_41
	ret



._music_play
	ld	hl,2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,32250	;const
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld de, 32250
	call 34868+0x06FE
	ld de, 0xE800 + 0x600
	call 34868+0x0762
	ld a, 175
	ld (34868+0x000A), a
	ret



._sfx_play
	ld a, 1
	ld h, 15
	ld e, 50
	ld d, 0
	ld bc, 0
	call 34868+0x0776
	ret



._music_stop
	call 34868+0x0753
	; Turn off arkos play routine
	ld a, 201
	ld (34868+0x000A), a
	ret



.__pal_set
	ld	hl,16 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_44
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_45
	ld	hl,(_gpit)
	ld	h,0
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,(_gpit)
	ld	h,0
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	call	cpc_SetColour
	pop	bc
	pop	bc
	jp	i_44
.i_45
	ret



.__tile_address
	ld a, (__y)
	add a, a ; 2 4
	add a, a ; 4 4
	add a, a ; 8 4
	ld h, 0 ; 2
	ld l, a ; 4
	add hl, hl ; 16 11
	add hl, hl ; 32 11
	; 44 t-states
	; HL = _y * 32
	ld a, (__x)
	ld e, a
	ld d, 0
	add hl, de
	; HL = _y * 32 + _x
	ld de, _nametable
	add hl, de
	ex de, hl
	; DE = buffer address
	ret



._p_s
	ld a, (__x)
	ld (_rdxx), a
	ld a, (__y)
	ld (_rdyy), a
	call __tile_address ; DE = buffer address
	pop bc
	pop hl
	push hl
	push bc
	._p_s_loop
	ld a, (hl)
	or a
	jr z, _p_s_restore_and_return
	inc hl
	cp 0x2f
	jr nz, _p_s_draw_pattern
	ld a, (_rdxx)
	ld (__x), a
	ld a, (__y)
	inc a
	ld (__y), a
	push hl
	call __tile_address ; DE = buffer address
	pop hl
	jr _p_s_loop
	._p_s_draw_pattern
	sub 32
	ld (de), a
	inc de
	jr _p_s_loop
	._p_s_restore_and_return
	ld a, (_rdxx)
	ld (__x), a
	ld a, (_rdyy)
	ld (__y), a
	ret



._p_t2
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__d1),a
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(__d2),a
	call __tile_address ; DE = buffer address
	ld a, (__d1)
	ld (de), a
	inc de
	ld a, (__d2)
	ld (de), a
	inc de
	ld a, (__x)
	ld e, a
	ld a, (__y)
	ld d, a
	call cpc_UpdTileTable
	inc e
	call cpc_UpdTileTable
	ret



._draw_tile
	call __tile_address ; DE = buffer address
	ld a, (__t)
	sla a
	sla a
	ld l, a
	ld h, 0
	ld bc, _tsmaps
	add hl, bc
	; HL = metatile address
	ld a, (__y)
	cp 1+22
	; Draw just the top row
	jr z, _hwa_draw_tile_b1
	cp 1
	jr nz, _hwa_draw_tile_b2
	; Draw just the bottom row
	inc hl
	inc hl
	ex de, hl
	ld bc, 32
	add hl, bc
	ex de, hl
	jr _hwa_draw_tile_b1
	._hwa_draw_tile_b2
	ldi
	ldi
	ld bc, 30
	ex de, hl
	add hl, bc
	ex de, hl
	._hwa_draw_tile_b1
	ldi
	ldi
	ret



._draw_tile_upd
	call	_draw_tile
	XREF cpc_UpdTileTable
	ld a, (__x)
	ld e, a
	ld a, (__y)
	ld d, a
	cp 1 + 22
	; invalidate just the top row
	jr z, _hwa_draw_tile_upd_b1
	cp 1
	jr z, _hwa_draw_tile_upd_b2
	call cpc_UpdTileTable
	inc e
	call cpc_UpdTileTable
	dec e
	._hwa_draw_tile_upd_b2
	inc d
	._hwa_draw_tile_upd_b1
	call cpc_UpdTileTable
	inc e
	call cpc_UpdTileTable
	ret



._cpc_clear_rect
	._cpc_clear_rect_whole_area
	ld hl, _nametable
	ld de, _nametable + 1
	ld bc, 767
	ld (hl), 0
	ldir
	ret



._cpc_screen_update
	ld b, 0
	._cpc_screen_update_inv_loop
	push bc
	ld a, b
	sla a
	sla a
	sla a
	sla a
	ld d, 0
	ld e, a
	ld hl, _sp_sw
	add hl, de
	ld b, h
	ld c, l
	ld de, _cpc_screen_update_inv_ret
	push de
	ld de, 12
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	ld h, b
	ld l, c
	ret
	._cpc_screen_update_inv_ret
	pop bc
	inc b
	ld a, b
	cp 5
	jr nz, _cpc_screen_update_inv_loop
	._cpc_screen_update_upd_buffer
	call cpc_UpdScr
	ld b, 5
	._cpc_screen_update_upd_loop
	dec b
	push bc
	ld a, b
	sla a
	sla a
	sla a
	sla a
	ld d, 0
	ld e, a
	ld hl, _sp_sw
	add hl, de
	ld b, h
	ld c, l
	ld de, _cpc_screen_update_upd_ret
	push de
	ld de, 14
	add hl, de
	ld e, (hl)
	inc hl
	ld d, (hl)
	push de
	ld h, b
	ld l, c
	ret
	._cpc_screen_update_upd_ret
	pop bc
	xor a
	or b
	jr nz, _cpc_screen_update_upd_loop
	._cpc_screen_update_show
	call cpc_ShowTouchedTiles
	jp cpc_ResetTouchedTiles
	ret



._cpc_show_updated
	call	cpc_UpdScr
	call	cpc_ShowTouchedTiles
	call	cpc_ResetTouchedTiles
	ret



._unrle_adv
	ld	hl,_nametable
	push	hl
	ld	hl,(_gpint)
	inc	hl
	ld	(_gpint),hl
	dec	hl
	pop	de
	add	hl,de
	ex	de,hl
	ld	hl,_rdb
	ld	a,(hl)
	ld	(de),a
	ld	l,a
	ld	h,0
	ret



._unrle
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	a,(hl)
	ld	(_rdc),a
	ld	hl,0	;const
	ld	(_gpint),hl
.i_46
	ld	hl,(_gpint)
	ld	de,768	;const
	ex	de,hl
	call	l_ult
	jp	nc,i_47
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	a,(hl)
	ld	(_rda),a
	ld	e,a
	ld	d,0
	ld	hl,(_rdc)
	ld	h,d
	call	l_eq
	jp	nc,i_48
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	a,(hl)
	ld	(_rda),a
	ld	l,a
	and	a
	jp	z,i_47
.i_49
.i_50
	ld	hl,_rda
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_51
	call	_unrle_adv
	jp	i_50
.i_51
	jp	i_52
.i_48
	ld	hl,(_rda)
	ld	h,0
	ld	a,l
	ld	(_rdb),a
	call	_unrle_adv
.i_52
	jp	i_46
.i_47
	ret



._set_map_tile
	ld a, (__y)
	sla a
	sla a
	sla a
	sla a
	ld c, a
	ld a, (__x)
	or c
	ld (_rdf), a
	ld de, (__t)
	ld d, 0
	ld hl, _behs
	add hl, de
	ld a, (hl)
	ld de, (_rdf)
	ld d, 0
	ld hl, _scr_attr
	add hl, de
	ld (hl), a
	ld a, (__t)
	ld hl, _scr_buff
	add hl, de
	ld (hl), a
	ld a, (__x)
	sla a
	add 0
	ld (__x), a
	ld a, (__y)
	sla a
	add 1
	ld (__y), a
	call	_draw_tile_upd
	ret



._draw_tile_advance
	call	_draw_tile
	ld a, (_flip_flop)
	xor 1
	ld (_flip_flop), a
	ld a, (__x)
	add 2
	cp 32+0
	jr nz, _draw_tile_advance_no_next_line
	ld a, (__y)
	add 2
	ld (__y), a
	srl a
	and 1
	ld (_flip_flop), a
	ld a, 0
	._draw_tile_advance_no_next_line
	ld (__x), a
	ret



._advance_worm
	ld	hl,(_rdt)
	ld	h,0
	ld	a,l
	ld	(__t),a
	ld	a,(_level)
	cp	#(1 % 256)
	jp	nz,i_54
	ld	a,(__t)
	cp	#(11 % 256)
	jp	nz,i_54
	ld	a,(_flip_flop)
	and	a
	jr	nz,i_55_i_54
.i_54
	jp	i_53
.i_55_i_54
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__t),a
.i_53
	ld	de,_behs
	ld	hl,(__t)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	de,_scr_buff
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,__t
	ld	a,(hl)
	ld	(de),a
	ld	de,_scr_attr
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ex	de,hl
	ld	hl,_rda
	ld	a,(hl)
	ld	(de),a
	ld	l,a
	ld	h,0
	call	_draw_tile_advance
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	ret



._scr_rand
	ld	de,_seed1
	ld	hl,(_n_pant)
	ld	h,0
	call	l_pint
	ld	hl,_seed2
	push	hl
	ld	hl,(_n_pant)
	ld	h,0
	ld	bc,69
	add	hl,bc
	call	l_pint_pop
	call	_srand
	ret



._draw_scr
	call	cpc_ResetTouchedTiles
	call	_scr_rand
	call	_map_base_address
	ld	(_gp_map),hl
	._draw_scr_rle53
	xor a
	ld (_gpit), a
	ld a, 0
	ld (__x), a
	ld a, 1
	ld (__y), a
	._draw_scr_loop
	ld a, (_gpit)
	cp 192
	;jr nc, _draw_scr_loop_done
	jr z, _draw_scr_loop_done
	ld hl, (_gp_map)
	ld a, (hl)
	inc hl
	ld (_gp_map), hl
	ld c, a
	and 0x1f
	ld (_rdt), a
	ld a, c
	ld (_rdct), a
	._draw_scr_advance_loop
	ld a, (_rdct)
	cp 32
	jr c, _draw_scr_advance_loop_done
	sub 32
	ld (_rdct), a
	call _advance_worm
	jr _draw_scr_advance_loop
	._draw_scr_advance_loop_done
	call _advance_worm
	jr _draw_scr_loop
	._draw_scr_loop_done
	ld	a,#(0 % 256 % 256)
	ld	(__t),a
	ld	a,#(0 % 256 % 256)
	ld	(_gpjt),a
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asl
	push	hl
	ld	a,(_n_pant)
	ld	e,a
	ld	d,0
	ld	l,#(2 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_tile_got_offset),a
	ld	(_gpit),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(__y),a
	jp	i_58
.i_56
	ld	hl,(__y)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
.i_58
	ld	a,(__y)
	cp	#(25 % 256)
	jp	z,i_57
	jp	nc,i_57
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__x),a
.i_59
.i_61
	ld	a,(__x)
	cp	#(32 % 256)
	jp	z,i_60
	jp	nc,i_60
	ld	de,_tile_got
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_bitmask
	push	hl
	ld	a,(__x)
	ld	e,a
	ld	d,0
	ld	l,#(2 % 256)
	call	l_asr_u
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	call	l_and
	ld	a,h
	or	l
	jp	z,i_62
	call	_draw_tile
	ld	hl,(__x)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	de,_scr_attr
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	call	_draw_tile
	ld	hl,(__x)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	de,_scr_attr
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpjt),a
	jp	i_63
.i_62
	ld	hl,__x
	ld	a,4 % 256
	add	(hl)
	ld	(hl),a
	ld	hl,(_gpjt)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(_gpjt),a
.i_63
	jp	i_59
.i_60
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
	jp	i_56
.i_57
	ret



._draw_scr_buffer
	call	cpc_ResetTouchedTiles
	call	_scr_rand
	ld	a,#(0 % 256 % 256)
	ld	(_gpit),a
	ld	a,#(0 % 256 % 256)
	ld	(__x),a
	ld	a,#(1 % 256 % 256)
	ld	(__y),a
	ld	hl,_scr_buff
	ld	(_gp_map),hl
.i_64
	ld	a,(_gpit)
	cp	#(160 % 256)
	jp	z,i_65
	jp	nc,i_65
	ld	hl,_scr_buff
	push	hl
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(__t),a
	call	_draw_tile_advance
	jp	i_64
.i_65
	ld	hl,0	;const
	call	cpc_ShowTileMap
	ret



._hotspots_ini
	ld hl, _hact
	ld a, 1
	ld b, 20
	._hotspots_ini_loop
	ld (hl), a
	inc hl
	djnz _hotspots_ini_loop
	ret



._hotspots_paint
	ld a, (_hrt)
	or a
	ret z
	add 31
	ld (__t), a
	ld a, (_hry)
	srl a
	srl a
	srl a
	sub 2
	add 1
	ld (__y), a
	ld a, (_hrx)
	srl a
	srl a
	srl a
	add 0
	ld (__x), a
	call	_draw_tile_upd
	ret



._hotspots_load
	ld de, (_n_pant)
	ld d, 0
	ld hl, _hact
	add hl, de
	ld a, (hl)
	or a
	jp z, _hotspots_load_reset
	ld a, (_n_pant)
	sla a
	ld e, a
	ld d, 0
	ld hl, _hotspots
	add hl, de
	ld a, (hl)
	inc hl
	ld (_hrt), a
	ld a, (hl)
	ld c, a
	and 0xf0
	ld (_hry), a
	ld a, c
	sla a
	sla a
	sla a
	sla a
	ld (_hrx), a
	jp _hotspots_paint
	._hotspots_load_reset
	xor a
	ld (_hrt), a
	ret
	ret



._hotspots_do
	ld a, (_hrt)
	or a
	ret z
	ld a, (_prx)
	ld (_cx1), a
	ld a, (_pry)
	ld (_cy1), a
	ld a, (_hrx)
	ld (_cx2), a
	ld a, (_hry)
	ld (_cy2), a
	call _collide ; -> L
	xor a
	or l
	ret z
	ld a, 1
	ld (_rda), a
	ld a, (_hrt)
	._hotspots_do_selector
	cp 3
	jp z, _hotspots_do_type_refill
	cp 1
	jp z, _hotspots_do_type_object
	cp 2
	jp z, _hotspots_do_type_key
	jp _hotspots_do_selector_done
	._hotspots_do_type_refill
	ld a, (_plife)
	add 1
	cp 99
	jp c, _hotspots_do_type_refill_done
	ld a, 99
	._hotspots_do_type_refill_done
	ld (_plife), a
	jp _hotspots_do_selector_done
	._hotspots_do_type_object
	ld a, (_flags + 2)
	or a
	jp z, _hotspots_do_type_object_not_se
	xor a
	ld (_rda), a
	jr _hotspots_do_type_object_one_do
	._hotspots_do_type_object_not_se
	ld a, 1
	ld (_flags + 2), a
	._hotspots_do_type_object_one_do
	jp _hotspots_do_selector_done
	._hotspots_do_type_key
	ld a, (_pkeys)
	inc a
	ld (_pkeys), a
	jp _hotspots_do_selector_done
	._hotspots_do_selector_done
	ld a, (_rda)
	or a
	ret z
	ld	hl,6	;const
	push	hl
	call	_sfx_play
	pop	bc
	ld a, (_hry)
	srl a
	srl a
	srl a
	srl a
	dec a
	ld (__y), a
	ld a, (_hrx)
	srl a
	srl a
	srl a
	srl a
	ld (__x), a
	ld a, (_hry)
	and 0xf0
	sub 0x10
	ld c, a
	ld a, (__x)
	or c
	ld e, a
	ld d, 0
	ld hl, _scr_buff
	add hl, de
	ld a, (hl)
	ld (__t), a
	call _set_map_tile ();
	ld de, (_n_pant)
	ld d, 0
	ld hl, _hact
	add hl, de
	xor a
	ld (hl), a
	ld (_hrt), a
	ret



._bolts_load
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_66
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_67
	ld	de,_lkact
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_66
.i_67
	ret



._bolts_clear_bolt
	ld	hl,_locks
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_70
.i_68
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_70
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_69
	jp	nc,i_69
	ld	hl,(_gp_gen)
	inc	hl
	ld	(_gp_gen),hl
	dec	hl
	ld	a,(hl)
	ld	(_rda),a
	ld	hl,(_gp_gen)
	inc	hl
	ld	(_gp_gen),hl
	dec	hl
	ld	a,(hl)
	ld	(_rdb),a
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_rda)
	ld	h,d
	call	l_eq
	jp	nc,i_72
	ld	de,(_rdc)
	ld	d,0
	ld	hl,(_rdb)
	ld	h,d
	call	l_eq
	jr	c,i_73_i_72
.i_72
	jp	i_71
.i_73_i_72
	ld	de,_lkact
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(1 % 256 % 256)
	ld	hl,4	;const
	push	hl
	call	_sfx_play
	pop	bc
.i_71
	jp	i_68
.i_69
	ret



._bolts_update_screen
	ld	hl,_locks
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpjt),a
	jp	i_76
.i_74
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
.i_76
	ld	a,(_gpjt)
	cp	#(4 % 256)
	jp	z,i_75
	jp	nc,i_75
	ld	hl,(_gp_gen)
	inc	hl
	ld	(_gp_gen),hl
	dec	hl
	ld	a,(hl)
	ld	(_rda),a
	ld	hl,(_gp_gen)
	inc	hl
	ld	(_gp_gen),hl
	dec	hl
	ld	a,(hl)
	ld	(_rdb),a
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_rda)
	ld	h,d
	call	l_eq
	jp	nc,i_78
	ld	de,_lkact
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jr	nz,i_79_i_78
.i_78
	jp	i_77
.i_79_i_78
	ld	a,#(0 % 256 % 256)
	ld	(__t),a
	ld	a,(_rdb)
	ld	e,a
	ld	d,0
	ld	hl,15	;const
	call	l_and
	ld	h,0
	ld	a,l
	ld	(__x),a
	ld	a,(_rdb)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_set_map_tile
.i_77
	jp	i_74
.i_75
	ret



._enems_restore_vals
	ld de, (_gpit)
	ld d, 0
	ld hl, _en_x
	add hl, de
	ld a, (__en_x)
	ld (hl), a
	ld hl, _en_y
	add hl, de
	ld a, (__en_y)
	ld (hl), a
	ld hl, _en_mx
	add hl, de
	ld a, (__en_mx)
	ld (hl), a
	ld hl, _en_my
	add hl, de
	ld a, (__en_my)
	ld (hl), a
	ld hl, _en_ct
	add hl, de
	ld a, (__en_ct)
	ld (hl), a
	ld hl, _en_state
	add hl, de
	ld a, (__en_state)
	ld (hl), a
	ld hl, _en_x1
	add hl, de
	ld a, (__en_x1)
	ld (hl), a
	ld hl, _en_y1
	add hl, de
	ld a, (__en_y1)
	ld (hl), a
	ld hl, _en_x2
	add hl, de
	ld a, (__en_x2)
	ld (hl), a
	ld hl, _en_y2
	add hl, de
	ld a, (__en_y2)
	ld (hl), a
	ret



._enems_persistent_deaths_init
	ld	hl,60 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_80
	ld	a,(_gpit)
	and	a
	jp	z,i_81
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	de,_ep_killed
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_80
.i_81
	ret



._enems_load
	ld hl, (_n_pant)
	ld h, 0
	add hl, hl
	add hl, hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	ld de, _enems
	add hl, de
	ld (_gp_gen), hl
	ld a, (_n_pant)
	ld b, a
	add a
	add b
	ld (_enoffs), a
	ld (_rdc), a
	xor a
	ld (_gpit), a
	ld b, a
	._enems_load_big_loop
	ld de, (_rdc)
	ld d, 0
	ld hl, _ep_killed
	add hl, de
	ld a, (hl)
	or a
	jp z, _enems_load_do
	ld d, 0
	ld e, b
	ld hl, _en_t
	add hl, de
	ld (hl), d
	ld hl, (_gp_gen)
	ld de, 4
	add hl, de
	ld (_gp_gen), hl
	jp _enems_load_continue
	._enems_load_do
	ld hl, (_gp_gen)
	ld a, (hl)
	inc hl
	ld (_rda), a
	ld a, (hl)
	inc hl
	ld c, a
	sla a
	sla a
	sla a
	sla a
	ld (__en_x), a
	ld (__en_x1), a
	ld a, c
	and 0xf0
	ld (__en_y), a
	ld (__en_y1), a
	ld a, (hl)
	inc hl
	ld c, a
	sla a
	sla a
	sla a
	sla a
	ld (__en_x2), a
	ld a, c
	and 0xf0
	ld (__en_y2), a
	ld a, (hl)
	inc hl
	ld (_rdb), a
	ld (_gp_gen), hl
	ld e, b
	ld d, 0
	ld hl, _en_t
	add hl, de
	ld a, (_rda)
	ld (hl), a
	ld c, a
	and 0x0f
	sla a
	add 13
	ld hl, _en_s
	add hl, de
	ld (hl), a
	xor a
	ld (__en_state), a
	ld a, 2
	ld e, b
	ld d, 0
	ld hl, _en_life
	add hl, de
	ld (hl), a
	._enems_load_t_assignations
	ld a, c
	and 0xf0
	._enems_load_t_assignations_jt
	cp 0x10
	jp z, _enems_load_t_10
	cp 0x20
	jp z, _enems_load_t_20
	jp _enems_load_t_assignations_done
	._enems_load_t_10
	._enems_load_t_20
	._enems_load_t_10_mx
	ld a, (__en_x2)
	ld c, a
	ld a, (__en_x1)
	cp c
	jr c, _enems_load_t_10_x1_smaller
	jr z, _enems_load_t_10_x1_same
	._enems_load_t_10_x1_bigger
	ld a, (_rdb)
	neg a
	jr _enems_load_t_10_mx_done
	._enems_load_t_10_x1_same
	xor a
	jr _enems_load_t_10_mx_done
	._enems_load_t_10_x1_smaller
	ld a, (_rdb)
	._enems_load_t_10_mx_done
	ld (__en_mx), a
	._enems_load_t_10_my
	ld a, (__en_y2)
	ld c, a
	ld a, (__en_y1)
	cp c
	jr c, _enems_load_t_10_y1_smaller
	jr z, _enems_load_t_10_y1_same
	._enems_load_t_10_y1_bigger
	ld a, (_rdb)
	neg a
	jr _enems_load_t_10_my_done
	._enems_load_t_10_y1_same
	xor a
	jr _enems_load_t_10_my_done
	._enems_load_t_10_y1_smaller
	ld a, (_rdb)
	._enems_load_t_10_my_done
	ld (__en_my), a
	ld a, (__en_y1)
	ld c, a
	ld a, (__en_y2)
	cp c
	jp nc, _enems_load_t_10_not_swap_yX
	ld (__en_y1), a
	ld a, c
	ld (__en_y2), a
	._enems_load_t_10_not_swap_yX
	jp _enems_load_t_assignations_done
	._enems_load_t_assignations_done
	xor a
	ld e, b
	ld d, 0
	ld hl, _en_washit
	add hl, de
	ld (hl), a
	ld hl, _en_dying
	add hl, de
	ld (hl), a
	._enems_load_continue
	ld a, (_rdc)
	inc a
	ld (_rdc), a
	call _enems_restore_vals
	inc b
	ld a, b
	ld (_gpit), a
	cp 3
	jp nz, _enems_load_big_loop
	ld b, 0
	dyn_sprs_loop:
	push bc
	ld a, b
	add a, 1
	ld (_gpjt), a
	ld e, b
	ld d, 0
	ld hl,_en_t
	add hl, de
	ld a, (hl)
	srl a
	srl a
	srl a
	srl a
	ld (_rdt), a
	ld e, a
	ld d, 0
	ld hl, _dss_msb_ox
	add hl, de
	ld a, (hl)
	ld (_rds), a
	or a
	jp z, dyn_sprs_continue
	cp 0xff
	jr z, dyn_sprs_lsb
	jr dyn_sprs_msb
	dyn_sprs_calc_struct:
	ld hl, (_gpjt)
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, _sp_sw
	add hl, de
	ret
	dyn_sprs_msb:
	call dyn_sprs_calc_struct
	ld bc, 6
	add hl, bc
	ld a, (_rds)
	ld (hl), a
	inc hl
	ex de, hl
	ld bc, (_rdt)
	ld b, 0
	ld hl, _dss_msb_oy
	add hl, bc
	ld a, (hl)
	ld (de), a
	call dyn_sprs_calc_struct
	ld bc, 12
	add hl, bc
	ex de, hl
	ld a, (_rdt)
	sla a
	ld c, a
	ld b, 0
	ld hl, _dss_msb_invfunc
	add hl, bc
	ldi
	ldi
	ld a, (_rdt)
	sla a
	ld c, a
	ld b, 0
	ld hl, _dss_msb_updfunc
	add hl, bc
	ldi
	ldi
	jp dyn_sprs_continue
	dyn_sprs_lsb:
	ld e, b
	ld d, 0
	ld hl,_en_t
	add hl, de
	ld a, (hl)
	and 0xf
	ld (_rdt), a
	call dyn_sprs_calc_struct
	ld bc, 6
	add hl, bc
	ex de, hl
	ld bc, (_rdt)
	ld b, 0
	ld hl, _dss_lsb_ox
	add hl, bc
	ld a, (hl)
	ld (de), a
	inc de
	ld bc, (_rdt)
	ld b, 0
	ld hl, _dss_lsb_oy
	add hl, bc
	ld a, (hl)
	ld (de), a
	call dyn_sprs_calc_struct
	ld bc, 12
	add hl, bc
	ex de, hl
	ld a, (_rdt)
	sla a
	ld c, a
	ld b, 0
	ld hl, _dss_lsb_invfunc
	add hl, bc
	ldi
	ldi
	ld a, (_rdt)
	sla a
	ld c, a
	ld b, 0
	ld hl, _dss_lsb_updfunc
	add hl, bc
	ldi
	ldi
	dyn_sprs_continue:
	pop bc
	inc b
	ld a, b
	cp 3
	jp nz, dyn_sprs_loop
	ret



._enems_drain
	ld d, 0
	ld e, b
	ld hl, _en_dying
	add hl, de
	ld a, (hl)
	or a
	ret nz
	ld hl, _en_washit
	add hl, de
	ld a, (hl)
	or a
	ret nz
	ld hl, _en_life
	add hl, de
	ld a, (hl)
	or a
	jr z, _enems_drain_kill
	dec a
	ld (hl), a
	ld hl, _en_washit
	add hl, de
	ld a, 5
	ld (hl), a
	jp _enems_drain_honk
	._enems_drain_kill
	ld hl, _en_washit
	add hl, de
	xor a
	ld (hl), a
	._enems_drain_kill_general
	ld hl, _en_dying
	add hl, de
	ld a, 16
	ld (hl), a
	xor a
	ld (_rdt), a
	ld hl, _en_t
	add hl, de
	ld (hl), a
	._enems_kill_store
	ld a, (_enoffs)
	add b
	ld e, a
	ld d, 0
	ld hl, _ep_killed
	add hl, de
	ld a, 1
	ld (hl), a
	ld a, (_pbodycount)
	inc a
	ld (_pbodycount), a
	._enems_drain_honk
	push bc
	ld	hl,7	;const
	push	hl
	call	_sfx_play
	pop	bc
	pop bc
	ret



._enems_do
	ld b, 3
	.__e_d_big_loop
	dec b
	ld a, b
	ld (_gpit), a
	add 1
	ld (_spr_idx), a
	ld d, 0
	ld e, a
	ld hl, _spr_on
	add hl, de
	xor a
	ld (hl), a
	.__e_d_local_copy
	ld e, b
	ld hl, _en_t
	add hl, de
	ld a, (hl)
	ld (__en_t), a
	ld hl, _en_x
	add hl, de
	ld a, (hl)
	ld (__en_x), a
	ld hl, _en_y
	add hl, de
	ld a, (hl)
	ld (__en_y), a
	ld hl, _en_x1
	add hl, de
	ld a, (hl)
	ld (__en_x1), a
	ld hl, _en_y1
	add hl, de
	ld a, (hl)
	ld (__en_y1), a
	ld hl, _en_x2
	add hl, de
	ld a, (hl)
	ld (__en_x2), a
	ld hl, _en_y2
	add hl, de
	ld a, (hl)
	ld (__en_y2), a
	ld hl, _en_mx
	add hl, de
	ld a, (hl)
	ld (__en_mx), a
	ld hl, _en_my
	add hl, de
	ld a, (hl)
	ld (__en_my), a
	ld hl, _en_state
	add hl, de
	ld a, (hl)
	ld (__en_state), a
	ld hl, _en_ct
	add hl, de
	ld a, (hl)
	ld (__en_ct), a
	ld a, 0xff
	ld (_spr_id), a
	xor a
	ld (_rdf), a
	.__e_d_check_washit
	ld hl, _en_washit
	add hl, de
	ld a, (hl)
	or a
	jr nz, __e_d_washit_or_dying
	ld hl, _en_dying
	add hl, de
	ld a, (hl)
	or a
	jr z, __e_d_washit_or_dying_done
	.__e_d_washit_or_dying
	ld a, 20
	ld (_spr_id), a
	ld a, 1
	ld (_rdf), a
	ld e, b
	ld d, 0
	ld hl, _en_dying
	add hl, de
	ld a, (hl)
	or a
	jr z, __e_d_not_dying
	dec a
	ld (hl), a
	call __e_d_paint_proc
	jp __e_d_big_loop_continue
	.__e_d_not_dying
	ld hl, _en_washit
	add hl, de
	ld a, (hl)
	or a
	jr z, __e_d_not_washit
	dec a
	ld (hl), a
	.__e_d_not_washit
	.__e_d_washit_or_dying_done
	ld a, (__en_t)
	and 0x08
	jr z, __e_d_no_switch_off
	xor a
	ld (__en_t), a
	.__e_d_no_switch_off
	ld a, (__en_t)
	and 0xf0
	ld (_rdt), a
	or a
	jp z, __e_d_big_loop_continue
	.__e_d_platform_precheck
	cp 0x20
	jr nz, __e_d_not_platform_0
	.__e_d_pregotten_calc
	xor a
	ld (_pregotten), a
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 9
	cp c
	jr c, __e_d_pregotten_calc_done
	ld a, c
	add 17
	ld c, a
	ld a, (_prx)
	cp c
	jr z, __e_d_pregotten_calc_do
	jr nc, __e_d_pregotten_calc_done
	.__e_d_pregotten_calc_do
	ld a, 1
	ld (_pregotten), a
	.__e_d_pregotten_calc_done
	ld a, 1
	jr __e_d_platform_precheck_done
	.__e_d_not_platform_0
	xor a
	.__e_d_platform_precheck_done
	ld (_is_platform), a
	push bc
	._enems_update_do
	ld a, (_rdt)
	.__e_d_linear_do
	cp 0x10
	jr z, __e_d_linear_do_do
	cp 0x20
	jp nz, __e_d_linear_done
	.__e_d_linear_do_do
	._enem_linear_assembly_h
	._em_l
	ld de, (_gpit)
	ld d, 0
	ld hl, _en_washit
	add hl, de
	ld a, (hl)
	or a
	jp nz, __em_l_done
	ld a, (__en_mx)
	ld b, a
	ld a, (__en_x)
	add b
	ld (__en_x), a
	ld a, (__en_my)
	ld b, a
	ld a, (__en_y)
	add a, b
	ld (__en_y), a
	ld a, (__en_x1)
	ld b, a
	ld a, (__en_x)
	cp b
	jr z, _em_l_horz_trajectory_limit
	ld a, (__en_x2)
	ld b, a
	ld a, (__en_x)
	cp b
	jr nz, _em_l_no_horz_trajectory_limit
	._em_l_horz_trajectory_limit
	ld a, (__en_mx)
	neg
	ld (__en_mx), a
	._em_l_no_horz_trajectory_limit
	ld a, (__en_my)
	or a
	jr z, _em_l_no_vert_trajectory_limit
	ld a, (__en_y)
	ld c, a
	ld a, (__en_y1)
	cp c
	jr c, _em_l_no_surpass_y1
	ld a, (__en_my)
	bit 7, a
	jr z, _em_l_vert_abs_skip_1
	neg a
	ld (__en_my), a
	._em_l_vert_abs_skip_1
	jr _em_l_no_vert_trajectory_limit
	._em_l_no_surpass_y1
	ld a, (__en_y2)
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, _em_l_no_surpass_y2
	ld a, (__en_my)
	bit 7, a
	jr nz, _em_l_vert_abs_skip_2
	neg a
	ld (__en_my), a
	._em_l_vert_abs_skip_2
	._em_l_no_surpass_y2
	._em_l_no_vert_trajectory_limit
	ld a, (_rdt)
	cp 0x20
	jr nz, _em_l_not_a_platform
	ld a, 19
	jr _em_l_spr_id_set
	._em_l_not_a_platform
	ld a, (__en_mx)
	or a
	jr z, _em_l_cell_vertical
	ld a, (__en_x)
	jr _enems_linear_cell_set
	._em_l_cell_vertical
	ld a, (__en_y)
	._enems_linear_cell_set
	srl a
	srl a
	srl a
	and 1
	ld de, _en_s
	ld hl, (_gpit)
	ld h, 0
	add hl, de
	ld b, (hl)
	add b ; A = en_s [gpit] + (rda & 1)
	._em_l_spr_id_set
	ld (_spr_id), a
	.__em_l_done
	jp _enems_update_done
	.__e_d_linear_done
	._enems_update_done
	pop bc
	call __e_d_paint_proc
	.__e_d_platform_check
	ld a, (_is_platform)
	or a
	jp z, __e_d_platform_done
	ld a, (_pregotten)
	or a
	jp z, __e_d_platform_done
	ld a, (_pgotten)
	or a
	jp nz, __e_d_platform_done
	ld a, (_pj)
	or a
	jr z, __e_d_platform_do
	ld a, (_pvy)
	cp $80
	jp z, __e_d_platform_done
	jp nc, __e_d_platform_done
	.__e_d_platform_do
	ld a, (__en_mx)
	or a
	jr z, __e_d_platform_horz_done
	.__e_d_platform_horz_do
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 20
	cp c
	jp c, __e_d_platform_vert_done
	ld a, (_pry)
	add 12
	ld c, a
	ld a, (__en_y)
	cp c
	jp c, __e_d_platform_vert_done
	ld a, 1
	ld (_pgotten), a
	push bc
	ld	hl,__en_mx
	call	l_gchar
	push	hl
	ld	hl,(__en_state)
	ld	h,0
	ld	de,4
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_asl
	ld	a,l
	ld	(_pgtmx),a
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,-16
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_py),hl
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	pop bc
	.__e_d_platform_horz_done
	ld a, (__en_my)
	or a
	jp z, __e_d_platform_vert_done
	cp $80
	jr c, __e_d_platform_vert_my_positive
	.__e_d_platform_vert_my_negative
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	add 20
	cp c
	jp c, __e_d_platform_vert_done
	ld a, (_pry)
	add 12
	ld c, a
	ld a, (__en_y)
	cp c
	jp c, __e_d_platform_vert_done
	jr __e_d_platform_vert_do
	.__e_d_platform_vert_my_positive
	ld a, (__en_y)
	ld c, a
	ld a, (__en_my)
	ld d, a
	ld a, (_pry)
	add 20
	add d
	cp c
	jp c, __e_d_platform_vert_done
	ld a, (_pry)
	add 12
	ld c, a
	ld a, (__en_y)
	cp c
	jr c, __e_d_platform_vert_done
	.__e_d_platform_vert_do
	ld a, 1
	ld (_pgotten), a
	push bc
	ld	hl,__en_my
	call	l_gchar
	push	hl
	ld	hl,(__en_state)
	ld	h,0
	ld	de,4
	ex	de,hl
	and	a
	sbc	hl,de
	pop	de
	call	l_asl
	ld	a,l
	ld	(_pgtmy),a
	ld	hl,(__en_y)
	ld	h,0
	ld	bc,-16
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_py),hl
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	pop bc
	.__e_d_platform_vert_done
	jp __e_d_big_loop_update_and_conti
	.__e_d_platform_done
	ld a, (_rdt)
	cp 0x20
	jp z, __e_d_pcol_done
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 8
	cp c
	jp c, __e_d_player_collision
	ld a, (_prx)
	ld c, a
	ld a, (__en_x)
	add 16
	cp c
	jp c, __e_d_player_collision
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	;add 15
	add 23
	cp c
	jp c, __e_d_player_collision
	ld a, (_pry)
	;add 8
	add 12
	ld c, a
	ld a, (__en_y)
	cp c
	jp c, __e_d_player_collision
	ld a, (_pvy)
	cp $80 ; sign
	jp nc, __e_d_player_collision ; branch if negative
	.__e_d_jumps_on_enemies
	ld l, 5
	push bc
	call cpc_TestKey
	pop bc
	xor a
	or l
	jr z, __e_d_jumps_on_enemies_done
	ld a, 1
	ld (_pj), a
	xor a
	ld (_pctj), a
	ld a, -127
	ld (_pvy), a
	jp __e_d_step_bounce_done
	.__e_d_jumps_on_enemies_done
	ld a, -48
	ld (_pvy), a
	.__e_d_step_bounce_done
	ld a, (__en_my)
	cp $80
	jr c, __e_d_step_affect_done
	neg
	ld (__en_my), a
	.__e_d_step_affect_done
	ld a, (__en_t)
	and 7
	cp 2
	jr nz, __e_d_step_kills_done
	call _enems_drain
	jp __e_d_big_loop_update_and_conti
	.__e_d_step_kills_done
	jp __e_d_pcol_done
	.__e_d_player_collision
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	add 4
	cp c
	jp c, __e_d_pcol_done
	ld a, (_prx)
	ld c, a
	ld a, (__en_x)
	add 12
	cp c
	jp c, __e_d_pcol_done
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	;add 12
	add 16 ; CUSTOM!!
	cp c
	jp c, __e_d_pcol_done
	ld a, (_pry)
	ld c, a
	ld a, (__en_y)
	add 12
	cp c
	jp c, __e_d_pcol_done
	ld a, (_rdt)
	ld c, a
	ld a, (_pflickering)
	or a
	jp nz, __e_d_pcol_done
	.__e_d_pcol_do
	.__e_d_pcol_prebounds
	ld a, (_pvx)
	or a
	jr nz, __e_d_pcol_prb_do
	ld a, (_pvy)
	or a
	jr z, __e_d_pcol_prb_enpos
	.__e_d_pcol_prb_do
	ld a, (_pvy)
	cp $80
	jr c, __e_d_pcol_prb_abs_pvy_pos
	neg
	.__e_d_pcol_prb_abs_pvy_pos
	ld c, a
	ld a, (_pvx)
	cp $80
	jr c, __e_d_pcol_prb_abs_pvx_pos
	neg
	.__e_d_pcol_prb_abs_pvx_pos
	cp c
	jr c, __e_d_pcol_prb_do_pvy
	.__e_d_pcol_prb_do_pvx
	ld a, (_pvx)
	cp $80
	jr c, __e_d_pcol_prb_pvx_as_p
	ld a, 127
	ld (_pvx), a
	jr __e_d_pcol_prb_done
	.__e_d_pcol_prb_pvx_as_p
	ld a, -127
	ld (_pvx), a
	jr __e_d_pcol_prb_done
	.__e_d_pcol_prb_do_pvy
	ld a, (_pvy)
	cp $80
	jr c, __e_d_pcol_prb_pvy_as_p
	ld a, 127
	ld (_pvy), a
	jr __e_d_pcol_prb_done
	.__e_d_pcol_prb_pvy_as_p
	ld a, -127
	ld (_pvy), a
	jr __e_d_pcol_prb_done
	.__e_d_pcol_prb_enpos
	.__e_d_pcol_prb_enpos_check_x
	ld a, (__en_x)
	ld c, a
	ld a, (_prx)
	cp c
	jr c, __e_d_pcol_prb_enpos_en_x_bigge
	ld a, 127
	ld (_pvx), a
	jr __e_d_pcol_prb_enpos_check_y
	.__e_d_pcol_prb_enpos_en_x_bigge
	ld a, -127
	ld (_pvx), a
	.__e_d_pcol_prb_enpos_check_y
	ld a, (__en_y)
	ld c, a
	ld a, (_pry)
	cp c
	jr c, __e_d_pcol_prb_enpos_en_y_bigge
	ld a, 127
	ld (_pvy), a
	jr __e_d_pcol_prb_done
	.__e_d_pcol_prb_enpos_en_y_bigge
	ld a, -127
	ld (_pvy), a
	.__e_d_pcol_prb_done
	call _enems_drain
	ld a, 1
	ld (_pwashit), a
	.__e_d_pcol_done
	.__e_d_big_loop_update_and_conti
	call _enems_restore_vals
	.__e_d_big_loop_continue
	ld a, b
	or a
	jp nz, __e_d_big_loop
	ret
	.__e_d_paint_proc
	.__e_d_paint_check
	ld a, (_spr_id)
	cp 0xff
	jr z, __e_d_no_paint
	ld de, (_spr_idx)
	ld d, 0
	ld hl, _spr_on
	add hl, de
	ld a, (hl)
	or a
	jr nz, __e_d_no_paint
	.__e_d_paint
	ld a, 1
	ld de, (_spr_idx)
	ld d, 0
	ld hl, _spr_on
	add hl, de
	ld (hl), a
	ld hl, _spr_x
	add hl, de
	ld a, (__en_x)
	ld (hl), a
	ld hl, _spr_y
	add hl, de
	ld a, (__en_y)
	ld (hl), a
	ld hl, (_spr_idx)
	ld h, 0
	add hl, hl
	ld de, _spr_next
	add hl, de
	push hl
	ld hl, (_spr_id)
	add hl, hl
	ld de, _sprite_cells
	add hl, de
	pop de
	; HL -> _sprite_cells + 2*_spr_id
	; DE -> _spr_next + 2*spr_id
	ld a, (hl)
	ld (de), a
	inc hl
	inc de
	ld a, (hl)
	ld (de), a
	.__e_d_paint_jitter
	ld a, (_rdf)
	or a
	jr z, __e_d_no_paint
	ld a, (_frame_counter)
	and 0x0f
	ld c, a
	push bc
	ld d, 0
	ld e, a
	ld hl, _jitter_big
	add hl, de
	ld a, (hl)
	ld b, a
	ld a, c
	neg a
	add 15
	ld e, a
	ld hl, _jitter_big
	add hl, de
	ld a, (hl)
	ld c, a
	ld de, (_spr_idx)
	ld d, 0
	ld hl, _spr_x
	add hl, de
	ld a, (hl)
	add b
	ld (hl), a
	ld hl, _spr_y
	add hl, de
	ld a, (hl)
	add c
	ld (hl), a
	pop bc
	.__e_d_no_paint
	ret



._player_register_safe_spot
	ld	a,(_prx)
	ld	(_safe_prx),a
	ld	a,(_pry)
	ld	(_safe_pry),a
	ld	hl,(_n_pant)
	ld	h,0
	ld	a,l
	ld	(_safe_n_pant),a
	ret



._player_restore_safe_spot
	ld	hl,(_safe_prx)
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_px),hl
	ld	hl,(_safe_pry)
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_py),hl
	ld	hl,(_safe_n_pant)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	ret



._player_reset_movement
	xor a
	ld (_pvx), a
	ld (_pvy), a
	ld (_pfixct), a
	ld (_pfiring), a
	ld (_phit), a
	ld (_pj), a
	ld (_pjustjumped), a
	ret



._player_process_block
	ld	a,(___y)
	and	a
	jp	z,i_82
	ld	hl,___y
	ld	a,(hl)
	dec	(hl)
.i_82
	ld	hl,(___x)
	ld	h,0
	push	hl
	ld	a,(___y)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rdc),a
	ld	de,_scr_attr
	ld	hl,(_rdc)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	#(1 % 256)
	ld	(_rda),a
	ld	l,a
	and	a
	jp	nz,i_84
.i_83
	ld	a,(_pkeys)
	and	a
	jp	z,i_85
	ld	hl,_pkeys
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
	call	_bolts_clear_bolt
	ld	a,#(0 % 256 % 256)
	ld	(__t),a
	ld	a,(___x)
	ld	(__x),a
	ld	hl,(___y)
	ld	h,0
	ld	a,l
	ld	(__y),a
	call	_set_map_tile
	ld	hl,5	;const
	push	hl
	call	_sfx_play
	pop	bc
.i_85
.i_84
	ret



._player_init
	ld	hl,(_c_level)
	inc	hl
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_prx),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_px),hl
	ld	hl,(_c_level)
	inc	hl
	inc	hl
	ld	e,(hl)
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	h,0
	ld	a,l
	ld	(_pry),a
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asl
	ld	(_py),hl
	call	_player_register_safe_spot
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pfacing),a
	call	_player_reset_movement
	ld	a,#(0 % 256 % 256)
	ld	(_pkilled),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pframe),a
	ld	(_pstep),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_psprid),a
	ret



._player_hit
	call	_cpc_screen_update
	ld	hl,3	;const
	push	hl
	call	_sfx_play
	pop	bc
	ld	a,(_evil_tile_hit)
	and	a
	jp	z,i_86
	ld	hl,60	;const
	push	hl
	call	_delay
	pop	bc
	call	_player_reset_movement
	call	_player_restore_safe_spot
.i_86
	ld	a,#(25 % 256 % 256)
	ld	(_pflickering),a
	ld	a,(_plife)
	and	a
	jp	z,i_87
	ld	hl,_plife
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
	jp	i_88
.i_87
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pkilled),a
.i_88
	ld	a,#(16 % 256 % 256)
	ld	(_phit),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pwashit),a
	ret



._player_move
	ld hl, _phit
	ld a, (hl)
	or a
	jr z, _player_move_gl_00
	dec (hl)
	._player_move_gl_00
	ld hl, _pflickering
	ld a, (hl)
	or a
	jr z, _player_move_gl_01
	dec (hl)
	._player_move_gl_01
	ld	a,#(0 % 256 % 256)
	ld	(_pad),a
	ld	a,#(0 % 256 % 256)
	ld	(_evil_tile_hit),a
	ld	hl,(_px)
	ld	(_pcx),hl
	ld	hl,(_py)
	ld	(_pcy),hl
	ld	hl,(_pgotten)
	ld	h,0
	call	l_lneg
	jp	nc,i_89
	ld	hl,(_pj)
	ld	h,0
	call	l_lneg
	jp	nc,i_90
	ld	hl,_pvy
	call	l_gchar
	ld	de,103	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_91
	ld	hl,127	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	jp	i_92
.i_91
	ld	hl,_pvy
	call	l_gchar
	ld	bc,24
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_92
	jp	i_93
.i_90
	ld	hl,_pvy
	call	l_gchar
	ld	de,123	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_94
	ld	hl,127	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	jp	i_95
.i_94
	ld	hl,_pvy
	call	l_gchar
	ld	bc,4
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_95
.i_93
.i_89
	ld de, (_py)
	ld hl, _pvy
	call l_gchar
	add hl, de
	ld (_py), hl
	ld de, 256
	ex de, hl
	call l_lt
	jr nc, _pm_vert_move_topb_done
	ld de, 256
	ld (_py), de
	jp _pm_vert_move_botb_done
	._pm_vert_move_topb_done
	ld hl, 2944
	call l_gt
	jr nc, _pm_vert_move_botb_done
	ld de, 2944
	ld (_py), de
	._pm_vert_move_botb_done
	ld l, 4
	call l_asr
	ld a, l
	ld (_pry), a
	ld a, (_prx)
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld a, (_prx)
	add 7
	srl a
	srl a
	srl a
	srl a
	ld (_cx2), a
	ld hl, _pvy
	call l_gchar
	ex de, hl
	ld hl, _pgtmy
	call l_gchar
	add hl, de
	; ld (_rdsint), hl
	ld a, l
	or h
	jp z, _pm_vert_v_zero
	xor a
	or h
	jp p, _pm_vert_v_pos
	._pm_vert_v_neg
	ld a, (_pry)
	add 6
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jp nz, _pm_vert_v_neg_collide
	ld a, (_at2)
	and 8
	jp z, _pm_vert_v_neg_collide_else
	._pm_vert_v_neg_collide
	xor a
	ld (_pvy), a
	ld (_pgotten), a
	ld a, (_cy1)
	inc a
	sla a
	sla a
	sla a
	sla a
	sub 6
	ld (_pry), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_py), hl
	jp _pm_vert_v_coll_done
	._pm_vert_v_neg_collide_else
	jp _pm_vert_v_coll_done
	._pm_vert_v_pos
	ld a, (_pry)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_at1)
	and 12
	jp nz, _pm_vert_v_pos_collide
	ld a, (_at2)
	and 12
	jp z, _pm_vert_v_pos_collide_else
	._pm_vert_v_pos_collide
	xor a
	ld (_pvy), a
	ld (_pgotten), a
	ld a, (_cy1)
	dec a
	sla a
	sla a
	sla a
	sla a
	ld (_pry), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_py), hl
	jp _pm_vert_v_coll_done
	._pm_vert_v_pos_collide_else
	._pm_vert_v_coll_done
	._pm_vert_v_zero
	._pm_vert_v_done
	ld	hl,(_pry)
	ld	h,0
	ld	bc,16
	add	hl,bc
	ex	de,hl
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	h,0
	ld	a,l
	ld	(_cy2),a
	ld	(_cy1),a
	call	_cm_two_points
	ld	hl,_at1
	ld	a,(hl)
	and	#(12 % 256)
	jp	nz,i_96
	ld	hl,_at2
	ld	a,(hl)
	and	#(12 % 256)
	jp	z,i_98
.i_96
	ld	hl,_pvy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_98
	ld	hl,_pry
	ld	a,(hl)
	and	#(15 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_98
	ld	hl,1	;const
	jr	i_99
.i_98
	ld	hl,0	;const
.i_99
	ld	h,0
	ld	a,l
	ld	(_ppossee),a
	and	a
	jp	nz,i_101
	ld	a,(_pgotten)
	and	a
	jp	z,i_100
.i_101
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pjustjumped),a
.i_100
	ld	a,(_springs_on)
	and	a
	jp	z,i_103
	ld	a,#(13 % 256 % 256)
	ld	(__t),a
	ld	a,#(255 % 256 % 256)
	ld	(__x),a
	ld	a,(_t1)
	cp	#(23 % 256)
	jp	nz,i_104
	ld	hl,(_cy1)
	ld	h,0
	dec	hl
	dec	hl
	ld	a,l
	ld	(__y),a
	ld	hl,(_cx1)
	ld	h,0
	ld	a,l
	ld	(__x),a
	call	_set_map_tile
.i_104
	ld	a,(_t2)
	cp	#(23 % 256)
	jp	nz,i_105
	ld	hl,(_cy1)
	ld	h,0
	dec	hl
	dec	hl
	ld	a,l
	ld	(__y),a
	ld	hl,(_cx2)
	ld	h,0
	ld	a,l
	ld	(__x),a
	call	_set_map_tile
.i_105
	ld	a,(__x)
	cp	#(255 % 256)
	jp	z,i_106
	ld	hl,7	;const
	push	hl
	call	_sfx_play
	pop	bc
.i_106
.i_103
	ld	a,(_pad)
	cp	#(255 % 256)
	jp	z,i_108
	ld	hl,5	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jr	nz,i_109_i_108
.i_108
	jp	i_107
.i_109_i_108
	ld	hl,(_pjb)
	ld	h,0
	call	l_lneg
	jp	nc,i_110
	ld	a,#(1 % 256 % 256)
	ld	(_pjb),a
	ld	hl,(_pj)
	ld	h,0
	call	l_lneg
	jp	nc,i_111
	ld	a,(_pgotten)
	and	a
	jp	nz,i_113
	ld	a,(_ppossee)
	and	a
	jp	nz,i_113
	ld	a,(_phit)
	and	a
	jp	z,i_112
.i_113
	ld	a,#(0 % 256 % 256)
	ld	(_pctj),a
	ld	a,#(1 % 256 % 256)
	ld	(_pj),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pjustjumped),a
	ld	a,#(65409 % 256)
	ld	(_pvy),a
	ld	hl,1	;const
	push	hl
	call	_sfx_play
	pop	bc
	ld	hl,(_ppossee)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_register_safe_spot
.i_115
.i_112
.i_111
.i_110
	ld	a,(_pj)
	and	a
	jp	z,i_116
	ld	hl,_pctj
	ld	a,(hl)
	inc	(hl)
	ld	a,(_pctj)
	cp	#(6 % 256)
	jp	nz,i_117
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pj),a
.i_117
.i_116
	jp	i_118
.i_107
	ld	a,#(0 % 256 % 256)
	ld	(_pjb),a
	ld	a,(_pj)
	and	a
	jp	z,i_119
	ld	hl,_pvy
	call	l_gchar
	ld	de,65472	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_120
	ld	hl,65472	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_120
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pj),a
.i_119
.i_118
	ld	a,(_pad)
	cp	#(255 % 256)
	jp	z,i_122
	ld	hl,0	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jr	nz,i_123_i_122
.i_122
	jp	i_121
.i_123_i_122
	ld a, (_pfixct)
	or a
	jp nz, _pm_poll_pad_horz_left_skip
	ld a, (_pvx)
	sub 24
	ld (_pvx), a
	._pm_poll_pad_horz_left_pvx_set
	ld hl, _pvx
	call l_gchar
	ld de, -96
	ex de, hl
	call l_lt
	jp nc, _pm_poll_pad_horz_left_pvx_limi
	ld a, -96
	ld (_pvx), a
	._pm_poll_pad_horz_left_pvx_limi
	._pm_poll_pad_horz_left_skip
	ld a, 6
	ld (_pfacing), a
	jp	i_124
.i_121
	ld	a,(_pad)
	cp	#(255 % 256)
	jp	z,i_126
	ld	hl,1	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jr	nz,i_127_i_126
.i_126
	jp	i_125
.i_127_i_126
	ld a, (_pfixct)
	or a
	jp nz, _pm_poll_pad_horz_right_skip
	ld a, (_pvx)
	add 24
	ld (_pvx), a
	._pm_poll_pad_horz_right_pvx_set
	ld hl, _pvx
	call l_gchar
	ld de, 96
	ex de, hl
	call l_gt
	jp nc, _pm_poll_pad_horz_right_pvx_lim
	ld a, 96
	ld (_pvx), a
	._pm_poll_pad_horz_right_pvx_lim
	._pm_poll_pad_horz_right_skip
	ld a, 0
	ld (_pfacing), a
	jp	i_128
.i_125
	ld a, (_pvx)
	or a
	jr z, _pm_poll_pad_horz_none_skip
	cp 128
	jp c, _pm_poll_pad_horz_none_positive
	._pm_poll_pad_horz_none_negative
	ld a, (_pvx)
	add 48
	jp m, _pm_poll_pad_horz_none_done
	xor a
	jp _pm_poll_pad_horz_none_done
	._pm_poll_pad_horz_none_positive
	ld a, (_pvx)
	sub 48
	jp p, _pm_poll_pad_horz_none_done
	xor a
	._pm_poll_pad_horz_none_done
	ld (_pvx), a
	._pm_poll_pad_horz_none_skip
.i_128
.i_124
	ld de, (_px)
	ld a, (_pgotten)
	or a
	jr z, _pm_horz_move_pgotten_done
	ld hl, _pgtmx
	call l_gchar
	add hl, de
	ex de, hl
	._pm_horz_move_pgotten_done
	ld hl, _pvx
	call l_gchar
	add hl, de
	ld (_px), hl
	ld de, 64
	ex de, hl
	call l_lt
	jr nc, _pm_horz_move_lefb_done
	ld de, 64
	ld (_px), de
	jp _pm_horz_move_rigb_done
	._pm_horz_move_lefb_done
	ld hl, 3904
	call l_gt
	jr nc, _pm_horz_move_rigb_done
	ld de, 3904
	ld (_px), de
	._pm_horz_move_rigb_done
	ld l, 4
	call l_asr
	ld a, l
	ld (_prx), a
	ld a, (_pry)
	add 6
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld a, (_pry)
	add 15
	srl a
	srl a
	srl a
	srl a
	ld (_cy2), a
	ld hl, _pvx
	call l_gchar
	ex de, hl
	ld hl, _pgtmx
	call l_gchar
	add hl, de
	; ld (_rdsint), hl
	ld a, l
	or h
	jp z, _pm_horz_v_zero
	xor a
	or h
	jp p, _pm_horz_v_pos
	._pm_horz_v_neg
	ld a, (_prx)
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld (_cx2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jp nz, _pm_horz_v_neg_collide
	ld a, (_at2)
	and 8
	jp z, _pm_horz_v_neg_collide_else
	._pm_horz_v_neg_collide
	xor a
	ld (_pvx), a
	ld a, (_cx1)
	inc a
	sla a
	sla a
	sla a
	sla a
	ld (_prx), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_px), hl
	jp _pm_horz_v_coll_done
	._pm_horz_v_neg_collide_else
	jp _pm_horz_v_coll_done
	._pm_horz_v_pos
	ld a, (_prx)
	add 7
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld (_cx2), a
	call _cm_two_points
	ld a, (_at1)
	and 8
	jp nz, _pm_horz_v_pos_collide
	ld a, (_at2)
	and 8
	jp z, _pm_horz_v_pos_collide_else
	._pm_horz_v_pos_collide
	xor a
	ld (_pvx), a
	ld a, (_cx1)
	dec a
	sla a
	sla a
	sla a
	sla a
	add 8
	ld (_prx), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_px), hl
	jp _pm_horz_v_coll_done
	._pm_horz_v_pos_collide_else
	._pm_horz_v_coll_done
	._pm_horz_process_block
	ld a, (_at1)
	and 10
	cp 10
	jr nz, _pm_horz_process_block_1_done
	._pm_horz_process_block_1_do
	ld a, (_cx1)
	ld (___x), a
	ld a, (_cy1)
	ld (___y), a
	ld a, 1
	ld (___d), a
	call _player_process_block
	._pm_horz_process_block_1_done
	ld a, (_cy1)
	ld c, a
	ld a, (_cy2)
	cp c
	jr z, _pm_horz_process_block_2_done
	ld a, (_at2)
	and 10
	cp 10
	jr nz, _pm_horz_process_block_2_done
	._pm_horz_process_block_2_do
	ld a, (_cx2)
	ld (___x), a
	ld a, (_cy2)
	ld (___y), a
	xor a
	ld (___d), a
	call _player_process_block
	._pm_horz_process_block_2_done
	jp _pm_horz_v_done
	._pm_horz_v_zero
	ld a, (_prx)
	and 3
	jr nz, _pm_horz_v_zero_done
	ld a, (_prx)
	and 0xfc
	ld (_prx), a
	ld d, 0
	ld e, a
	ld l, 4
	call l_asl
	ld (_px), hl
	._pm_horz_v_zero_done
	._pm_horz_v_done
	ld a, (_prx)
	add 4
	srl a
	srl a
	srl a
	srl a
	ld (_cx1), a
	ld (_cx2), a
	ld a, (_pry)
	add 8
	srl a
	srl a
	srl a
	srl a
	ld (_cy1), a
	ld (_cy2), a
	call _cm_two_points
	ld a, (_at1)
	and 1
	ld (_evil_tile_hit), a
	ld	hl,_at1
	ld	a,(hl)
	and	#(2 % 256)
	jp	z,i_129
	ld	a,(_cx1)
	ld	(__x),a
	ld	hl,(_cy1)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(__y),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__t),a
	call	_set_map_tile
	ld	hl,2	;const
	push	hl
	call	_sfx_play
	pop	bc
	ld	hl,_ptile_get_ctr
	ld	a,(hl)
	inc	(hl)
	ld	a,(_ptile_get_ctr)
	cp	#(25 % 256)
	jp	nz,i_130
	ld	a,#(0 % 256 % 256)
	ld	(_ptile_get_ctr),a
	ld	hl,_plife
	ld	a,(hl)
	inc	(hl)
	ld	hl,6	;const
	push	hl
	call	_sfx_play
	pop	bc
.i_130
	ld	hl,(_tile_got_offset)
	ld	h,0
	push	hl
	ld	hl,(_cy1)
	ld	h,0
	dec	hl
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_gpit),a
	ld	de,_tile_got
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rda),a
	ld	de,_tile_got
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	push	hl
	ld	hl,(_rda)
	ld	h,0
	push	hl
	ld	hl,_bitmask
	push	hl
	ld	a,(_cx1)
	ld	e,a
	ld	d,0
	ld	l,#(1 % 256)
	call	l_asr_u
	pop	de
	add	hl,de
	ld	l,(hl)
	ld	h,0
	pop	de
	call	l_or
	pop	de
	ld	a,l
	ld	(de),a
.i_129
	ld	a,(_evil_tile_hit)
	and	a
	jp	z,i_131
	ld	a,#(0 % 256 % 256)
	ld	(_pjustjumped),a
	ld	hl,(_pflickering)
	ld	h,0
	call	l_lneg
	jp	nc,i_132
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pwashit),a
	jp	i_133
.i_132
	ld	hl,(_pcx)
	ld	(_px),hl
	ld	hl,(_pcy)
	ld	(_py),hl
	ld	hl,65409	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_133
.i_131
	ld	a,(_pad)
	cp	#(255 % 256)
	jp	z,i_135
	ld	hl,4	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jr	nz,i_136_i_135
.i_135
	jp	i_134
.i_136_i_135
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pfiring),a
	jp	i_137
.i_134
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pfiring),a
.i_137
	ld	hl,(_ppossee)
	ld	h,0
	call	l_lneg
	jp	nc,i_139
	ld	hl,(_pgotten)
	ld	h,0
	call	l_lneg
	jr	c,i_140_i_139
.i_139
	jp	i_138
.i_140_i_139
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_psprid),a
	jp	i_141
.i_138
	ld	hl,_pvx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_143
	ld	hl,_pvx
	call	l_gchar
	call	l_neg
	jp	i_144
.i_143
	ld	hl,_pvx
	call	l_gchar
.i_144
	ld	de,24	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_142
	ld	a,(_prx)
	ld	e,a
	ld	d,0
	ld	l,#(4 % 256)
	call	l_asr_u
	ld	de,3	;const
	call	l_and
	ld	de,1
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_psprid),a
	jp	i_145
.i_142
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_psprid),a
.i_145
.i_141
	ld	de,(_psprid)
	ld	d,0
	ld	hl,(_pfacing)
	ld	h,d
	add	hl,de
	ld	a,l
	ld	(_psprid),a
	ld	hl,_spr_on
	push	hl
	ld	a,(_pflickering)
	cp	#(0 % 256)
	jp	z,i_146
	ld	a,(_half_life)
	and	a
	jp	nz,i_146
	ld	hl,0	;const
	jr	i_147
.i_146
	ld	hl,1	;const
.i_147
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_spr_x
	push	hl
	ld	hl,(_prx)
	ld	h,0
	ld	bc,-4
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_spr_y
	ex	de,hl
	ld	hl,_pry
	ld	a,(hl)
	ld	(de),a
	ld	hl,_spr_next
	push	hl
	ld	hl,_sprite_cells
	push	hl
	ld	hl,(_psprid)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	ld	hl,(_flags+1+1)
	ld	a,l
	and	a
	jp	z,i_148
	ld a, 1
	ld (_spr_on + 4), a
	ld a, (_spr_x + 0)
	ld c, a
	ld a, (_pfacing)
	or a
	jr nz, _add_pumpkin_facing_left
	._add_pumpkin_facing_right
	ld a, c
	sub 4
	jr _add_pumpkin_facing_done
	._add_pumpkin_facing_left
	ld a, c
	add 4
	._add_pumpkin_facing_done
	cp 236
	jr c, _add_pumpkin_set_x
	ld a, c
	._add_pumpkin_set_x
	ld (_spr_x + 4), a
	ld a, (_pry)
	sub 12
	cp 16
	jr nc, _add_pumpkin_set_y
	ld a, 16
	._add_pumpkin_set_y
	ld (_spr_y + 4), a
	ld	hl,_spr_next+8
	push	hl
	ld	hl,_ss_pumpkin
	call	l_pint_pop
	jp	i_149
.i_148
	ld	hl,_spr_on+4
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
.i_149
	ret



._hud_update
	xor a
	ld (__y), a
	ld a, (_opbodycount)
	ld c, a
	ld a, (_pbodycount)
	cp c
	jr z, hud_update_skip_pbodycount
	ld a, 20
	ld (__x), a
	ld hl, (_c_level)
	ld bc, 13
	add hl, bc
	ld c, (hl)
	ld a, (_pbodycount)
	ld b, a
	ld a, c
	sub b
	ld (__n), a
	call _p_t2
	ld a, (_pbodycount)
	ld (_opbodycount), a
	.hud_update_skip_pbodycount
	ld a, (_oplife)
	ld c, a
	ld a, (_plife)
	cp c
	jr z, hud_update_skip_plife
	ld a, 29
	ld (__x), a
	ld a, (_plife)
	ld (__n), a
	call _p_t2
	ld a, (_plife)
	ld (_oplife), a
	.hud_update_skip_plife
	ld a, 1
	ld (__y), a
	ld a, (_optile_get_ctr)
	ld c, a
	ld a, (_ptile_get_ctr)
	cp c
	jr z, hud_update_skip_ptile_get_ctr
	ld a, 7
	ld (__x), a
	ld a, (_ptile_get_ctr)
	ld (__n), a
	call _p_t2
	ld a, (_ptile_get_ctr)
	ld (_optile_get_ctr), a
	.hud_update_skip_ptile_get_ctr
	ld a, (_opobjs)
	ld c, a
	ld a, (_pobjs)
	cp c
	jr z, hud_update_skip_pobjs
	ld a, 20
	ld (__x), a
	ld hl, (_c_level)
	ld bc, 5
	add hl, bc
	ld c, (hl)
	ld a, (_pobjs)
	ld b, a
	ld a, c
	sub b
	ld (__n), a
	call _p_t2
	ld a, (_pobjs)
	ld (_opobjs), a
	.hud_update_skip_pobjs
	ld a, (_opkeys)
	ld c, a
	ld a, (_pkeys)
	cp c
	jr z, hud_update_skip_pkeys
	ld a, 29
	ld (__x), a
	ld a, (_pkeys)
	ld (__n), a
	call _p_t2
	ld a, (_pkeys)
	ld (_opkeys), a
	.hud_update_skip_pkeys
	ret



._level_setup
	ld	hl,_levels
	push	hl
	ld	hl,(_level)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_c_level),hl
	ld	bc,4
	add	hl,bc
	ld	a,(hl)
	ld	(_c_level_map_w),a
	ld	hl,(_c_level)
	ld	bc,6
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_map
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,7
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_locks
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,8
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_enems
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,9
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_hotspots
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,10
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_behs
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,11
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_ts0
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ld	hl,(_c_level)
	ld	bc,12
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_tsmaps
	push	hl
	call	_librarian_get_resource
	pop	bc
	pop	bc
	ret



._game_shutdown_sprites
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_150
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_151
	ld	de,_spr_on
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_150
.i_151
	ret



._game_init
	call	_enems_persistent_deaths_init
	call	_hotspots_ini
	call	_bolts_load
	ld	hl,(_c_level)
	inc	hl
	inc	hl
	inc	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_n_pant),a
	call	_player_init
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pbodycount),a
	ld	(_pobjs),a
	ld	a,l
	ld	(_pkeys),a
	ld	hl,_flags+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_opbodycount),a
	ld	(_opkeys),a
	ld	h,0
	ld	a,l
	ld	(_opobjs),a
	ld	(_oplife),a
	ld	h,0
	ld	a,l
	ld	(_on_pant),a
	ld	a,#(255 % 256 % 256)
	ld	(_optile_get_ctr),a
	ld	a,#(1 % 256 % 256)
	ld	(_max_hotspots_type_1),a
	ld	a,#(1 % 256 % 256)
	ld	(_first_time),a
	ld	hl,_hud_rle
	ld	(_gp_aux),hl
	call	_unrle
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_springs_on),a
	ld hl, _tile_got
	ld de, _tile_got + 1
	xor a
	ld (hl), a
	ld bc, 20*12-1
	ldir
	ld	hl,_spr_on+4
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_spr_next+8
	push	hl
	ld	hl,_ss_pumpkin
	call	l_pint_pop
	ld	a,(_level)
	and	a
	jp	z,i_152
	ld	hl,_my_inks2
	jp	i_153
.i_152
	ld	hl,_my_inks
.i_153
	push	hl
	call	__pal_set
	pop	bc
	ld	a,(_level)
	ld	(_springs_on),a
	ld	hl,(_level)
	ld	h,0
	ld	a,l
	ld	(_olevel),a
	ret



._game_prepare_screen
	call	_draw_scr
	call	_bolts_update_screen
	call	_hotspots_load
	ld	a,(_first_time)
	and	a
	jp	z,i_154
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_first_time),a
.i_154
.i_155
	call	_enems_load
	call	_enems_do
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_156
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_157
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,10
	add	hl,bc
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,11
	add	hl,bc
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_156
.i_157
	call	cpc_ResetTouchedTiles
	ld	hl,0	;const
	call	cpc_ShowTileMap
	ret



._game_loop
	call	cpc_ResetTouchedTiles
	call	_hud_update
	call	cpc_ShowTouchedTiles
	call	cpc_ResetTouchedTiles
	ld	hl,_flags+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	a,#(1 % 256 % 256)
	ld	(_do_game),a
	ld	a,#(0 % 256 % 256)
	ld	(_pkilled),a
	ld	hl,2	;const
	push	hl
	call	_music_play
	pop	bc
.i_158
	ld	hl,(_do_game)
	ld	a,l
	and	a
	jp	z,i_159
	xor a
	ld (_rda), a
	ld a, (_prx)
	cp 4
	jp nz, _ml_flick_screen_horz_else
	ld hl, _pvx
	call l_gchar
	ld de, 0
	ex de, hl
	call l_lt
	jp nc, _ml_flick_screen_horz_else
	ld a, (_n_pant)
	or a
	jr z, _ml_flick_screen_horz_else
	ld hl, _n_pant
	dec (hl)
	ld hl, 3904
	ld (_px), hl
	ld a, 1
	ld (_rda), a
	jp _ml_flick_screen_horz_done
	._ml_flick_screen_horz_else
	ld a, (_prx)
	cp 244
	jp nz, _ml_flick_screen_horz_done
	ld hl, _pvx
	call l_gchar
	ld de, 0
	ex de, hl
	call l_gt
	jp nc, _ml_flick_screen_horz_done
	ld hl, _n_pant
	inc (hl)
	ld hl, 64
	ld (_px), hl
	ld a, 2
	ld (_rda), a
	._ml_flick_screen_horz_done
	ld a, (_pry)
	cp 16
	jr z, _ml_flick_screen_vert_continue1
	jr nc, _ml_flick_screen_vert_else
	._ml_flick_screen_vert_continue1
	ld hl, _pvy
	call l_gchar
	ld de, 0
	ex de, hl
	call l_lt
	jp nc, _ml_flick_screen_vert_else
	ld a, (_c_level_map_w)
	ld c, a
	ld a, (_n_pant)
	sub c
	ld (_n_pant), a
	ld hl, 2944
	ld (_py), hl
	._ml_flick_screen_up_vy_boost
	ld a, -96
	ld (_pvy), a
	xor a
	ld (_pctj), a
	inc a
	ld (_pj), a
	ld (_pjustjumped), a
	._ml_flick_screen_up_vy_boost_do
	ld a, 3
	ld (_rda), a
	jp _ml_flick_screen_vert_done
	._ml_flick_screen_vert_else
	ld a, (_pry)
	cp 184
	jp c, _ml_flick_screen_vert_done
	ld hl, _pvy
	call l_gchar
	ld de, 0
	ex de, hl
	call l_gt
	jp nc, _ml_flick_screen_vert_done
	ld a, (_c_level_map_w)
	ld c, a
	ld a, (_n_pant)
	add c
	ld (_n_pant), a
	ld hl, 256
	ld (_py), hl
	ld a, 4
	ld (_rda), a
	._ml_flick_screen_vert_done
	._mk_flick
	ld a, (_n_pant)
	ld c, a
	ld a, (_on_pant)
	cp c
	jr z, _ml_flick_skip
	ld a, (_do_game)
	or a
	jr z, _ml_flick_skip
	ld hl, (_px)
	ex de, hl
	ld l, 4
	call l_asr ; -> L
	ld a, l
	ld (_prx), a
	ld hl, (_py)
	ex de, hl
	ld l, 4
	call l_asr ; -> L
	ld a, l
	ld (_pry), a
	call _game_prepare_screen
	ld a, (_n_pant)
	ld (_on_pant), a
	xor a
	ld (_isrc), a
	ld (_isrc_max), a
	._ml_flick_skip
	ld a, (_half_life)
	ld c, a
	ld a, 1
	sub c
	ld (_half_life), a
	ld (_hl_proc), a
	ld hl, _frame_counter
	inc (hl)
	ld a, (_ticker)
	inc a
	cp 16
	jr nz, _mltrs
	xor a
	._mltrs
	ld (_ticker), a
	ld	hl,0	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pgtmy),a
	ld	a,l
	ld	(_pgtmx),a
	ld	(_pgotten),a
	call	_enems_do
	call	_player_move
	call	_hotspots_do
	call	_hud_update
	ld a, (_isrc_max)
	ld c, a
	ld a, (_isrc)
	cp c
	jr c, _mlmaxisrcsk
	ld (_isrc_max), a
	._mlmaxisrcsk
	.main_loop_isrc_wait
	ld a, (_isrc)
	cp 18
	jr nc, main_loop_isrc_continue
	jr main_loop_isrc_wait
	.main_loop_isrc_continue
	xor a
	ld (_isrc), a
	ld a, (_level)
	or a
	jr nz, _main_loop_custom_level_1
	._main_loop_custom_level_0
	ld a, (_n_pant)
	cp 2
	jr z, _main_loop_custom_level_0_totem
	cp 7
	jr z, _main_loop_custom_level_0_totem
	cp 12
	jr z, _main_loop_custom_level_0_totem
	cp 17
	jr z, _main_loop_custom_level_0_totem
	jp _main_loop_custom_end
	._main_loop_custom_level_1
	ld a, (_n_pant)
	cp 18
	jp nz, _main_loop_custom_end
	._main_loop_custom_level_1_totem
	ld a, (_pry)
	cp 128
	jr c, _main_loop_custom_end
	jr _main_loop_custom_level_X_totem
	._main_loop_custom_level_0_totem
	ld a, (_pry)
	cp 160
	jr c, _main_loop_custom_end
	._main_loop_custom_level_X_totem
	ld a, (_prx)
	cp 7*16-4
	jr c, _main_loop_custom_end
	ld a, (_prx)
	ld c, a
	ld a, 7*16+15+4
	cp c
	jr c, _main_loop_custom_end
	ld a, (_flags + 2)
	or a
	jr z, _main_loop_custom_end
	xor a
	ld (_flags + 2), a
	ld a, (_pobjs)
	inc a
	ld (_pobjs), a
	ld	hl,6	;const
	push	hl
	call	_sfx_play
	pop	bc
	._main_loop_custom_end
	ld	a,(_do_game)
	cp	#(0 % 256)
	jp	nz,i_161
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_on_pant)
	ld	h,d
	call	l_ne
	jr	c,i_162_i_161
.i_161
	jp	i_160
.i_162_i_161
	jp	i_158
.i_160
.i_163
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_164
	ld	a,(_gpit)
	and	a
	jp	z,i_165
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	de,_spr_on
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jp	z,i_166
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	de,_spr_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,6
	add	hl,bc
	call	l_gchar
	pop	de
	add	hl,de
	ex	de,hl
	ld	l,#(2 % 256)
	call	l_asr_u
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,9
	add	hl,bc
	push	hl
	ld	de,_spr_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	ld	bc,-16
	add	hl,bc
	push	hl
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,7
	add	hl,bc
	call	l_gchar
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_spr_next
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	jp	i_167
.i_166
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,_ss_empty
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,8
	add	hl,bc
	push	hl
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	bc,9
	add	hl,bc
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	pop	de
	ld	a,l
	ld	(de),a
.i_167
	jp	i_164
.i_165
	call	_cpc_screen_update
	ld	hl,(_pwashit)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_hit
.i_168
	ld	a,(_pkilled)
	and	a
	jp	z,i_169
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_do_game),a
.i_169
	ld	hl,(_pobjs)
	ld	h,0
	push	hl
	ld	hl,(_c_level)
	ld	bc,5
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	pop	de
	call	l_eq
	jp	nc,i_171
	ld	hl,(_pbodycount)
	ld	h,0
	push	hl
	ld	hl,(_c_level)
	ld	bc,13
	add	hl,bc
	ld	l,(hl)
	ld	h,0
	pop	de
	call	l_eq
	jr	c,i_172_i_171
.i_171
	jp	i_170
.i_172_i_171
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_do_game),a
.i_170
	jp	i_158
.i_159
	call	_music_stop
	ret



._game_title
	call	_music_stop
	ld	hl,_title_rle
	ld	(_gp_aux),hl
	call	_unrle
.i_173
	ld	a,#(6 % 256 % 256)
	ld	(__x),a
	ld	a,#(15 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+61
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0	;const
	call	cpc_ShowTileMap
.i_174
	call	cpc_AnyKeyPressed
	ld	a,h
	or	l
	jp	nz,i_174
.i_175
.i_176
	ld	hl,7	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jp	z,i_178
	call	_controls_setup
	jp	i_173
.i_178
	ld	hl,6	;const
	call	cpc_TestKey
	ld	a,h
	or	l
	jr	nz,i_177
.i_179
	jp	i_176
.i_177
	ret



._game_over
	ld	hl,0	;const
	call	_cpc_clear_rect
	ld	a,#(71 % 256 % 256)
	ld	(_rdc),a
	ld	a,#(11 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+105
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0	;const
	call	cpc_ShowTileMap
	call	_wait_button
	call	_music_stop
	ret



._game_level
	ld	hl,0	;const
	call	_cpc_clear_rect
	ld	a,#(71 % 256 % 256)
	ld	(_rdc),a
	ld	a,#(12 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+116
	push	hl
	call	_p_s
	pop	bc
	ld	a,#(18 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	hl,(_level)
	ld	h,0
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__n),a
	call	_p_t2
	ld	hl,0	;const
	call	cpc_ShowTileMap
	call	_wait_button
	call	_music_stop
	ret



._game_ending
	ld	hl,2	;const
	push	hl
	call	_music_play
	pop	bc
	ld	hl,_ending_rle
	ld	(_gp_aux),hl
	call	_unrle
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(14 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+122
	push	hl
	call	_p_s
	pop	bc
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(16 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+145
	push	hl
	call	_p_s
	pop	bc
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(18 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+169
	push	hl
	call	_p_s
	pop	bc
	ld	a,#(3 % 256 % 256)
	ld	(__x),a
	ld	a,#(20 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+196
	push	hl
	call	_p_s
	pop	bc
	ld	hl,0	;const
	call	cpc_ShowTileMap
	ld	hl,6	;const
	push	hl
	call	_sfx_play
	pop	bc
	call	_wait_button
	call	_music_stop
	ld	hl,0	;const
	call	_cpc_clear_rect
	ld	hl,0	;const
	call	cpc_ShowTileMap
	ret



._main
	call	_system_init
.i_180
	call	_game_title
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_olevel),a
	ld	(_level),a
	ld	a,#(5 % 256 % 256)
	ld	(_plife),a
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_ptile_get_ctr),a
.i_182
	call	_game_level
	call	_level_setup
	call	_game_init
	call	_game_loop
	ld	hl,(_pkilled)
	ld	a,l
	and	a
	jp	z,i_184
	call	_game_over
	jp	i_183
.i_184
	ld	a,(_level)
	cp	#(2 % 256)
	jp	z,i_186
	jp	nc,i_186
	ld	hl,_level
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_187
.i_186
	call	_game_ending
	jp	i_183
.i_187
.i_185
	jp	i_182
.i_183
	jp	i_180
.i_181
	ret


;	SECTION	text

.i_1
	defm	"                     /        "
	defm	"             "
	defb	0

	defm	"PRESS A KEY FOR:"
	defb	0

	defm	"PRESS ESC TO REDEFINE/PRESS EN"
	defm	"TER TO START "
	defb	0

	defm	"GAME OVER!"
	defb	0

	defm	"LEVEL"
	defb	0

	defm	"BLOODY BATUCADAS, THEY"
	defb	0

	defm	"ALMOST MADE ME LATE FOR"
	defb	0

	defm	"THE GREATEST BAND ON EARTH"
	defb	0

	defm	"I HOPE THEY ROCK DA PLACE!"
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._spr_next	defs	10
.__en_x1	defs	1
.__en_x2	defs	1
.__en_y1	defs	1
.__en_y2	defs	1
._safe_n_pant	defs	1
._genflipflop	defs	1
.__en_ct	defs	1
._objs_taken_i	defs	1
._flip_flop	defs	1
._half_life	defs	1
.__en_mx	defs	1
.__en_my	defs	1
._pemmeralds	defs	1
._en_fr	defs	1
._spr_order	defs	5
._pregotten	defs	1
._pstatespradder	defs	1
._pfacing	defs	1
._lkact	defs	4
._gpint	defs	2
._evil_tile_hit	defs	1
._guay_ct	defs	1
._level	defs	1
._no_ct	defs	1
._t1	defs	1
._t2	defs	1
.__n	defs	1
.__t	defs	1
._plife	defs	1
.__x	defs	1
.__y	defs	1
._tile_got_offset	defs	1
._pobjs	defs	1
._pj	defs	1
._pkeys	defs	1
._px	defs	2
._py	defs	2
._pgtmx	defs	1
._pgtmy	defs	1
._pnude	defs	1
._c_level	defs	2
._is_platform	defs	1
._pstep	defs	1
._gp_gen	defs	2
._spr_x	defs	5
._spr_y	defs	5
._first_time	defs	1
._pcharacter	defs	1
._gp_aux	defs	2
._gp_map	defs	2
._on_pant	defs	1
._pfiring	defs	1
._gp_int	defs	2
._enoffs	defs	1
._pad_this_frame	defs	1
._pad0	defs	1
._n_pant	defs	1
._arkc	defs	1
._hitter_x	defs	1
._hitter_y	defs	1
._c_level_map_w	defs	1
._pkilled	defs	1
._gpit	defs	1
._gpjt	defs	1
._rdch	defs	1
._rdct	defs	1
._isrc	defs	1
._pctj	defs	1
._pjustjumped	defs	1
._phit	defs	1
._pbodycount	defs	1
._opbodycount	defs	1
.__d1	defs	1
.__d2	defs	1
._pinv	defs	1
._pgotten	defs	1
._encelloffset	defs	1
.__en_state	defs	1
._rdxx	defs	1
._rdyx	defs	1
._rdyy	defs	1
._at1	defs	1
.___d	defs	1
._at2	defs	1
._cx1	defs	1
._cx2	defs	1
._cy1	defs	1
._cy2	defs	1
.___x	defs	1
.___y	defs	1
._pframe	defs	1
._pfixct	defs	1
._do_game	defs	1
._objs_taken	defs	12
._olevel	defs	1
._safe_prx	defs	1
._safe_pry	defs	1
._pad	defs	1
._frame_counter	defs	1
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._rdd	defs	1
._rde	defs	1
._rdf	defs	1
._pjb	defs	1
._hrt	defs	1
._rdi	defs	1
._hrx	defs	1
._hry	defs	1
._pcx	defs	2
._pcy	defs	2
._rds	defs	1
._rdt	defs	1
._rdx	defs	1
._rdy	defs	1
._rdsint	defs	2
._ticker	defs	1
._oplife	defs	1
._prx	defs	1
._pry	defs	1
._pvx	defs	1
._pvy	defs	1
._opobjs	defs	1
._tm_ctr	defs	1
._opkeys	defs	1
._max_hotspots_type_1	defs	1
._pflickering	defs	1
._opstars	defs	1
._pwashit	defs	1
._ppossee	defs	1
._hitter_frame	defs	1
._isrc_max	defs	1
._spr_id	defs	1
._pstars	defs	1
._use_ct	defs	1
._psprid	defs	1
._hitter_hs_x	defs	1
._hitter_hs_y	defs	1
._spr_on	defs	5
._spr_idx	defs	1
._pthrust	defs	1
._springs_on	defs	1
._hl_proc	defs	1
._ptile_get_ctr	defs	1
._optile_get_ctr	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	XDEF	_map_base_address
	XDEF	__en_t
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_cpc_show_updated
	XDEF	_hotspots
	XDEF	_draw_scr
	XDEF	_spr_next
	XDEF	_trpixlutc
	LIB	cpc_PrintGphStrXY
	XDEF	_level1_enems_c
	LIB	cpc_PrintGphStrStdXY
	XDEF	_set_map_tile
	LIB	cpc_PutTiles
	XDEF	_game_title
	XDEF	_player_register_safe_spot
	XDEF	_player_restore_safe_spot
	XDEF	__en_x1
	XDEF	__en_x2
	XDEF	__en_y1
	XDEF	__en_y2
	XDEF	_safe_n_pant
	LIB	cpc_PrintGphStrM12X
	XDEF	_genflipflop
	XDEF	_enems_load
	XDEF	_delay
	XDEF	__en_ct
	XDEF	_objs_taken_i
	XDEF	_ss_pumpkin
	XDEF	_en_x1
	defc	_en_x1	=	54847
	XDEF	_flip_flop
	XDEF	_en_y1
	defc	_en_y1	=	54850
	XDEF	_en_x2
	defc	_en_x2	=	54853
	XDEF	_en_y2
	defc	_en_y2	=	54856
	XDEF	__pal_set
	XDEF	_half_life
	XDEF	_player_hit
	LIB	cpc_ShowScrTileMap
	XDEF	__en_mx
	XDEF	__en_my
	LIB	cpc_SetMode
	XREF	__enf_x
	LIB	cpc_ClrScr
	XDEF	_pemmeralds
	XREF	__enf_y
	XDEF	_en_hl
	defc	_en_hl	=	54784
	XDEF	_en_ct
	defc	_en_ct	=	54868
	XDEF	_en_fr
	LIB	cpc_SetModo
	XDEF	_sprite_cells
	LIB	cpc_PutMaskSpriteTileMap2b
	LIB	cpc_PutTrSpriteTileMap2b
	XDEF	_flags
	defc	_flags	=	53243
	LIB	cpc_SetInkGphStr
	XDEF	_scr_buff
	defc	_scr_buff	=	52928
	XDEF	_enf_x
	defc	_enf_x	=	54820
	XDEF	_en_facing
	defc	_en_facing	=	54793
	XDEF	_enf_y
	defc	_enf_y	=	54829
	XDEF	_en_mx
	defc	_en_mx	=	54859
	XDEF	_en_my
	defc	_en_my	=	54862
	XDEF	_draw_tile
	XDEF	_bolts_load
	LIB	cpc_ShowTouchedTiles2
	XDEF	_player_reset_movement
	XREF	_END_OF_MAIN_BIN
	LIB	cpc_SetTile
	XDEF	_scr_attr
	defc	_scr_attr	=	52736
	XDEF	_enems
	XDEF	_spr_order
	XDEF	_library
	XDEF	_enems_drain
	LIB	cpc_CollSp
	LIB	cpc_PutMaskSp4x16
	XDEF	_pregotten
	XDEF	_pstatespradder
	XDEF	_scr_rand
	LIB	cpc_PrintGphStrStd
	XDEF	_pfacing
	XDEF	_level0_locks_c
	XDEF	_lkact
	XDEF	_hud_rle
	XDEF	_rand8
	XDEF	_gpint
	XDEF	_seed1
	XDEF	_seed2
	LIB	cpc_ShowTileMap
	XDEF	_evil_tile_hit
	XDEF	_guay_ct
	XDEF	_keyscancodes
	XDEF	_level
	LIB	cpc_PutTile2x8
	XDEF	_locks
	LIB	cpc_ShowScrTileMap2
	LIB	cpc_Uncrunch
	XDEF	_no_ct
	XDEF	_hotspots_load
	XDEF	_t1
	XDEF	_t2
	XDEF	_dss_msb_invfunc
	XDEF	_dss_lsb_invfunc
	LIB	cpc_SpRLM1
	XDEF	__n
	XDEF	_librarian_get_resource
	XDEF	_en_gen_washit
	defc	_en_gen_washit	=	54808
	XDEF	_game_prepare_screen
	XDEF	__t
	XDEF	_plife
	XDEF	__x
	XDEF	__y
	XDEF	_player_init
	XDEF	_tile_got_offset
	XDEF	_level0_hotspots_c
	XDEF	_level1_hotspots_c
	LIB	cpc_PrintGphStrXY2X
	LIB	cpc_SpRRM1
	XDEF	_pobjs
	XDEF	_m0_c
	XDEF	_pj
	LIB	cpc_PrintGphStrXYM1
	XREF	__enf_vx
	XDEF	_pkeys
	XREF	__enf_vy
	XDEF	_cpc_screen_update
	LIB	cpc_PutSpriteXOR
	XDEF	_px
	XDEF	_py
	XDEF	_pgtmx
	XDEF	_pgtmy
	XDEF	_ts
	XREF	_ss
	LIB	cpc_TestKey
	LIB	cpc_PutSprite
	XDEF	_my_inks2
	XDEF	_player_move
	LIB	cpc_PutSpTileMap4x8
	LIB	cpc_PutSpTileMap
	LIB	cpc_InitTileMap
	XDEF	_pnude
	XDEF	_jitter_big
	XDEF	_srand
	XDEF	_sp_sw
	defc	_sp_sw	=	58880
	XDEF	_cm_two_points
	LIB	cpc_TouchTileXY
	LIB	cpc_SetTouchTileXY
	XDEF	_player_process_block
	XDEF	_enf_vx
	defc	_enf_vx	=	54826
	XDEF	_enf_vy
	defc	_enf_vy	=	54835
	XDEF	_c_level
	XDEF	_enems_persistent_deaths_init
	XDEF	_fanty_timer
	defc	_fanty_timer	=	54817
	XDEF	_is_platform
	XDEF	_alter_map
	XDEF	_pstep
	XDEF	_en_gen_life
	defc	_en_gen_life	=	54814
	XDEF	_randres
	XDEF	_gp_gen
	XDEF	_spr_x
	XDEF	_spr_y
	XDEF	_first_time
	XDEF	_pcharacter
	XDEF	_gp_aux
	XDEF	_gp_map
	XDEF	_on_pant
	XDEF	_unrle
	XDEF	_pfiring
	XDEF	_gp_int
	XDEF	_enoffs
	LIB	cpc_PutSpTr
	XDEF	_pad_this_frame
	LIB	cpc_DisableFirmware
	LIB	cpc_EnableFirmware
	XDEF	_behs
	XDEF	_tile_got
	defc	_tile_got	=	50960
	LIB	cpc_PrintGphStrXYM12X
	LIB	cpc_SetInk
	XDEF	_pad0
	XDEF	__tile_address
	XDEF	_hact
	defc	_hact	=	54871
	XDEF	_n_pant
	XDEF	_arkc
	XDEF	_unrle_adv
	LIB	cpc_SetBorder
	XDEF	_ktext_0
	XDEF	_ktext_1
	LIB	cpc_RLI
	XDEF	_en_s
	defc	_en_s	=	54790
	XDEF	_en_t
	defc	_en_t	=	54838
	XDEF	_en_v
	defc	_en_v	=	54805
	XDEF	_ktext_2
	XDEF	_en_x
	defc	_en_x	=	54841
	XDEF	_en_y
	defc	_en_y	=	54844
	XDEF	_p_t2
	XDEF	_system_init
	XDEF	_advance_worm
	XDEF	_level0
	LIB	cpc_RRI
	LIB	cpc_GetSp
	XDEF	_level0_ts_patterns_c
	XDEF	_level1_ts_patterns_c
	XDEF	_level1
	XDEF	_hitter_x
	XDEF	_hitter_y
	LIB	cpc_SpUpdX
	LIB	cpc_SpUpdY
	LIB	cpc_PutTile4x16
	XDEF	_main
	XDEF	_c_level_map_w
	XDEF	_pkilled
	LIB	cpc_ResetTouchedTiles
	LIB	cpc_ShowTouchedTiles
	XDEF	_gpit
	LIB	cpc_PutMaskSp2x8
	XDEF	_gpjt
	LIB	cpc_ScanKeyboard
	LIB	cpc_SetColour
	XDEF	_rdch
	XDEF	_hotspots_ini
	XDEF	_hud_update
	XDEF	_rdct
	XDEF	_isrc
	XDEF	_sfx_play
	XDEF	_level0_ts_tilemaps_c
	XDEF	_pctj
	XDEF	_level1_ts_tilemaps_c
	XDEF	_levels
	LIB	cpc_DeleteKeys
	XDEF	_pjustjumped
	XDEF	_phit
	XDEF	_pbodycount
	XDEF	_opbodycount
	XDEF	_ending_rle
	XDEF	__d1
	XDEF	__d2
	XDEF	_pinv
	XDEF	_pgotten
	XDEF	_encelloffset
	XDEF	_level0_behs_c
	LIB	cpc_PutMaskSpTileMap2b
	LIB	cpc_PutTrSpTileMap2b
	LIB	cpc_PutORSpTileMap2b
	LIB	cpc_PutSpTileMap2b
	LIB	cpc_PutCpSpTileMap2b
	LIB	cpc_PutTrSp4x8TileMap2b
	LIB	cpc_UpdScr
	LIB	cpc_PutTrSp8x16TileMap2b
	LIB	cpc_PutTrSp8x24TileMap2b
	XDEF	__en_state
	XDEF	_rdxx
	XDEF	_rdyx
	XDEF	_rdyy
	XDEF	_draw_tile_advance
	LIB	cpc_ScrollLeft0
	XDEF	_my_inks
	XDEF	_hotspots_paint
	XDEF	_at1
	XDEF	___d
	XDEF	_at2
	LIB	cpc_AnyKeyPressed
	XDEF	_button_pressed
	XDEF	_cx1
	XDEF	_cx2
	LIB	cpc_AssignKey
	XDEF	_cy1
	XDEF	_cy2
	XDEF	___x
	XDEF	___y
	XDEF	_pframe
	LIB	cpc_TouchTiles
	LIB	cpc_ScrollRight0
	XDEF	_ss_enems
	XDEF	_pfixct
	LIB	cpc_PrintGphStr
	XDEF	_game_ending
	XDEF	_do_game
	XDEF	_objs_taken
	XDEF	_en_dying
	defc	_en_dying	=	54796
	XDEF	_dss_lsb_ox
	LIB	cpc_UnExo
	XDEF	_dss_lsb_oy
	XDEF	_olevel
	XDEF	_level_setup
	LIB	cpc_SetInkGphStrM1
	XDEF	_safe_prx
	XDEF	_safe_pry
	XDEF	_pad
	XDEF	_ts0
	XDEF	_map
	XDEF	_hotspots_do
	XDEF	_frame_counter
	LIB	cpc_UpdateTileMap
	XDEF	_ep_killed
	defc	_ep_killed	=	63216
	XDEF	_rda
	XDEF	_rdb
	XDEF	_rdc
	XDEF	_rdd
	XDEF	_rde
	XDEF	_rdf
	XDEF	_pjb
	XDEF	_hrt
	XDEF	_rdi
	XDEF	_p_s
	XDEF	_ss_empty
	XDEF	_hrx
	XDEF	_hry
	XDEF	_pcx
	XDEF	_pcy
	XDEF	_level1_behs_c
	XDEF	_dss_msb_ox
	XDEF	_rds
	LIB	cpc_TestKeyF
	XDEF	_rdt
	XDEF	_dss_msb_oy
	XDEF	_ktexts
	XDEF	_rdx
	XDEF	_rdy
	XDEF	_bolts_clear_bolt
	XDEF	_rdsint
	XDEF	_wait_button
	XDEF	_enems_restore_vals
	XDEF	_ticker
	XDEF	_oplife
	LIB	cpc_PutSpTileMap8x16
	LIB	cpc_PutSpTileMap8x24
	XDEF	_prx
	XDEF	_pry
	XDEF	_bitmask
	XDEF	_draw_tile_upd
	LIB	cpc_ReadTile
	LIB	cpc_PutMaskSprite
	XDEF	_controls_setup
	XDEF	_pvx
	XDEF	_pvy
	XDEF	_en_life
	defc	_en_life	=	54787
	XDEF	_opobjs
	XDEF	_level0_enems_c
	LIB	cpc_PutSpTileMapO
	XDEF	_bolts_update_screen
	LIB	cpc_PutSp
	XDEF	_en_washit
	defc	_en_washit	=	54799
	XDEF	_tm_ctr
	LIB	cpc_UpdScrAddresses
	XDEF	_opkeys
	XDEF	_halt_me
	XDEF	_ss_main
	XDEF	_dss_msb_updfunc
	XDEF	_dss_lsb_updfunc
	XDEF	_ss_extra
	XDEF	_title_rle
	XDEF	_cpc_clear_rect
	XDEF	_max_hotspots_type_1
	XDEF	_draw_scr_buffer
	XDEF	_pflickering
	XDEF	_opstars
	XREF	_nametable
	XDEF	_pwashit
	LIB	cpc_TouchTileSpXY
	XDEF	_en_fishing
	defc	_en_fishing	=	54802
	XDEF	_music_play
	LIB	cpc_SuperbufferAddress
	LIB	cpc_GetScrAddress
	XDEF	_ss_small
	XDEF	_en_state
	defc	_en_state	=	54865
	XDEF	_ppossee
	LIB	cpc_PutMaskSp
	XDEF	_collide
	XDEF	_hitter_frame
	XDEF	_isrc_max
	LIB	cpc_RedefineKey
	XDEF	_game_init
	XDEF	_level0_map_c
	XDEF	_game_level
	XDEF	_ram_destination
	XDEF	_spr_id
	XDEF	_pstars
	XDEF	_use_ct
	XDEF	_psprid
	XDEF	_hitter_hs_x
	XDEF	_hitter_hs_y
	LIB	cpc_GetTiles
	XDEF	_unpack
	XDEF	_game_shutdown_sprites
	XDEF	_spr_on
	XDEF	_game_loop
	XDEF	_enems_do
	XDEF	_spr_idx
	XDEF	_pthrust
	LIB	cpc_PutSpXOR
	LIB	cpc_PrintStr
	XDEF	_music_stop
	XDEF	_en_gen_dying
	defc	_en_gen_dying	=	54811
	XDEF	_springs_on
	LIB	cpc_PrintGphStr2X
	XDEF	_level1_map_c
	XDEF	_game_over
	LIB	cpc_PrintGphStrM1
	XDEF	_tsmaps
	XDEF	_hl_proc
	XDEF	_ram_address
	XDEF	_ptile_get_ctr
	XDEF	_optile_get_ctr


; --- End of Scope Defns ---


; --- End of Compilation ---
