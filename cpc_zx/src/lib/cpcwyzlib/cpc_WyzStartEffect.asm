; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007           **
; ******************************************************

XLIB cpc_WyzStartEffect

LIB cpc_WyzPlayer
XREF INICIA_EFECTO_WYZ

.cpc_WyzStartEffect	
	LD HL,2
	ADD HL,SP
	LD b,(HL)
	INC HL
	INC HL
	LD c,(HL)
	;AHORA TIENE 2 par�metros: C:canal, B:numero efecto
	JP INICIA_EFECTO_WYZ + cpc_WyzPlayer