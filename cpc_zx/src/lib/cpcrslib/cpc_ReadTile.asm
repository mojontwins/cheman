; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_ReadTile		;pone un byte en la posici�n de la pantalla indicada

XREF pantalla_juego
XREF ancho_pantalla_bytes

.cpc_ReadTile

	
	;ld ix,2
	;add ix,sp
	;ld e,(ix+0)
	;ld c,(ix+2)
	
	ld hl,2
    add hl,sp			; �Es la forma de pasar par�metros? �Se pasan en SP+2? �en la pila?			
	ld E,(hl)		;Y
	inc hl
	inc hl
	ld a,(hl)	;X
	
	include "multiplication2.asm"
	

	
			ld e,a
			ld d,0
		add hl,de		;SUMA X A LA DISTANCIA Y*ANCHO
	ld de,pantalla_juego
		add hl,de
		ld l,(hl)
		ld h,0
	ret
