; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_SetTile		;pone un byte en la posici�n de la pantalla indicada

XREF pantalla_juego
XREF ancho_pantalla_bytes

.cpc_SetTile

	ld ix,2
	add ix,sp
	
	ld e,(ix+2)
	ld a,(ix+4)
	
	include "multiplication2.asm"

	ld e,a
	ld d,0
	add hl,de
		
	ld de,pantalla_juego
	add hl,de
	ld a,(ix+0)
	ld (hl),a
	ret
