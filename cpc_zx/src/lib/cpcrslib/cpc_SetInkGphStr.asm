; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_SetInkGphStr

LIB cpc_PrintGphStr0
XREF colores_camb

.cpc_SetInkGphStr
;preparaci�n datos impresi�n. El ancho y alto son fijos!
	ld ix,2
	add ix,sp
	

 	ld a,(ix+0) ;valor
	ld c,(ix+2)	;color
	
ld hl,colores_camb+cpc_PrintGphStr0
ld b,0
add hl,bc
ld (hl),a

	
ret
 
