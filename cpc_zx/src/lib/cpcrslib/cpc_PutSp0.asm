; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutSp0
XDEF ancho0 
XDEF suma_siguiente_linea0 

		
.cpc_PutSp0
		defb $fD
   		LD H,a		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
		ld b,7
	.loop_alto_2
	   ld c,4		; << PARAMETRO ANCHO
	.loop_ancho_2		
		ld A,(DE)
		ld (hl),a
		inc de
		inc hl
		dec c
		jp nz,loop_ancho_2
	   defb $fD
	   dec H
	   ret z

	   	   
.salto_linea
		LD C,$ff			;<< PARAMETRO salto linea menos ancho
		ADD HL,BC
		jp nc,loop_alto_2 ;sig_linea_2zz		;si no desborda va a la siguiente linea
		ld bc,$c050
		
		add HL,BC
		ld b,7			;s�lo se dar�a una de cada 8 veces en un sprite
		jp loop_alto_2	


				
DEFC ancho0 = loop_alto_2
DEFC suma_siguiente_linea0 = salto_linea