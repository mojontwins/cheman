; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutSp


LIB cpc_PutSp0
XREF suma_siguiente_linea0
XREF ancho0


.cpc_PutSp	; dibujar en pantalla el sprite
		; Entradas	bc-> Alto Ancho
		;			de-> origen
		;			hl-> destino
		; Se alteran hl, bc, de, af			
		
	ld ix,2
	add ix,sp
	
	ld l,(ix+0)
	ld h,(ix+1)
	
	ld a,(ix+2)
	
   	ld e,(ix+6)
	ld d,(ix+7)

    ld (cpc_PutSp0+ancho0+1),a		;actualizo rutina de captura
    ;ld (anchot+1),a	;actualizo rutina de dibujo 
	sub 1
	cpl
	ld (cpc_PutSp0+suma_siguiente_linea0+1),a    ;comparten los 2 los mismos valores.		
	
	ld A,(ix+4)  
	jp cpc_PutSp0
	


