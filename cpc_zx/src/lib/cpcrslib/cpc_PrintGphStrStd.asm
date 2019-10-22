; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2009       **
; ******************************************************

XLIB cpc_PrintGphStrStd


LIB cpc_PrintGphStrStd0
XREF direcc_destino0s_m1
XREF color_uso

.cpc_PrintGphStrStd
;preparaci�n datos impresi�n. El ancho y alto son fijos!
	ld ix,2
	add ix,sp
	
	ld l,(ix+0)
	ld h,(ix+1)	;destino
	
	
   	ld e,(ix+2)
	ld d,(ix+3)	;texto origen

	ld a,(ix+4) ;color
	ld (color_uso+1),a
	
 JP cpc_PrintGphStrStd0