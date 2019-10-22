; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutTile2x8b		

LIB cpc_GetScrAddress0

.cpc_PutTile2x8b ;siempre se dibujan en posicion caracter as� que no hay saltos raros en HL, se puede quitar la �ltima parte

	ld ix,2
	add ix,sp


	ld L,(ix+0)
	ld h,(ix+1)	;pantalla
	
	;call cpc_GetScrAddress0
		
	ld E,(ix+2)
	ld D,(ix+3)	;DE sprite
	

		;LD A,8

		defb $fD
   		LD H,8		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
		ld b,7
		
	.loop_alto_tile_2x8
	.loop_ancho_tile_2x8		
		ld A,(DE)
		ld (hl),a
		inc de
		inc hl
		
		ld A,(DE)
		ld (hl),a
		inc de
;		inc hl

	   defb $fD
	   dec H
	   ret z
	   
.suma_siguiente_linea0_tile_2x8		;
		LD C,$ff			;&07f6 			;salto linea menos ancho
		ADD HL,BC
		jp nc,loop_alto_tile_2x8 ;sig_linea_2zz		;si no desborda va a la siguiente linea
		ld bc,$c050
		
		add HL,BC
		ld b,7			;s�lo se dar�a una de cada 8 veces en un sprite
		jp loop_alto_tile_2x8	
