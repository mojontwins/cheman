; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2009       **
; ******************************************************


XLIB cpc_EnableFirmware		
LIB cpc_DisableFirmware
XREF backup

.cpc_EnableFirmware
	DI
	LD de,(backup)
				
	LD HL,$0038
	LD (hl),e		;EI
	inc hl
	LD (hl),d	;RET
	EI
	RET

