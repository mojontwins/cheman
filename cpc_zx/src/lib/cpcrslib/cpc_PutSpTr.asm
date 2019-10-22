; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutSpTr

LIB cpc_PutSpTr0
XREF anchot
XREF suma_siguiente_lineat


.cpc_PutSpTr	; dibujar en pantalla el sprite
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

    
    ld (cpc_PutSpTr0+anchot+1),a	;actualizo rutina de dibujo 
	sub 1
	cpl
	ld (cpc_PutSpTr0+suma_siguiente_lineat+1),a    ;comparten los 2 los mismos valores.		
	
	ld A,(ix+4)  
	jp  cpc_PutSpTr0
	