; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007           **
; ******************************************************

XLIB cpc_SetColour

.cpc_SetColour		;El n�mero de tinta 17 es el borde
    LD HL,2
    ADD HL,SP	
  	LD E,(HL)
    INC HL
  	INC HL
    LD A,(HL)
  	LD BC,$7F00                     ;Gate Array 
	OUT (C),A                       ;N�mero de tinta
	LD A,@01000000              	;Color (y Gate Array)
	ADD E
	OUT (C),A                       
	RET