; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2009           **
; ******************************************************

; Modified by na_th_an with WASD MN ESC ENTER so I don't need
; cpc_AssignKey at all nor initialization, shaving 144 bytes

XLIB cpc_KeysData

XDEF tabla_teclas
XDEF keymap

.cpc_KeysData

.keymap0 defs 10

.tecla_0 defw $0204

.tabla_teclas0

	defw $4820 		; A
	defw $4720 		; D
	defw $4710 		; S
	defw $4708 		; W

	defw $4440 		; M
	defw $4540 		; N

	defw $4204		; ENTER
	defw $4804		; ESC	

	defw $4880		; Z
	defw $4780 		; X
	defw $ffff
	defw $ffff

	defb 0

DEFC tabla_teclas = tabla_teclas0
DEFC keymap = keymap0
