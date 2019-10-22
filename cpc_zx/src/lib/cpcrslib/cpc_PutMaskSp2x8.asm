; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutMaskSp2x8		
; imprime un sprite de 8x8 en modo 1
; El formato del sprite es el siguiente por cada l�nea:
; defb byte1,byte2,byte3,byte4
; siendo byte1 y byte3 son las m�scaras de los bytes 2 y 4
; se recibe de entrada el sprite y la posici�n.
.cpc_PutMaskSp2x8
	ld ix,2
	add ix,sp
   		   		
	ld l,(ix+0)
	ld h,(ix+1)
		
	ld e,(ix+2)
	ld d,(ix+3)

		defb $fD
   		LD H,8		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
		ld b,7
	.loop_alto_mask_2x8
	.loop_ancho_mask_2x8
		EX DE,HL
		LD A,(DE)	;leo el byte del fondo	
		AND (HL)	;lo enmascaro		
		INC HL
		OR (HL)		;lo enmascaro 
		LD (DE),A	;actualizo el fondo
		INC DE
		INC HL
;COMO SOLO SON 2 BYTES, es m�s r�pido y econ�mico desplegar la rutina

		LD A,(DE)	;leo el byte del fondo
		AND (HL)	;lo enmascaro		
		INC HL
		OR (HL)		;lo enmascaro con el sprite
		LD (DE),A	;actualizo el fondo
		INC DE
		INC HL

	   defb $fD
	   dec H		;decremento el alto del sprite
	   ret z
	   EX DE,HL
.suma_siguiente_linea_mask_2x8		;
		LD C,$fe			;$07f6 			;salto linea menos ancho
		ADD HL,BC
		jp nc,loop_alto_mask_2x8	;si no desborda va a la siguiente linea
		ld bc,$c050
		add HL,BC
		ld b,7			;s�lo se dar�a una de cada 8 veces en un sprite
		jp loop_alto_mask_2x8	
