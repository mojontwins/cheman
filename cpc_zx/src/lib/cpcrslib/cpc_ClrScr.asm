; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2009       **
; ******************************************************


XLIB cpc_ClrScr		

.cpc_ClrScr
	XOR A
	LD HL,$c000
	LD DE,$c001
	LD BC,16383
	LD (HL),A
	LDIR
	RET

