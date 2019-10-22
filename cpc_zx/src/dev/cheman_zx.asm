;* * * * *  Small-C/Plus z88dk * * * * *
;  Version: 20100416.1
;
;	Reconstructed for z80 Module Assembler
;
;	Module compile time: Tue Oct 01 11:05:01 2019



	MODULE	mk3.c


	INCLUDE "z80_crt0.hdr"


;	SECTION	text

._spritesClipValues
	defb	2
	defb	0
	defb	22
	defb	32

;	SECTION	code

;	SECTION	text

._fsRect
	defb	0
	defb	0
	defb	24
	defb	32

;	SECTION	code

	._level0_map_c
	BINARY "../ports/zx/bin/level0/map.c.bin"
	._level0_locks_c
	BINARY "../ports/zx/bin/level0/locks.c.bin"
	._level0_enems_c
	BINARY "../ports/zx/bin/level0/enems.c.bin"
	._level0_hotspots_c
	BINARY "../ports/zx/bin/level0/hotspots.c.bin"
	._level0_ts_patterns_c
	BINARY "../ports/zx/bin/level0/ts.patterns.c.bin"
	._level0_ts_tilemaps_c
	BINARY "../ports/zx/bin/level0/ts.tilemaps.c.bin"
	._level0_behs_c
	BINARY "../ports/zx/bin/level0/behs.c.bin"
	._level1_map_c
	BINARY "../ports/zx/bin/level1/map.c.bin"
	._level1_enems_c
	BINARY "../ports/zx/bin/level1/enems.c.bin"
	._level1_hotspots_c
	BINARY "../ports/zx/bin/level1/hotspots.c.bin"
	._level1_ts_patterns_c
	BINARY "../ports/zx/bin/level1/ts.patterns.c.bin"
	._level1_ts_tilemaps_c
	BINARY "../ports/zx/bin/level1/ts.tilemaps.c.bin"
	._level1_behs_c
	BINARY "../ports/zx/bin/level1/behs.c.bin"
;	SECTION	text

._library
	defw	0
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
	._ts
	; First, the main font. Must be 64 chars (512 bytes) long.
	BINARY "../ports/zx/bin/ts.bin"
	._ts0
	; Then, space for the remaining 88 characters (704 bytes).
	defs 704
	._tslevel
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
	._ss
	; Dummy 8 empty (masked) spaces for vertical rotation
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	defb 0, 255
	._ss_main
	; First, space for / include the main characters
	; 9 cells, 192 bytes each
	BINARY "../ports/zx/bin/ssch.bin"
	._ss_enems
	; Second, space for the enemies / etc.
	; 0 masked cells (144 * EXTRA_SPRITES)
	; defs 0 * 192
	; 6 cells, 192 bytes each
	BINARY "../ports/zx/bin/ssen.bin"
	._ss_extra
	; Third, assorted extra stuff
	; 2 cells, 144 bytes
	BINARY "../ports/zx/bin/ssextra.bin"
	._ss_pumpkin
	BINARY "../ports/zx/bin/sspumpkin.bin"
	._ss_small
	; Small sprites
	; defs 1 * 64
	; 1 cell, 64 bytes
	BINARY "../ports/zx/bin/sssmall.bin"
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
	BINARY "../ports/zx/bin/title.rle.bin"
	._hud_rle
	BINARY "../ports/zx/bin/hud.rle.bin"
	._ending_rle
	BINARY "../ports/zx/bin/ending.rle.bin"
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
	defb	1

	defm	""
	defb	2

	defm	""
	defb	3

	defm	""
	defb	4

	defm	""
	defb	7

	defm	""
	defb	5

	defm	""
	defb	6

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
	defb	8

	defm	""
	defb	0

	defm	""
	defb	9

	defm	""
	defb	10

	defm	""
	defb	13

	defm	""
	defb	11

	defm	""
	defb	12

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
	defw _ss_main + 0x00c0
	defw _ss_main + 0x0180
	defw _ss_main + 0x0240
	defw _ss_main + 0x0300
	defw _ss_main + 0x03c0
	defw _ss_main + 0x0480
	defw _ss_main + 0x0540
	defw _ss_main + 0x0600
	defw _ss_enems + 0x0000
	defw _ss_enems + 0x00c0
	defw _ss_enems + 0x0180
	defw _ss_enems + 0x0240
	defw _ss_enems + 0x0300
	defw _ss_enems + 0x03c0
	defw _ss_extra + 0x0000
	defw _ss_extra + 0x00c0
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



._pad_read
	ld	a,(_pad0)
	ld	(_pad_this_frame),a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_11
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_11
	pop	bc
	ld	a,l
	ld	(_pad0),a
	ld	de,(_pad_this_frame)
	ld	d,0
	ld	hl,(_pad0)
	ld	h,d
	call	l_xor
	ex	de,hl
	ld	hl,(_pad0)
	ld	h,0
	call	l_and
	ld	h,0
	ld	a,l
	ld	(_pad_this_frame),a
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
	call	sp_GetKey
	ld	a,h
	or	l
	jp	nz,i_12
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_13
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_13
	pop	bc
	ld	de,128	;const
	call	l_and
	ld	de,0	;const
	call	l_eq
	jp	c,i_12
	ld	hl,0	;const
	jr	i_14
.i_12
	ld	hl,1	;const
.i_14
	ret



._wait_button
.i_15
	call	_button_pressed
	ld	a,h
	or	l
	jp	nz,i_15
.i_16
.i_17
	call	_button_pressed
	ld	a,h
	or	l
	jp	z,i_17
.i_18
	ret



._delay
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_isrc),a
.i_19
	ld	de,(_isrc)
	ld	d,0
	ld	hl,4-2	;const
	add	hl,sp
	ld	l,(hl)
	ld	h,0
	call	l_ult
	jp	c,i_19
.i_20
	ret



._librarian_get_resource
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	and	a
	jp	z,i_21
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
.i_21
	ret



._my_malloc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_BlockAlloc
	pop	bc
	ret


;	SECTION	text

._u_malloc
	defw	_my_malloc

;	SECTION	code

;	SECTION	text

._u_free
	defw	sp_FreeBlock

;	SECTION	code

	defw 0

._ISR
	ld	hl,_isrc
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	ret



._system_init
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_Initialize
	pop	bc
	pop	bc
	ld	hl,0 % 256	;const
	push	hl
	call	sp_Border
	pop	bc
	di
	ld	hl,61937	;const
	push	hl
	call	sp_InitIM2
	pop	bc
	ld	hl,61937	;const
	push	hl
	call	sp_CreateGenericISR
	pop	bc
	ld	hl,255 % 256	;const
	push	hl
	ld	hl,_ISR
	push	hl
	call	sp_RegisterHook
	pop	bc
	pop	bc
	ei
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,62 % 256	;const
	push	hl
	ld	hl,14	;const
	push	hl
	ld	hl,_dynamic_memory_pool
	push	hl
	call	sp_AddMemory
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_ts
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_26
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(_gp_gen)
	push	hl
	call	sp_TileArray
	pop	bc
	pop	bc
	ld	hl,(_gp_gen)
	ld	bc,8
	add	hl,bc
	ld	(_gp_gen),hl
.i_24
	ld	hl,(_gpit)
	ld	a,l
	and	a
	jp	nz,i_26
.i_25
	ld	hl,_spritesClipValues
	ld	(_spritesClip),hl
	ld	a,#(0 % 256 % 256)
	ld	(_rda),a
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_27
	ld	a,(_gpit)
	and	a
	jp	z,i_28
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,4 % 256	;const
	push	hl
	ld	hl,_ss_main
	push	hl
	ld	hl,(_rda)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_ss_main+64
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_ss_main+128
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	de,_sp_sw_cox
	ld	hl,(_rda)
	ld	h,0
	add	hl,de
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	de,_sp_sw_coy
	ld	hl,(_rda)
	ld	h,0
	add	hl,de
	push	hl
	pop	de
	ld	a,#(65528 % 256)
	ld	(de),a
	ld	hl,(_rda)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_rda),a
	jp	i_27
.i_28
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_29
	ld	a,(_gpit)
	and	a
	jp	z,i_30
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	ld	hl,_ss_main
	push	hl
	ld	hl,(_rda)
	ld	h,0
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_CreateSpr
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	call	l_pint_pop
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_ss_main+48
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_rda)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_ss_main+96
	push	hl
	ld	hl,128 % 256	;const
	push	hl
	call	sp_AddColSpr
	pop	bc
	pop	bc
	pop	bc
	ld	de,_sp_sw_cox
	ld	hl,(_rda)
	ld	h,0
	add	hl,de
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	de,_sp_sw_coy
	ld	hl,(_rda)
	ld	h,0
	add	hl,de
	push	hl
	pop	de
	xor	a
	ld	(de),a
	ld	hl,(_rda)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_rda),a
	jp	i_29
.i_30
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_31
	ld	a,(_gpit)
	and	a
	jp	z,i_32
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	ld	a,l
	ld	(_gpit),a
	ld	hl,_spr_cur
	push	hl
	ld	hl,(_gpit)
	ld	h,0
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
	push	hl
	ld	hl,_ss_main
	call	l_pint_pop
	call	l_pint_pop
	jp	i_31
.i_32
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



._controls_setup
	ld	hl,(_gpit)
	ld	h,0
.i_36
	ld	a,l
	cp	#(1% 256)
	jp	z,i_37
	cp	#(2% 256)
	jp	z,i_38
	cp	#(3% 256)
	jp	z,i_41
	cp	#(4% 256)
	jp	z,i_42
	jp	i_35
.i_37
.i_38
	ld	hl,sp_JoyKeyboard
	ld	(_joyfunc),hl
	ld	a,(_gpit)
	cp	#(2 % 256)
	jp	nz,i_39
	ld	hl,6	;const
	jp	i_40
.i_39
	ld	hl,0	;const
.i_40
	ld	a,l
	ld	(_gpjt),a
	ld	hl,_keys+8
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	ld	hl,_keys+6
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	ld	hl,_keys+4
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	ld	hl,_keys+1+1
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	ld	hl,_keyscancodes
	push	hl
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	ld	(_key_jump),hl
	ld	hl,_keys
	push	hl
	ld	hl,_keyscancodes
	push	hl
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	call	l_pint_pop
	jp	i_35
.i_41
	ld	hl,sp_JoyKempston
	ld	(_joyfunc),hl
	jp	i_35
.i_42
	ld	hl,sp_JoySinclair1
	ld	(_joyfunc),hl
.i_35
	ret



._p_s
	ld	a,(__x)
	ld	(_rdxx),a
	ld	hl,(__y)
	ld	h,0
	ld	a,l
	ld	(_rdyy),a
.i_43
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a,(hl)
	and	a
	jp	z,i_44
	pop	de
	pop	hl
	inc	hl
	push	hl
	push	de
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdch),a
	cp	#(47 % 256)
	jp	nz,i_45
	ld	a,(__x)
	ld	(_rdxx),a
	ld	hl,_rdyy
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_46
.i_45
	ld	hl,(_rdyy)
	ld	h,0
	push	hl
	ld	hl,_rdxx
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(_rdc)
	ld	h,0
	push	hl
	ld	hl,(_rdch)
	ld	h,0
	ld	bc,-32
	add	hl,bc
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_46
	jp	i_43
.i_44
	ret



._draw_tile
	ld	hl,_tsmaps
	push	hl
	ld	a,(__t)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asl
	pop	de
	add	hl,de
	ld	(_gp_aux),hl
	ld	a,(__y)
	cp	#(23 % 256)
	jp	nz,i_47
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_48
.i_47
	ld	a,(__y)
	cp	#(1 % 256)
	jp	nz,i_49
	ld	hl,(_gp_aux)
	ld	bc,4
	add	hl,bc
	ld	(_gp_aux),hl
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	jp	i_50
.i_49
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(__x)
	ld	h,0
	inc	hl
	push	hl
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	hl,(_gp_aux)
	ld	l,(hl)
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
.i_50
.i_48
	ret



._all_sprites_out
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_51
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	e,a
	ld	d,0
	ld	hl,(_rda)
	ld	h,d
	call	l_ugt
	jp	nc,i_52
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,(_spritesClip)
	push	hl
	ld	hl,0	;const
	push	hl
	ld	hl,65534 % 256	;const
	push	hl
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_MoveSprAbs
	exx
	ld	hl,14	;const
	add	hl,sp
	ld	sp,hl
	exx
	jp	i_51
.i_52
	ret


	._unrle_x defb 0
	._unrle_y defb 0
	._unrle_c defb 0

._unrle_adv
	ld	hl,(_gpint)
	dec	hl
	ld	(_gpint),hl
	ld	de,767	;const
	ex	de,hl
	call	l_ugt
	jp	nc,i_53
	LIB SPCompDListAddr
	ld a, (__x)
	ld c, a
	ld a, (_rdb)
	ld d, a
	ld a, (__y)
	push de
	call SPCompDListAddr
	pop de
	inc hl
	ld (hl), d
	jp	i_54
.i_53
	ld	hl,(_gpint)
	ld	de,767	;const
	call	l_eq
	jp	nc,i_55
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__y),a
	ld	(__x),a
.i_55
	LIB SPCompDListAddr
	ld a, (__x)
	ld c, a
	ld a, (_rdb)
	ld d, a
	ld a, (__y)
	push de
	call SPCompDListAddr
	pop de
	ld (hl), d
.i_54
	ld	hl,__x
	ld	a,(hl)
	inc	(hl)
	ld	a,(__x)
	cp	#(32 % 256)
	jp	nz,i_56
	ld	a,#(0 % 256 % 256)
	ld	(__x),a
	ld	hl,__y
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
.i_56
	ret



._unrle
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	l,(hl)
	ld	h,0
	ld	a,l
	ld	(_rdc),a
	ld	a,#(0 % 256 % 256)
	ld	(__x),a
	ld	a,#(0 % 256 % 256)
	ld	(__y),a
	ld	a,#(0 % 256 % 256)
	ld	(_rdb),a
	ld	hl,1536	;const
	ld	(_gpint),hl
.i_57
	ld	hl,(_gpint)
	ld	a,h
	or	l
	jp	z,i_58
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
	jp	nc,i_59
	ld	hl,(_gp_aux)
	inc	hl
	ld	(_gp_aux),hl
	dec	hl
	ld	a,(hl)
	ld	(_rda),a
	ld	l,a
	and	a
	jp	z,i_58
.i_60
.i_61
	ld	hl,_rda
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_62
	call	_unrle_adv
	jp	i_61
.i_62
	jp	i_63
.i_59
	ld	hl,(_rda)
	ld	h,0
	ld	a,l
	ld	(_rdb),a
	call	_unrle_adv
.i_63
	jp	i_57
.i_58
	ld	hl,_fsRect
	push	hl
	push	hl
	call	sp_Invalidate
	pop	bc
	pop	bc
	ret



._p_t2
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,__x
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	push	hl
	ld	hl,(__t)
	ld	h,0
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,(__y)
	ld	h,0
	push	hl
	ld	hl,(__x)
	ld	h,0
	push	hl
	ld	hl,(__t)
	ld	h,0
	push	hl
	ld	a,(__n)
	ld	e,a
	ld	d,0
	ld	hl,10	;const
	call	l_div_u
	ex	de,hl
	ld	de,16
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
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
	call	_draw_tile
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
	jp	nz,i_65
	ld	a,(__t)
	cp	#(11 % 256)
	jp	nz,i_65
	ld	a,(_flip_flop)
	and	a
	jr	nz,i_66_i_65
.i_65
	jp	i_64
.i_66_i_65
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__t),a
.i_64
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
	jp	i_69
.i_67
	ld	hl,(__y)
	ld	h,0
	inc	hl
	inc	hl
	ld	h,0
	ld	a,l
	ld	(__y),a
.i_69
	ld	a,(__y)
	cp	#(25 % 256)
	jp	z,i_68
	jp	nc,i_68
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(__x),a
.i_70
.i_72
	ld	a,(__x)
	cp	#(32 % 256)
	jp	z,i_71
	jp	nc,i_71
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
	jp	z,i_73
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
	jp	i_74
.i_73
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
.i_74
	jp	i_70
.i_71
	ld	hl,(_gpit)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_gpit),a
	jp	i_67
.i_68
	ret



._draw_scr_buffer
	call	_scr_rand
	ld	a,#(0 % 256 % 256)
	ld	(_gpit),a
	ld	a,#(0 % 256 % 256)
	ld	(__x),a
	ld	a,#(1 % 256 % 256)
	ld	(__y),a
	ld	hl,_scr_buff
	ld	(_gp_map),hl
.i_75
	ld	a,(_gpit)
	cp	#(160 % 256)
	jp	z,i_76
	jp	nc,i_76
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
	jp	i_75
.i_76
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
	call	_draw_tile
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
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
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
.i_77
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_78
	ld	de,_lkact
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_77
.i_78
	ret



._bolts_clear_bolt
	ld	hl,_locks
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpit),a
	jp	i_81
.i_79
	ld	hl,_gpit
	ld	a,(hl)
	inc	(hl)
.i_81
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_80
	jp	nc,i_80
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
	jp	nc,i_83
	ld	de,(_rdc)
	ld	d,0
	ld	hl,(_rdb)
	ld	h,d
	call	l_eq
	jr	c,i_84_i_83
.i_83
	jp	i_82
.i_84_i_83
	ld	de,_lkact
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(1 % 256 % 256)
	ld	hl,3 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_82
	jp	i_79
.i_80
	ret



._bolts_update_screen
	ld	hl,_locks
	ld	(_gp_gen),hl
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_gpjt),a
	jp	i_87
.i_85
	ld	hl,_gpjt
	ld	a,(hl)
	inc	(hl)
.i_87
	ld	a,(_gpjt)
	cp	#(4 % 256)
	jp	z,i_86
	jp	nc,i_86
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
	jp	nc,i_89
	ld	de,_lkact
	ld	hl,(_gpjt)
	ld	h,0
	add	hl,de
	ld	a,(hl)
	and	a
	jr	nz,i_90_i_89
.i_89
	jp	i_88
.i_90_i_89
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
.i_88
	jp	i_85
.i_86
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
.i_91
	ld	a,(_gpit)
	and	a
	jp	z,i_92
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
	jp	i_91
.i_92
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
	add 9
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
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	ld	(hl),#(2 % 256 % 256)
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	ld	(hl),#(0 % 256 % 256)
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	ld	(hl),#(22 % 256 % 256)
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl),#(32 % 256 % 256)
	ld	l,(hl)
	ld	h,0
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
	ld a, (__en_x1)
	ld c, a
	ld a, (__en_x2)
	cp c
	jp nc, _enems_load_t_10_not_swap_xX
	ld (__en_x1), a
	ld a, c
	ld (__en_x2), a
	._enems_load_t_10_not_swap_xX
	push bc
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	push	hl
	ld	a,(__en_y1)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	dec	hl
	dec	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	push	hl
	ld	a,(__en_x1)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	push	hl
	ld	de,(__en_y2)
	ld	d,0
	ld	hl,(__en_y1)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	ex	de,hl
	ld	l,#(3 % 256)
	call	l_asr_u
	inc	hl
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	inc	hl
	inc	hl
	inc	hl
	push	hl
	ld	de,(__en_x2)
	ld	d,0
	ld	hl,(__en_x1)
	ld	h,d
	ex	de,hl
	and	a
	sbc	hl,de
	ex	de,hl
	ld	l,#(3 % 256)
	call	l_asr_u
	inc	hl
	inc	hl
	pop	de
	ld	a,l
	ld	(de),a
	pop bc
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
	ld	hl,6 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
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
	ld a, 16
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
	ld a, 15
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
	ld a, (_pad)
	and 0x80
	jr z, __e_d_jumps_on_enemies_do
	ld a, (_pad)
	and 0x01
	jr nz, __e_d_jumps_on_enemies_done
	.__e_d_jumps_on_enemies_do
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
	jp	z,i_93
	ld	hl,___y
	ld	a,(hl)
	dec	(hl)
.i_93
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
	jp	nz,i_95
.i_94
	ld	a,(_pkeys)
	and	a
	jp	z,i_96
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
	ld	hl,4 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_96
.i_95
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
	call	sp_UpdateNow
	ld	a,#(2 % 256 % 256)
	ld	(_queued_sound),a
	ld	a,(_evil_tile_hit)
	and	a
	jp	z,i_97
	ld	a,#(255 % 256 % 256)
	ld	(_pad0),a
	ld	hl,60 % 256	;const
	push	hl
	call	_delay
	pop	bc
	call	_player_reset_movement
	call	_player_restore_safe_spot
.i_97
	ld	a,#(25 % 256 % 256)
	ld	(_pflickering),a
	ld	a,(_plife)
	and	a
	jp	z,i_98
	ld	hl,_plife
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
	jp	i_99
.i_98
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pkilled),a
.i_99
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
	ld	hl,(_pad0)
	ld	h,0
	ld	a,l
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
	jp	nc,i_100
	ld	hl,(_pj)
	ld	h,0
	call	l_lneg
	jp	nc,i_101
	ld	hl,_pvy
	call	l_gchar
	ld	de,103	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_102
	ld	hl,127	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	jp	i_103
.i_102
	ld	hl,_pvy
	call	l_gchar
	ld	bc,24
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_103
	jp	i_104
.i_101
	ld	hl,_pvy
	call	l_gchar
	ld	de,123	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_105
	ld	hl,127	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
	jp	i_106
.i_105
	ld	hl,_pvy
	call	l_gchar
	ld	bc,4
	add	hl,bc
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_106
.i_104
.i_100
	ld de, (_py)
	ld hl, _pvy
	call l_gchar
	add hl, de
	ld (_py), hl
	ld de, 224
	ex de, hl
	call l_lt
	jr nc, _pm_vert_move_topb_done
	ld de, 224
	ld (_py), de
	jp _pm_vert_move_botb_done
	._pm_vert_move_topb_done
	ld hl, 3072
	call l_gt
	jr nc, _pm_vert_move_botb_done
	ld de, 3072
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
	jp	nz,i_107
	ld	hl,_at2
	ld	a,(hl)
	and	#(12 % 256)
	jp	z,i_109
.i_107
	ld	hl,_pvy
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_ge
	jp	nc,i_109
	ld	hl,_pry
	ld	a,(hl)
	and	#(15 % 256)
	cp	#(0 % 256)
	ld	hl,0
	jp	nz,i_109
	ld	hl,1	;const
	jr	i_110
.i_109
	ld	hl,0	;const
.i_110
	ld	h,0
	ld	a,l
	ld	(_ppossee),a
	and	a
	jp	nz,i_112
	ld	a,(_pgotten)
	and	a
	jp	z,i_111
.i_112
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pjustjumped),a
.i_111
	ld	a,(_springs_on)
	and	a
	jp	z,i_114
	ld	a,#(13 % 256 % 256)
	ld	(__t),a
	ld	a,#(255 % 256 % 256)
	ld	(__x),a
	ld	a,(_t1)
	cp	#(23 % 256)
	jp	nz,i_115
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
.i_115
	ld	a,(_t2)
	cp	#(23 % 256)
	jp	nz,i_116
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
.i_116
	ld	a,(__x)
	cp	#(255 % 256)
	jp	z,i_117
	ld	hl,6 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_117
.i_114
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,128	;const
	call	l_and
	ld	de,0	;const
	call	l_eq
	jp	c,i_119
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,1	;const
	call	l_and
	ld	de,0	;const
	call	l_eq
	jp	nc,i_118
.i_119
	ld	hl,(_pjb)
	ld	h,0
	call	l_lneg
	jp	nc,i_121
	ld	a,#(1 % 256 % 256)
	ld	(_pjb),a
	ld	hl,(_pj)
	ld	h,0
	call	l_lneg
	jp	nc,i_122
	ld	a,(_pgotten)
	and	a
	jp	nz,i_124
	ld	a,(_ppossee)
	and	a
	jp	nz,i_124
	ld	a,(_phit)
	and	a
	jp	z,i_123
.i_124
	ld	a,#(0 % 256 % 256)
	ld	(_pctj),a
	ld	a,#(1 % 256 % 256)
	ld	(_pj),a
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pjustjumped),a
	ld	a,#(65409 % 256)
	ld	(_pvy),a
	ld	a,#(0 % 256 % 256)
	ld	(_queued_sound),a
	ld	hl,(_ppossee)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_register_safe_spot
.i_126
.i_123
.i_122
.i_121
	ld	a,(_pj)
	and	a
	jp	z,i_127
	ld	hl,_pctj
	ld	a,(hl)
	inc	(hl)
	ld	a,(_pctj)
	cp	#(6 % 256)
	jp	nz,i_128
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pj),a
.i_128
.i_127
	jp	i_129
.i_118
	ld	a,#(0 % 256 % 256)
	ld	(_pjb),a
	ld	a,(_pj)
	and	a
	jp	z,i_130
	ld	hl,_pvy
	call	l_gchar
	ld	de,65472	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_131
	ld	hl,65472	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_131
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pj),a
.i_130
.i_129
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,4	;const
	call	l_and
	ld	a,h
	or	l
	jp	nz,i_132
	ld a, (_pfixct)
	or a
	jp nz, _pm_poll_pad_horz_left_skip
	ld a, (_pvx)
	sub 16
	ld (_pvx), a
	._pm_poll_pad_horz_left_pvx_set
	ld hl, _pvx
	call l_gchar
	ld de, -64
	ex de, hl
	call l_lt
	jp nc, _pm_poll_pad_horz_left_pvx_limi
	ld a, -64
	ld (_pvx), a
	._pm_poll_pad_horz_left_pvx_limi
	._pm_poll_pad_horz_left_skip
	ld a, 4
	ld (_pfacing), a
	jp	i_133
.i_132
	ld	a,(_pad)
	ld	e,a
	ld	d,0
	ld	hl,8	;const
	call	l_and
	ld	a,h
	or	l
	jp	nz,i_134
	ld a, (_pfixct)
	or a
	jp nz, _pm_poll_pad_horz_right_skip
	ld a, (_pvx)
	add 16
	ld (_pvx), a
	._pm_poll_pad_horz_right_pvx_set
	ld hl, _pvx
	call l_gchar
	ld de, 64
	ex de, hl
	call l_gt
	jp nc, _pm_poll_pad_horz_right_pvx_lim
	ld a, 64
	ld (_pvx), a
	._pm_poll_pad_horz_right_pvx_lim
	._pm_poll_pad_horz_right_skip
	ld a, 0
	ld (_pfacing), a
	jp	i_135
.i_134
	ld a, (_pvx)
	or a
	jr z, _pm_poll_pad_horz_none_skip
	cp 128
	jp c, _pm_poll_pad_horz_none_positive
	._pm_poll_pad_horz_none_negative
	ld a, (_pvx)
	add 32
	jp m, _pm_poll_pad_horz_none_done
	xor a
	jp _pm_poll_pad_horz_none_done
	._pm_poll_pad_horz_none_positive
	ld a, (_pvx)
	sub 32
	jp p, _pm_poll_pad_horz_none_done
	xor a
	._pm_poll_pad_horz_none_done
	ld (_pvx), a
	._pm_poll_pad_horz_none_skip
.i_135
.i_133
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
	jp	z,i_136
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
	ld	a,#(1 % 256 % 256)
	ld	(_queued_sound),a
	ld	hl,_ptile_get_ctr
	ld	a,(hl)
	inc	(hl)
	ld	a,(_ptile_get_ctr)
	cp	#(25 % 256)
	jp	nz,i_137
	ld	a,#(0 % 256 % 256)
	ld	(_ptile_get_ctr),a
	ld	hl,_plife
	ld	a,(hl)
	inc	(hl)
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_137
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
.i_136
	ld	a,(_evil_tile_hit)
	and	a
	jp	z,i_138
	ld	a,#(0 % 256 % 256)
	ld	(_pjustjumped),a
	ld	hl,(_pflickering)
	ld	h,0
	call	l_lneg
	jp	nc,i_139
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pwashit),a
	jp	i_140
.i_139
	ld	hl,(_pcx)
	ld	(_px),hl
	ld	hl,(_pcy)
	ld	(_py),hl
	ld	hl,65409	;const
	ld	a,l
	call	l_sxt
	ld	a,l
	ld	(_pvy),a
.i_140
.i_138
	ld	hl,(_key_jump)
	push	hl
	call	sp_KeyPressed
	pop	bc
	ld	a,h
	or	l
	jp	z,i_141
	ld	hl,1 % 256	;const
	ld	a,l
	ld	(_pfiring),a
	jp	i_142
.i_141
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pfiring),a
.i_142
	ld	hl,(_ppossee)
	ld	h,0
	call	l_lneg
	jp	nc,i_144
	ld	hl,(_pgotten)
	ld	h,0
	call	l_lneg
	jr	c,i_145_i_144
.i_144
	jp	i_143
.i_145_i_144
	ld	hl,(_pfacing)
	ld	h,0
	ld	de,4
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_psprid),a
	jp	i_146
.i_143
	ld	hl,_pvx
	call	l_gchar
	ld	de,0	;const
	ex	de,hl
	call	l_lt
	jp	nc,i_148
	ld	hl,_pvx
	call	l_gchar
	call	l_neg
	jp	i_149
.i_148
	ld	hl,_pvx
	call	l_gchar
.i_149
	ld	de,16	;const
	ex	de,hl
	call	l_gt
	jp	nc,i_147
	ld	hl,(_pstep)
	ld	h,0
	inc	hl
	ld	de,7	;const
	call	l_and
	ld	h,0
	ld	a,l
	ld	(_pstep),a
	and	a
	jp	nz,i_150
	ld	hl,(_pframe)
	ld	h,0
	inc	hl
	ld	a,l
	ld	(_pframe),a
	cp	#(3 % 256)
	jp	nz,i_151
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_pframe),a
.i_151
.i_150
	ld	hl,(_pframe)
	ld	h,0
	ld	de,1
	add	hl,de
	ex	de,hl
	ld	hl,(_pfacing)
	ld	h,0
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_psprid),a
	jp	i_152
.i_147
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_psprid),a
.i_152
.i_146
	ld	hl,_spr_on
	push	hl
	ld	a,(_pflickering)
	cp	#(0 % 256)
	jp	z,i_153
	ld	a,(_half_life)
	and	a
	jp	nz,i_153
	ld	hl,0	;const
	jr	i_154
.i_153
	ld	hl,1	;const
.i_154
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
	jp	z,i_155
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
	sub 8
	cp 16
	jr nc, _add_pumpkin_set_y
	ld a, 16
	._add_pumpkin_set_y
	ld (_spr_y + 4), a
	ld	hl,_spr_next+8
	push	hl
	ld	hl,_ss_pumpkin
	call	l_pint_pop
	jp	i_156
.i_155
	ld	hl,_spr_on+4
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
.i_156
	ret



._hud_update
	ld a, 71
	ld (__t), a
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
.i_157
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	and	a
	jp	z,i_158
	ld	de,_spr_on
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	(hl),#(0 % 256 % 256)
	ld	l,(hl)
	ld	h,0
	jp	i_157
.i_158
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
	jp	z,i_159
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_first_time),a
.i_159
.i_160
	call	_enems_load
	call	_enems_do
	ret



._game_loop
	call	_hud_update
	ld	hl,_flags+1+1
	ld	(hl),#(0 % 256 % 256)
	ld	a,#(1 % 256 % 256)
	ld	(_do_game),a
	ld	a,#(0 % 256 % 256)
	ld	(_pkilled),a
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_161
	ld	hl,(_do_game)
	ld	a,l
	and	a
	jp	z,i_162
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
	cp 14
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
	ld hl, 3072
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
	cp 192
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
	ld hl, 224
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
	cp 25
	jr nz, _mltrs
	xor a
	._mltrs
	ld (_ticker), a
	ld	hl,(_joyfunc)
	push	hl
	ld	hl,_keys
	pop	de
	ld	bc,i_163
	push	hl
	push	bc
	push	de
	ld	a,1
	ret
.i_163
	pop	bc
	ld	a,l
	ld	(_pad0),a
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
	.main_loop_isrc_wait
	ld a, (_isrc)
	cp 2
	jr c, main_loop_isrc_wait
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
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
	._main_loop_custom_end
	ld	a,(_do_game)
	cp	#(0 % 256)
	jp	nz,i_165
	ld	de,(_n_pant)
	ld	d,0
	ld	hl,(_on_pant)
	ld	h,d
	call	l_ne
	jr	c,i_166_i_165
.i_165
	jp	i_164
.i_166_i_165
	jp	i_161
.i_164
.i_167
	ld	hl,5 % 256	;const
	ld	a,l
	ld	(_gpit),a
.i_168
	ld	a,(_gpit)
	and	a
	jp	z,i_169
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
	jp	z,i_170
	ld	de,_spr_x
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_sp_sw_cox
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	add	hl,de
	ld	h,0
	ld	a,l
	ld	(_rdx),a
	ld	de,_spr_y
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	ld	l,(hl)
	ld	h,0
	push	hl
	ld	de,_sp_sw_coy
	ld	hl,(_gpit)
	ld	h,0
	add	hl,de
	call	l_gchar
	pop	de
	add	hl,de
	ld	bc,-16
	add	hl,bc
	ld	a,l
	ld	(_rdy),a
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	a,(_gpit)
	and	a
	jp	z,i_171
	ld	a,(_gpit)
	cp	#(4 % 256)
	jp	z,i_171
	jp	nc,i_171
	ld	hl,1	;const
	jr	i_172
.i_171
	ld	hl,0	;const
.i_172
	jp	nc,i_173
	ld	hl,_ensClipRects
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	dec	hl
	add	hl,hl
	add	hl,hl
	pop	de
	add	hl,de
	jp	i_174
.i_173
	ld	hl,(_spritesClip)
.i_174
	push	hl
	ld	hl,_spr_next
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,_spr_cur
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	call	l_gint	;
	pop	de
	ex	de,hl
	and	a
	sbc	hl,de
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,1
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	l,#(3 % 256)
	call	l_asr_u
	ld	de,0
	add	hl,de
	ld	h,0
	push	hl
	ld	a,(_rdx)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	ld	a,(_rdy)
	ld	e,a
	ld	d,0
	ld	hl,7	;const
	call	l_and
	push	hl
	call	sp_MoveSprAbs
	ld	hl,14	;const
	add	hl,sp
	ld	sp,hl
	ld	hl,_spr_cur
	push	hl
	ld	hl,(_gpit)
	ld	h,0
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
	jp	i_175
.i_170
	ld	hl,_sp_sw
	push	hl
	ld	hl,(_gpit)
	ld	h,0
	add	hl,hl
	pop	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	push	de
	ld	hl,(_spritesClip)
	push	hl
	ld	hl,0	;const
	push	hl
	ld	hl,65534 % 256	;const
	push	hl
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	call	sp_MoveSprAbs
	exx
	ld	hl,14	;const
	add	hl,sp
	ld	sp,hl
	exx
.i_175
	jp	i_168
.i_169
	call	sp_UpdateNow
	ld	a,(_queued_sound)
	cp	#(255 % 256)
	jp	z,i_176
	ld	hl,(_queued_sound)
	ld	h,0
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,255 % 256	;const
	ld	a,l
	ld	(_queued_sound),a
.i_176
	ld	hl,(_pwashit)
	ld	h,0
	ld	a,h
	or	l
	call	nz,_player_hit
.i_177
	ld	a,(_pkilled)
	and	a
	jp	z,i_178
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_do_game),a
.i_178
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
	jp	nc,i_180
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
	jr	c,i_181_i_180
.i_180
	jp	i_179
.i_181_i_180
	ld	hl,0 % 256	;const
	ld	a,l
	ld	(_do_game),a
.i_179
	jp	i_161
.i_162
	call	_all_sprites_out
	ret



._game_title
	ld	hl,_title_rle
	ld	(_gp_aux),hl
	call	_unrle
	ld	a,#(71 % 256 % 256)
	ld	(_rdc),a
	ld	a,#(10 % 256 % 256)
	ld	(__x),a
	ld	a,#(13 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+0
	push	hl
	call	_p_s
	pop	bc
	call	sp_UpdateNow
	call play_music
.i_182
	call	sp_GetKey
	ld	bc,-48
	add	hl,bc
	ld	h,0
	ld	a,l
	ld	(_gpit),a
	cp	#(1 % 256)
	jr	z,i_185_uge
	jp	c,i_185
.i_185_uge
	ld	a,(_gpit)
	cp	#(4 % 256)
	jr	z,i_186_i_185
	jr	c,i_183
.i_185
.i_184
	jp	i_182
.i_186_i_185
.i_183
	ld	a,(_gpit)
	cp	#(2 % 256)
	jp	z,i_187
	jp	c,i_187
	ld	hl,_gpit
	ld	a,(hl)
	dec	(hl)
	ld	l,a
	ld	h,0
.i_187
	call	_controls_setup
	ret



._game_over
	ld	hl,_fsRect
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	call	sp_ClearRect
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_fsRect
	push	hl
	push	hl
	call	sp_Invalidate
	pop	bc
	pop	bc
	ld	a,#(71 % 256 % 256)
	ld	(_rdc),a
	ld	a,#(11 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+61
	push	hl
	call	_p_s
	pop	bc
	call	sp_UpdateNow
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	call	_wait_button
	ret



._game_level
	ld	hl,_fsRect
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	call	sp_ClearRect
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_fsRect
	push	hl
	push	hl
	call	sp_Invalidate
	pop	bc
	pop	bc
	ld	a,#(71 % 256 % 256)
	ld	(_rdc),a
	ld	a,#(12 % 256 % 256)
	ld	(__x),a
	ld	a,#(12 % 256 % 256)
	ld	(__y),a
	ld	hl,i_1+72
	push	hl
	call	_p_s
	pop	bc
	ld	hl,12 % 256	;const
	push	hl
	ld	hl,19 % 256	;const
	push	hl
	ld	hl,71 % 256	;const
	push	hl
	ld	hl,(_level)
	ld	h,0
	ld	de,17
	add	hl,de
	ld	h,0
	push	hl
	call	sp_PrintAtInv
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	call	sp_UpdateNow
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	call	_wait_button
	ret



._game_ending
	ld	hl,_ending_rle
	ld	(_gp_aux),hl
	call	_unrle
	call	sp_UpdateNow
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	ld	hl,5 % 256	;const
	push	hl
	call	_beep_fx
	pop	bc
	call	_wait_button
	ld	hl,_fsRect
	push	hl
	ld	hl,0 % 256	;const
	push	hl
	push	hl
	ld	hl,3 % 256	;const
	push	hl
	call	sp_ClearRect
	pop	bc
	pop	bc
	pop	bc
	pop	bc
	ld	hl,_fsRect
	push	hl
	push	hl
	call	sp_Invalidate
	pop	bc
	pop	bc
	call	sp_UpdateNow
	ret



._main
	call	_system_init
.i_188
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
.i_190
	call	_game_level
	call	_level_setup
	call	_game_init
	call	_game_loop
	ld	hl,(_pkilled)
	ld	a,l
	and	a
	jp	z,i_192
	call	_game_over
	jp	i_191
.i_192
	ld	a,(_level)
	cp	#(2 % 256)
	jp	z,i_194
	jp	nc,i_194
	ld	hl,_level
	ld	a,(hl)
	inc	(hl)
	ld	l,a
	ld	h,0
	jp	i_195
.i_194
	call	_game_ending
	jp	i_191
.i_195
.i_193
	jp	i_190
.i_191
	jp	i_188
.i_189
	ret


	; *****************************************************************************
	; * Phaser1 Engine, with synthesised drums
	; *
	; * Original code by Shiru - http:
	; * Modified by Chris Cowley
	; *
	; * Produced by Beepola v1.05.01
	; ******************************************************************************
	.play_music
	LD HL,MUSICDATA ; <- Pointer to Music Data. Change
	; this to play a different song
	LD A,(HL) ; Get the loop start pointer
	LD (PATTERN_LOOP_BEGIN),A
	INC HL
	LD A,(HL) ; Get the song end pointer
	LD (PATTERN_LOOP_END),A
	INC HL
	LD E,(HL)
	INC HL
	LD D,(HL)
	INC HL
	LD (INSTRUM_TBL),HL
	LD (CURRENT_INST),HL
	ADD HL,DE
	LD (PATTERN_ADDR),HL
	XOR A
	LD (PATTERN_PTR),A ; Set the pattern pointer to zero
	LD H,A
	LD L,A
	LD (NOTE_PTR),HL ; Set the note offset (within this pattern) to 0
	.PLAYER
	DI
	PUSH IY
	XOR A
	LD H,$00
	LD L,A
	LD (CNT_1A),HL
	LD (CNT_1B),HL
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD (CNT_2),HL
	LD (DIV_2),HL
	LD (OUT_1),A
	LD (OUT_2),A
	JR MAIN_LOOP
	; ********************************************************************************************************
	; * NEXT_PATTERN
	; *
	; * Select the next pattern in sequence (and handle looping if weve reached PATTERN_LOOP_END
	; * Execution falls through to PLAYNOTE to play the first note from our next pattern
	; ********************************************************************************************************
	.NEXT_PATTERN
	LD A,(PATTERN_PTR)
	INC A
	INC A
	DEFB $FE ; CP n
	.PATTERN_LOOP_END DEFB 0
	JR NZ,NO_PATTERN_LOOP
	; Handle Pattern Looping at and of song
	DEFB $3E ; LD A,n
	.PATTERN_LOOP_BEGIN DEFB 0
	.NO_PATTERN_LOOP LD (PATTERN_PTR),A
	LD HL,$0000
	LD (NOTE_PTR),HL ; Start of pattern (NOTE_PTR = 0)
	.MAIN_LOOP
	LD IYL,0 ; Set channel = 0
	.READ_LOOP
	LD HL,(PATTERN_ADDR)
	LD A,(PATTERN_PTR)
	LD E,A
	LD D,0
	ADD HL,DE
	LD E,(HL)
	INC HL
	LD D,(HL) ; Now DE = Start of Pattern data
	LD HL,(NOTE_PTR)
	INC HL ; Increment the note pointer and...
	LD (NOTE_PTR),HL ; ..store it
	DEC HL
	ADD HL,DE ; Now HL = address of note data
	LD A,(HL)
	OR A
	JR Z,NEXT_PATTERN ; select next pattern
	BIT 7,A
	JP Z,RENDER ; Play the currently defined note(S) and drum
	LD IYH,A
	AND $3F
	CP $3C
	JP NC,OTHER ; Other parameters
	ADD A,A
	LD B,0
	LD C,A
	LD HL,FREQ_TABLE
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	LD A,IYL ; IYL = 0 for channel 1, or = 1 for channel 2
	OR A
	JR NZ,SET_NOTE2
	LD (DIV_1A),DE
	EX DE,HL
	DEFB $DD,$21 ; LD IX,nn
	.CURRENT_INST
	DEFW $0000
	LD A,(IX+$00)
	OR A
	JR Z,L809B ; Original code jumps into byte 2 of the DJNZ (invalid opcode FD)
	LD B,A
	.L8098 ADD HL,HL
	DJNZ L8098
	.L809B LD E,(IX+$01)
	LD D,(IX+$02)
	ADD HL,DE
	LD (DIV_1B),HL
	LD IYL,1 ; Set channel = 1
	LD A,IYH
	AND $40
	JR Z,READ_LOOP ; No phase reset
	LD HL,OUT_1 ; Reset phaser
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_1A),HL
	LD H,(IX+$03)
	LD (CNT_1B),HL
	JR READ_LOOP
	.SET_NOTE2
	LD (DIV_2),DE
	LD A,IYH
	LD HL,OUT_2
	RES 4,(HL)
	LD HL,$0000
	LD (CNT_2),HL
	JP READ_LOOP
	.SET_STOP
	LD HL,$0000
	LD A,IYL
	OR A
	JR NZ,SET_STOP2
	; Stop channel 1 note
	LD (DIV_1A),HL
	LD (DIV_1B),HL
	LD HL,OUT_1
	RES 4,(HL)
	LD IYL,1
	JP READ_LOOP
	.SET_STOP2
	; Stop channel 2 note
	LD (DIV_2),HL
	LD HL,OUT_2
	RES 4,(HL)
	JP READ_LOOP
	.OTHER CP $3C
	JR Z,SET_STOP ; Stop note
	CP $3E
	JR Z,SKIP_CH1 ; No changes to channel 1
	INC HL ; Instrument change
	LD L,(HL)
	LD H,$00
	ADD HL,HL
	LD DE,(NOTE_PTR)
	INC DE
	LD (NOTE_PTR),DE ; Increment the note pointer
	DEFB $01 ; LD BC,nn
	.INSTRUM_TBL
	DEFW $0000
	ADD HL,BC
	LD (CURRENT_INST),HL
	JP READ_LOOP
	.SKIP_CH1
	LD IYL,$01
	JP READ_LOOP
	.EXIT_PLAYER
	LD HL,$2758
	EXX
	POP IY
	EI
	RET
	.RENDER
	AND $7F ; L813A
	CP $76
	JP NC,DRUMS
	LD D,A
	EXX
	DEFB $21 ; LD HL,nn
	.CNT_1A DEFW $0000
	DEFB $DD,$21 ; LD IX,nn
	.CNT_1B DEFW $0000
	DEFB $01 ; LD BC,nn
	.DIV_1A DEFW $0000
	DEFB $11 ; LD DE,nn
	.DIV_1B DEFW $0000
	DEFB $3E ; LD A,n
	.OUT_1 DEFB $0
	EXX
	EX AF,AF
	DEFB $21 ; LD HL,nn
	.CNT_2 DEFW $0000
	DEFB $01 ; LD BC,nn
	.DIV_2 DEFW $0000
	DEFB $3E ; LD A,n
	.OUT_2 DEFB $00
	.PLAY_NOTE
	; Read keyboard
	LD E,A
	XOR A
	IN A,($FE)
	OR $E0
	INC A
	.PLAYER_WAIT_KEY
	JR NZ,EXIT_PLAYER
	LD A,E
	LD E,0
	.L8168 EXX
	EX AF,AF
	ADD HL,BC
	OUT ($FE),A
	JR C,L8171
	JR L8173
	.L8171 XOR $10
	.L8173 ADD IX,DE
	JR C,L8179
	JR L817B
	.L8179 XOR $10
	.L817B EX AF,AF
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L8184
	JR L8186
	.L8184 XOR $10
	.L8186 NOP
	JP L818A
	.L818A EXX
	EX AF,AF
	ADD HL,BC
	OUT ($FE),A
	JR C,L8193
	JR L8195
	.L8193 XOR $10
	.L8195 ADD IX,DE
	JR C,L819B
	JR L819D
	.L819B XOR $10
	.L819D EX AF,AF
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81A6
	JR L81A8
	.L81A6 XOR $10
	.L81A8 NOP
	JP L81AC
	.L81AC EXX
	EX AF,AF
	ADD HL,BC
	OUT ($FE),A
	JR C,L81B5
	JR L81B7
	.L81B5 XOR $10
	.L81B7 ADD IX,DE
	JR C,L81BD
	JR L81BF
	.L81BD XOR $10
	.L81BF EX AF,AF
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81C8
	JR L81CA
	.L81C8 XOR $10
	.L81CA NOP
	JP L81CE
	.L81CE EXX
	EX AF,AF
	ADD HL,BC
	OUT ($FE),A
	JR C,L81D7
	JR L81D9
	.L81D7 XOR $10
	.L81D9 ADD IX,DE
	JR C,L81DF
	JR L81E1
	.L81DF XOR $10
	.L81E1 EX AF,AF
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L81EA
	JR L81EC
	.L81EA XOR $10
	.L81EC DEC E
	JP NZ,L8168
	EXX
	EX AF,AF
	ADD HL,BC
	OUT ($FE),A
	JR C,L81F9
	JR L81FB
	.L81F9 XOR $10
	.L81FB ADD IX,DE
	JR C,L8201
	JR L8203
	.L8201 XOR $10
	.L8203 EX AF,AF
	OUT ($FE),A
	EXX
	ADD HL,BC
	JR C,L820C
	JR L820E
	.L820C XOR $10
	.L820E DEC D
	JP NZ,PLAY_NOTE
	LD (CNT_2),HL
	LD (OUT_2),A
	EXX
	EX AF,AF
	LD (CNT_1A),HL
	LD (CNT_1B),IX
	LD (OUT_1),A
	JP MAIN_LOOP
	; ************************************************************
	; * DRUMS - Synthesised
	; ************************************************************
	.DRUMS
	ADD A,A ; On entry A=$75+Drum number (i.e. $76 to $7E)
	LD B,0
	LD C,A
	LD HL,DRUM_TABLE - 236
	ADD HL,BC
	LD E,(HL)
	INC HL
	LD D,(HL)
	EX DE,HL
	JP (HL)
	.DRUM_TONE1 LD L,16
	JR DRUM_TONE
	.DRUM_TONE2 LD L,12
	JR DRUM_TONE
	.DRUM_TONE3 LD L,8
	JR DRUM_TONE
	.DRUM_TONE4 LD L,6
	JR DRUM_TONE
	.DRUM_TONE5 LD L,4
	JR DRUM_TONE
	.DRUM_TONE6 LD L,2
	.DRUM_TONE
	LD DE,3700
	LD BC,$0101
	XOR A
	.DT_LOOP0 OUT ($FE),A
	DEC B
	JR NZ,DT_LOOP1
	XOR 16
	LD B,C
	EX AF,AF
	LD A,C
	ADD A,L
	LD C,A
	EX AF,AF
	.DT_LOOP1 DEC E
	JR NZ,DT_LOOP0
	DEC D
	JR NZ,DT_LOOP0
	JP MAIN_LOOP
	.DRUM_NOISE1 LD DE,2480
	LD IXL,1
	JR DRUM_NOISE
	.DRUM_NOISE2 LD DE,1070
	LD IXL,10
	JR DRUM_NOISE
	.DRUM_NOISE3 LD DE,365
	LD IXL,101
	.DRUM_NOISE
	LD H,D
	LD L,E
	XOR A
	LD C,A
	.DN_LOOP0 LD A,(HL)
	AND 16
	OR C
	OUT ($FE),A
	LD B,IXL
	.DN_LOOP1 DJNZ DN_LOOP1
	INC HL
	DEC E
	JR NZ,DN_LOOP0
	DEC D
	JR NZ,DN_LOOP0
	JP MAIN_LOOP
	.PATTERN_ADDR DEFW $0000
	.PATTERN_PTR DEFB 0
	.NOTE_PTR DEFW $0000
	; **************************************************************
	; * Frequency Table
	; **************************************************************
	.FREQ_TABLE
	DEFW 178,189,200,212,225,238,252,267,283,300,318,337
	DEFW 357,378,401,425,450,477,505,535,567,601,637,675
	DEFW 715,757,802,850,901,954,1011,1071,1135,1202,1274,1350
	DEFW 1430,1515,1605,1701,1802,1909,2023,2143,2270,2405,2548,2700
	DEFW 2860,3030,3211,3402,3604,3818,4046,4286,4541,4811,5097,5400
	; *****************************************************************
	; * Synth Drum Lookup Table
	; *****************************************************************
	.DRUM_TABLE
	DEFW DRUM_TONE1,DRUM_TONE2,DRUM_TONE3,DRUM_TONE4,DRUM_TONE5,DRUM_TONE6
	DEFW DRUM_NOISE1,DRUM_NOISE2,DRUM_NOISE3
	.MUSICDATA
	DEFB 0 ; Pattern loop begin * 2
	DEFB 24 ; Song length * 2
	DEFW 12 ; Offset to start of song (length of instrument table)
	DEFB 0 ; Multiple
	DEFW 20 ; Detune
	DEFB 1 ; Phase
	DEFB 1 ; Multiple
	DEFW 5 ; Detune
	DEFB 1 ; Phase
	DEFB 0 ; Multiple
	DEFW 10 ; Detune
	DEFB 0 ; Phase
	.PATTERNDATA DEFW PAT0
	DEFW PAT0
	DEFW PAT0
	DEFW PAT0
	DEFW PAT1
	DEFW PAT2
	DEFW PAT1
	DEFW PAT3
	DEFW PAT1
	DEFW PAT2
	DEFW PAT1
	DEFW PAT3
	DEFW PAT4
	DEFW PAT5
	DEFW PAT6
	DEFW PAT4
	DEFW PAT5
	DEFW PAT6
	DEFW PAT4
	DEFW PAT5
	DEFW PAT6
	DEFW PAT4
	DEFW PAT7
	DEFW PAT8
	; *** Pattern data - $00 marks the end of a pattern ***
	.PAT0
	DEFB $BD,2
	DEFB 156
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 3
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 144
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 144
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 3
	DEFB 156
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 188
	DEFB 188
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT1
	DEFB $BD,2
	DEFB 168
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 168
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 168
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 144
	DEFB 3
	DEFB 169
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 172
	DEFB 188
	DEFB 3
	DEFB 172
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 172
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 172
	DEFB 188
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT2
	DEFB $BD,2
	DEFB 168
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 168
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 168
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 144
	DEFB 3
	DEFB 172
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 175
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 172
	DEFB 188
	DEFB 3
	DEFB 175
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 176
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 173
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 172
	DEFB 188
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT3
	DEFB $BD,2
	DEFB 168
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 188
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 168
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 168
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB $BD,4
	DEFB 169
	DEFB 144
	DEFB 3
	DEFB 173
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 173
	DEFB 188
	DEFB 3
	DEFB 172
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 168
	DEFB 188
	DEFB 118
	DEFB 2
	DEFB 172
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 168
	DEFB 188
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT4
	DEFB $BD,4
	DEFB 156
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 190
	DEFB 156
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 156
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 168
	DEFB 151
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 163
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 145
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 145
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 157
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 145
	DEFB 126
	DEFB 2
	DEFB 156
	DEFB 156
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 166
	DEFB 142
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 154
	DEFB 126
	DEFB 2
	DEFB $00
	.PAT5
	DEFB $BD,4
	DEFB 168
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 190
	DEFB 156
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 156
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 164
	DEFB 140
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 152
	DEFB 118
	DEFB 2
	DEFB 166
	DEFB 142
	DEFB 3
	DEFB 190
	DEFB 154
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 154
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 142
	DEFB 3
	DEFB 156
	DEFB 156
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 163
	DEFB 151
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 163
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT6
	DEFB $BD,4
	DEFB 164
	DEFB 152
	DEFB 118
	DEFB 5
	DEFB 163
	DEFB 151
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 161
	DEFB 144
	DEFB 3
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 160
	DEFB 144
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB $00
	.PAT7
	DEFB $BD,4
	DEFB 168
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 3
	DEFB 190
	DEFB 156
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 156
	DEFB 156
	DEFB 3
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 169
	DEFB 140
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 152
	DEFB 118
	DEFB 2
	DEFB 172
	DEFB 142
	DEFB 3
	DEFB 190
	DEFB 154
	DEFB 118
	DEFB 2
	DEFB 175
	DEFB 154
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 142
	DEFB 3
	DEFB 178
	DEFB 156
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 144
	DEFB 118
	DEFB 2
	DEFB 181
	DEFB 151
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 163
	DEFB 122
	DEFB 2
	DEFB $00
	.PAT8
	DEFB $BD,4
	DEFB 180
	DEFB 156
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 121
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 123
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 122
	DEFB 2
	DEFB 190
	DEFB 118
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB 190
	DEFB 126
	DEFB 2
	DEFB $00
	;BeepFX player by Shiru
	;You are free to do whatever you want with this code
	.sound_play
	ld hl,sfxData ;address of sound effects data
	di
	push ix
	push iy
	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	push de
	pop ix ;put it into ix
	xor a
	ld (sfxRoutineToneBorder +1),a
	ld (sfxRoutineNoiseBorder +1),a
	ld (sfxRoutineSampleBorder+1),a
	.readData
	ld a,(ix+0) ;read block type
	ld c,(ix+1) ;read duration 1
	ld b,(ix+2)
	ld e,(ix+3) ;read duration 2
	ld d,(ix+4)
	push de
	pop iy
	dec a
	jr z,sfxRoutineTone
	dec a
	jr z,sfxRoutineNoise
	dec a
	jr z,sfxRoutineSample
	pop iy
	pop ix
	ei
	ret
	;play sample
	.sfxRoutineSample
	ex de,hl
	.sfxRS0
	ld e,8
	ld d,(hl)
	inc hl
	.sfxRS1
	ld a,(ix+5)
	.sfxRS2
	dec a
	jr nz,sfxRS2
	rl d
	sbc a,a
	and 16
	.sfxRoutineSampleBorder
	or 0
	out (254),a
	dec e
	jr nz,sfxRS1
	dec bc
	ld a,b
	or c
	jr nz,sfxRS0
	ld c,6
	.nextData
	add ix,bc ;skip to the next block
	jr readData
	;generate tone with many parameters
	.sfxRoutineTone
	ld e,(ix+5) ;freq
	ld d,(ix+6)
	ld a,(ix+9) ;duty
	ld (sfxRoutineToneDuty+1),a
	ld hl,0
	.sfxRT0
	push bc
	push iy
	pop bc
	.sfxRT1
	add hl,de
	ld a,h
	.sfxRoutineToneDuty
	cp 0
	sbc a,a
	and 16
	.sfxRoutineToneBorder
	or 0
	out (254),a
	dec bc
	ld a,b
	or c
	jr nz,sfxRT1
	ld a,(sfxRoutineToneDuty+1) ;duty change
	add a,(ix+10)
	ld (sfxRoutineToneDuty+1),a
	ld c,(ix+7) ;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRT0
	ld c,11
	jr nextData
	;generate noise with two parameters
	.sfxRoutineNoise
	ld e,(ix+5) ;pitch
	ld d,1
	ld h,d
	ld l,d
	.sfxRN0
	push bc
	push iy
	pop bc
	.sfxRN1
	ld a,(hl)
	and 16
	.sfxRoutineNoiseBorder
	or 0
	out (254),a
	dec d
	jr nz,sfxRN2
	ld d,e
	inc hl
	ld a,h
	and 31
	ld h,a
	.sfxRN2
	dec bc
	ld a,b
	or c
	jr nz,sfxRN1
	ld a,e
	add a,(ix+6) ;slide
	ld e,a
	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRN0
	ld c,7
	jr nextData
	.sfxData
	.SoundEffectsData
	defw SoundEffect0Data
	defw SoundEffect1Data
	defw SoundEffect2Data
	defw SoundEffect3Data
	defw SoundEffect4Data
	defw SoundEffect5Data
	defw SoundEffect6Data
	.SoundEffect0Data
	defb 1 ;tone
	defw 72,20,500,2,128
	defb 0
	.SoundEffect1Data
	defb 1 ;tone
	defw 10,100,2000,100,128
	defb 0
	.SoundEffect2Data
	defb 2 ;noise
	defw 3,2000,32776
	defb 0
	.SoundEffect3Data
	defb 1 ;tone
	defw 1,400,300,65511,128
	defb 2 ;noise
	defw 1,3000,5270
	defb 0
	.SoundEffect4Data
	defb 2 ;noise
	defw 1,1000,4
	defb 1 ;tone
	defw 1,1000,2000,0,128
	defb 0
	.SoundEffect5Data
	defb 1 ;tone
	defw 2,4000,400,200,64
	defb 1 ;tone
	defw 2,4000,200,200,32
	defb 0
	.SoundEffect6Data
	defb 2 ;noise
	defw 5,1000,5
	defb 0
	._asm_beepfx defb 0

._beep_fx
	ld	hl,_asm_beepfx
	push	hl
	ld	hl,4	;const
	add	hl,sp
	ld	a,(hl)
	pop	de
	ld	(de),a
	ld	l,a
	ld	h,0
	push ix
	push iy
	ld a, (_asm_beepfx)
	call sound_play
	pop ix
	pop iy
	ret


;	SECTION	text

.i_1
	defm	"1.KEYS WASDM/2.KEYS OPQA\/3.KE"
	defm	"YS QAOP\/4.KEMPSTON/5.SINCLAIR"
	defm	""
	defb	0

	defm	"GAME OVER!"
	defb	0

	defm	"LEVEL:"
	defb	0

;	SECTION	code



; --- Start of Static Variables ---

;	SECTION	bss

._optile_get_ctr	defs	1
.__en_t	defs	1
.__en_x	defs	1
.__en_y	defs	1
._spr_next	defs	10
._queued_sound	defs	1
.__en_x1	defs	1
.__en_x2	defs	1
._safe_n_pant	defs	1
.__en_y1	defs	1
.__en_y2	defs	1
._genflipflop	defs	1
.__en_ct	defs	1
._objs_taken_i	defs	1
._spritesClip	defs	2
._en_x1	defs	3
._flip_flop	defs	1
._en_y1	defs	3
._en_x2	defs	3
._en_y2	defs	3
._half_life	defs	1
._pemmeralds	defs	1
.__en_mx	defs	1
.__en_my	defs	1
._en_hl	defs	3
._en_ct	defs	3
._en_fr	defs	1
._flags	defs	4
._en_mx	defs	3
._en_facing	defs	3
._en_my	defs	3
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
._sp_sw	defs	10
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
._tile_got	defs	240
._pad0	defs	1
._hact	defs	20
._n_pant	defs	1
._en_s	defs	3
._en_t	defs	3
._en_x	defs	3
._en_y	defs	3
._hitter_x	defs	1
._hitter_y	defs	1
._c_level_map_w	defs	1
._pkilled	defs	1
._joyfunc	defs	2
._key_jump	defs	2
._gpit	defs	1
._gpjt	defs	1
._rdch	defs	1
._keys	defs	10
._rdct	defs	1
._isrc	defs	1
._pctj	defs	1
._pjustjumped	defs	1
._phit	defs	1
._sp_sw_cox	defs	5
._sp_sw_coy	defs	5
._pbodycount	defs	1
._opbodycount	defs	1
._ensClipRects	defs	12
.__d1	defs	1
.__d2	defs	1
._pinv	defs	1
._pgotten	defs	1
._encelloffset	defs	1
.__en_state	defs	1
._rdxx	defs	1
._rdyx	defs	1
._rdyy	defs	1
._dynamic_memory_pool	defs	931
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
._en_dying	defs	3
._olevel	defs	1
._safe_prx	defs	1
._safe_pry	defs	1
._pad	defs	1
._frame_counter	defs	1
._ep_killed	defs	60
._rda	defs	1
._rdb	defs	1
._rdc	defs	1
._rdd	defs	1
._rde	defs	1
._rdf	defs	1
._rdi	defs	1
._pjb	defs	1
._pcx	defs	2
._pcy	defs	2
._hrx	defs	1
._rds	defs	1
._rdt	defs	1
._hry	defs	1
._hrt	defs	1
._rdx	defs	1
._rdy	defs	1
._rdsint	defs	2
._ticker	defs	1
._oplife	defs	1
._prx	defs	1
._pry	defs	1
._pvx	defs	1
._pvy	defs	1
._en_life	defs	3
._opobjs	defs	1
._en_washit	defs	3
._tm_ctr	defs	1
._opkeys	defs	1
._max_hotspots_type_1	defs	1
._pflickering	defs	1
._opstars	defs	1
._pwashit	defs	1
._en_state	defs	3
._ppossee	defs	1
._hitter_frame	defs	1
._spr_id	defs	1
._pstars	defs	1
._use_ct	defs	1
._psprid	defs	1
._hitter_hs_x	defs	1
._hitter_hs_y	defs	1
._spr_on	defs	5
._spr_idx	defs	1
._pthrust	defs	1
._spr_cur	defs	10
._springs_on	defs	1
._hl_proc	defs	1
._ptile_get_ctr	defs	1
;	SECTION	code



; --- Start of Scope Defns ---

	LIB	sp_GetKey
	LIB	sp_BlockAlloc
	XDEF	_optile_get_ctr
	XDEF	__en_t
	XDEF	_map_base_address
	LIB	sp_ScreenStr
	XDEF	__en_x
	XDEF	__en_y
	XDEF	_hotspots
	XDEF	_draw_scr
	LIB	sp_PixelUp
	XDEF	_spr_next
	LIB	sp_JoyFuller
	XDEF	_queued_sound
	XDEF	_level1_enems_c
	LIB	sp_MouseAMXInit
	LIB	sp_MouseAMX
	XDEF	_set_map_tile
	XDEF	_unrle_c
	XDEF	_game_title
	XDEF	_player_register_safe_spot
	XDEF	_player_restore_safe_spot
	XDEF	__en_x1
	LIB	sp_SetMousePosAMX
	XDEF	__en_x2
	XDEF	_u_malloc
	LIB	sp_Validate
	LIB	sp_HashAdd
	XDEF	_safe_n_pant
	XDEF	__en_y1
	XDEF	__en_y2
	XDEF	_unrle_x
	XDEF	_unrle_y
	LIB	sp_Border
	XDEF	_genflipflop
	LIB	sp_Inkey
	XDEF	_enems_load
	XDEF	_delay
	XDEF	__en_ct
	XDEF	_objs_taken_i
	XDEF	_spritesClip
	XDEF	_ss_pumpkin
	XDEF	_en_x1
	XDEF	_flip_flop
	XDEF	_en_y1
	XDEF	_en_x2
	XDEF	_en_y2
	XDEF	__pal_set
	LIB	sp_CreateSpr
	LIB	sp_MoveSprAbs
	LIB	sp_BlockCount
	LIB	sp_AddMemory
	XDEF	_half_life
	XDEF	_pemmeralds
	XDEF	__en_mx
	XDEF	__en_my
	XDEF	_en_hl
	XDEF	_en_ct
	XDEF	_en_fr
	XDEF	_sprite_cells
	XDEF	_player_hit
	XDEF	_flags
	LIB	sp_PrintAt
	LIB	sp_Pause
	XDEF	_scr_buff
	defc	_scr_buff	=	23664
	LIB	sp_ListFirst
	LIB	sp_HeapSiftUp
	LIB	sp_ListCount
	XDEF	_en_mx
	XDEF	_en_facing
	XDEF	_en_my
	XDEF	_draw_tile
	XDEF	_bolts_load
	LIB	sp_Heapify
	XDEF	_player_reset_movement
	XREF	_END_OF_MAIN_BIN
	XDEF	_enems
	XDEF	_scr_attr
	defc	_scr_attr	=	23856
	LIB	sp_MoveSprRel
	XDEF	_library
	XDEF	_enems_drain
	XDEF	_pregotten
	XDEF	_pstatespradder
	LIB	sp_TileArray
	LIB	sp_MouseSim
	XDEF	_scr_rand
	LIB	sp_BlockFit
	LIB	sp_HeapExtract
	LIB	sp_HuffExtract
	XDEF	_pfacing
	LIB	sp_SetMousePosSim
	XDEF	_level0_locks_c
	XDEF	_lkact
	XDEF	_hud_rle
	LIB	sp_ClearRect
	XDEF	_rand8
	LIB	sp_HuffGetState
	XDEF	_gpint
	XDEF	_seed1
	XDEF	_seed2
	XDEF	_evil_tile_hit
	XDEF	_guay_ct
	LIB	sp_ListAppend
	XDEF	_keyscancodes
	XDEF	_level
	LIB	sp_ListCreate
	LIB	sp_ListConcat
	XDEF	_pad_read
	XDEF	_locks
	XDEF	_no_ct
	XDEF	_hotspots_load
	LIB	sp_JoyKempston
	LIB	sp_UpdateNow
	LIB	sp_MouseKempston
	LIB	sp_PrintString
	LIB	sp_PixelDown
	LIB	sp_MoveSprAbsC
	LIB	sp_PixelLeft
	XDEF	_t1
	XDEF	_t2
	LIB	sp_InitAlloc
	LIB	sp_DeleteSpr
	XDEF	_librarian_get_resource
	LIB	sp_JoyTimexEither
	XDEF	__n
	XDEF	_game_prepare_screen
	XDEF	__t
	XDEF	_plife
	XDEF	__x
	XDEF	__y
	XDEF	_player_init
	XDEF	_tile_got_offset
	XDEF	_level0_hotspots_c
	XDEF	_level1_hotspots_c
	LIB	sp_Invalidate
	LIB	sp_CreateGenericISR
	LIB	sp_JoyKeyboard
	XDEF	_pobjs
	XDEF	_pj
	LIB	sp_FreeBlock
	XDEF	_fsRect
	XDEF	_pkeys
	LIB	sp_PrintAtDiff
	XDEF	_px
	XDEF	_py
	XDEF	_pgtmx
	XDEF	_pgtmy
	XDEF	_ts
	XDEF	_ss
	XDEF	_all_sprites_out
	XDEF	_player_move
	XDEF	_pnude
	XDEF	_jitter_big
	XDEF	_srand
	XDEF	_sp_sw
	XDEF	_cm_two_points
	XDEF	_player_process_block
	LIB	sp_RegisterHookLast
	LIB	sp_IntLargeRect
	LIB	sp_IntPtLargeRect
	LIB	sp_HashDelete
	LIB	sp_GetCharAddr
	LIB	sp_RemoveHook
	XDEF	_c_level
	XDEF	_enems_persistent_deaths_init
	XDEF	_is_platform
	XDEF	_alter_map
	LIB	sp_MoveSprRelC
	LIB	sp_InitIM2
	XDEF	_pstep
	XDEF	_randres
	XDEF	_gp_gen
	XDEF	_spr_x
	XDEF	_spr_y
	XDEF	_beep_fx
	XDEF	_first_time
	XDEF	_pcharacter
	LIB	sp_GetTiles
	XDEF	_gp_aux
	XDEF	_gp_map
	XDEF	_spritesClipValues
	XDEF	_on_pant
	LIB	sp_Pallette
	XDEF	_unrle
	LIB	sp_WaitForNoKey
	XDEF	_pfiring
	XDEF	_gp_int
	XDEF	_enoffs
	XDEF	_pad_this_frame
	LIB	sp_JoySinclair1
	LIB	sp_JoySinclair2
	LIB	sp_ListPrepend
	XDEF	_behs
	LIB	sp_GetAttrAddr
	XDEF	_tile_got
	LIB	sp_HashCreate
	XDEF	_pad0
	XDEF	_hact
	LIB	sp_Random32
	LIB	sp_ListInsert
	XDEF	_n_pant
	LIB	sp_ListFree
	XDEF	_unrle_adv
	XDEF	_en_s
	XDEF	_en_t
	XDEF	_advance_worm
	XDEF	_en_x
	XDEF	_en_y
	XDEF	_p_t2
	XDEF	_system_init
	XDEF	_level0
	XDEF	_level0_ts_patterns_c
	LIB	sp_IntRect
	LIB	sp_ListLast
	XDEF	_level1_ts_patterns_c
	XDEF	_level1
	LIB	sp_ListCurr
	XDEF	_ISR
	XDEF	_hitter_x
	XDEF	_hitter_y
	XDEF	_main
	XDEF	_c_level_map_w
	LIB	sp_ListSearch
	LIB	sp_WaitForKey
	XDEF	_pkilled
	LIB	sp_Wait
	LIB	sp_GetScrnAddr
	XDEF	_joyfunc
	LIB	sp_PutTiles
	LIB	sp_RemoveDList
	XDEF	_key_jump
	XDEF	_gpit
	XDEF	_gpjt
	LIB	sp_ListNext
	XDEF	_rdch
	LIB	sp_HuffDecode
	XDEF	_keys
	XDEF	_hotspots_ini
	XDEF	_hud_update
	LIB	sp_Swap
	XDEF	_rdct
	XDEF	_isrc
	XDEF	_level0_ts_tilemaps_c
	XDEF	_pctj
	XDEF	_level1_ts_tilemaps_c
	XDEF	_levels
	XDEF	_pjustjumped
	XDEF	_phit
	LIB	sp_ListPrev
	XDEF	_sp_sw_cox
	XDEF	_sp_sw_coy
	XDEF	_pbodycount
	XDEF	_opbodycount
	XDEF	_ending_rle
	XDEF	_ensClipRects
	XDEF	__d1
	XDEF	__d2
	XDEF	_pinv
	XDEF	_pgotten
	XDEF	_encelloffset
	XDEF	_level0_behs_c
	XDEF	__en_state
	LIB	sp_RegisterHook
	LIB	sp_ListRemove
	LIB	sp_ListTrim
	XDEF	_rdxx
	XDEF	_rdyx
	LIB	sp_MoveSprAbsNC
	XDEF	_rdyy
	XDEF	_draw_tile_advance
	LIB	sp_HuffDelete
	XDEF	_dynamic_memory_pool
	XDEF	_at1
	XDEF	___d
	XDEF	_at2
	LIB	sp_ListAdd
	XDEF	_hotspots_paint
	LIB	sp_KeyPressed
	XDEF	_button_pressed
	LIB	sp_PrintAtInv
	XDEF	_cx1
	XDEF	_cx2
	XDEF	_cy1
	XDEF	_cy2
	LIB	sp_CompDListAddr
	XDEF	___x
	XDEF	___y
	XDEF	_pframe
	XDEF	_u_free
	XDEF	_ss_enems
	XDEF	_pfixct
	XDEF	_game_ending
	LIB	sp_CharRight
	XDEF	_do_game
	XDEF	_objs_taken
	XDEF	_en_dying
	XDEF	_olevel
	LIB	sp_InstallISR
	LIB	sp_HuffAccumulate
	LIB	sp_HuffSetState
	XDEF	_level_setup
	XDEF	_safe_prx
	XDEF	_safe_pry
	XDEF	_pad
	XDEF	_ts0
	XDEF	_map
	XDEF	_hotspots_do
	XDEF	_frame_counter
	XDEF	_ep_killed
	XDEF	_rda
	XDEF	_rdb
	XDEF	_rdc
	LIB	sp_SwapEndian
	LIB	sp_CharLeft
	XDEF	_rdd
	XDEF	_rde
	LIB	sp_CharDown
	LIB	sp_HeapSiftDown
	LIB	sp_HuffCreate
	XDEF	_rdf
	XDEF	_rdi
	XDEF	_pjb
	XDEF	_pcx
	XDEF	_pcy
	XDEF	_hrx
	LIB	sp_HuffEncode
	XDEF	_rds
	XDEF	_rdt
	XDEF	_hry
	XDEF	_hrt
	XDEF	_level1_behs_c
	LIB	sp_JoyTimexRight
	LIB	sp_PixelRight
	XDEF	_rdx
	XDEF	_rdy
	XDEF	_rdsint
	LIB	sp_Initialize
	XDEF	_wait_button
	XDEF	_p_s
	XDEF	_ticker
	XDEF	_bolts_clear_bolt
	XDEF	_enems_restore_vals
	LIB	sp_JoyTimexLeft
	LIB	sp_SetMousePosKempston
	XDEF	_oplife
	LIB	sp_ComputePos
	XDEF	_prx
	XDEF	_pry
	XDEF	_bitmask
	XDEF	_controls_setup
	XDEF	_pvx
	XDEF	_pvy
	XDEF	_en_life
	XDEF	_opobjs
	XDEF	_level0_enems_c
	XDEF	_bolts_update_screen
	XDEF	_en_washit
	XDEF	_tm_ctr
	XDEF	_opkeys
	XDEF	_ss_main
	LIB	sp_IntIntervals
	XDEF	_my_malloc
	XDEF	_ss_extra
	LIB	sp_inp
	LIB	sp_IterateSprChar
	XDEF	_title_rle
	LIB	sp_AddColSpr
	XDEF	_max_hotspots_type_1
	LIB	sp_outp
	XDEF	_draw_scr_buffer
	LIB	sp_IntPtInterval
	XDEF	_pflickering
	LIB	sp_RegisterHookFirst
	XDEF	_opstars
	LIB	sp_HashLookup
	XDEF	_pwashit
	LIB	sp_PFill
	XDEF	_ss_small
	XDEF	_en_state
	XDEF	_ppossee
	LIB	sp_HashRemove
	LIB	sp_CharUp
	XDEF	_collide
	XDEF	_hitter_frame
	XDEF	_game_init
	LIB	sp_MoveSprRelNC
	XDEF	_game_level
	XDEF	_level0_map_c
	XDEF	_ram_destination
	XDEF	_spr_id
	XDEF	_pstars
	XDEF	_use_ct
	XDEF	_psprid
	XDEF	_hitter_hs_x
	XDEF	_hitter_hs_y
	XDEF	_unpack
	XDEF	_game_shutdown_sprites
	XDEF	_spr_on
	XDEF	_game_loop
	XDEF	_enems_do
	XDEF	_spr_idx
	LIB	sp_IterateDList
	XDEF	_pthrust
	XDEF	_spr_cur
	XDEF	_springs_on
	XDEF	_level1_map_c
	XDEF	_game_over
	LIB	sp_LookupKey
	LIB	sp_HeapAdd
	LIB	sp_CompDirtyAddr
	LIB	sp_EmptyISR
	XDEF	_tsmaps
	XDEF	_hl_proc
	XDEF	_asm_beepfx
	XDEF	_ram_address
	XDEF	_ptile_get_ctr
	LIB	sp_StackSpace


; --- End of Scope Defns ---


; --- End of Compilation ---
