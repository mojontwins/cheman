 ; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PrintGphStrXYM1

LIB cpc_GetScrAddress0

LIB cpc_PrintGphStr0M1

XREF direcc_destino0_m1

.cpc_PrintGphStrXYM1
;preparaci�n datos impresi�n. El ancho y alto son fijos!
	ld ix,2
	add ix,sp
	

 	ld L,(ix+0)
	ld A,(ix+2)	;pantalla
	
	call cpc_GetScrAddress0   

	;destino
	
   	ld e,(ix+4)
	ld d,(ix+5)	;texto origen
	xor a
    
 JP cpc_PrintGphStr0M1