; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutMaskSprite


LIB cpc_PutMaskSp0
XREF suma_siguiente_linea_m0
XREF ancho_m0


.cpc_PutMaskSprite	; dibujar en pantalla el sprite
		; Entradas	bc-> Alto Ancho
		;			de-> origen
		;			hl-> destino
		; Se alteran hl, bc, de, af			
		
	
pop af
pop de
pop hl
push af

	ld a,(hl)		;ancho
	inc hl

    ld (cpc_PutMaskSp0+ancho_m0+1),a		;actualizo rutina de captura
    ;ld (anchot+1),a	;actualizo rutina de dibujo 
	sub 1
	cpl
	ld (cpc_PutMaskSp0+suma_siguiente_linea_m0+1),a    ;comparten los 2 los mismos valores.		
	
	ld a,(hl)	;alto
	inc hl	
	ex de,hl
	
	jp cpc_PutMaskSp0

	
	