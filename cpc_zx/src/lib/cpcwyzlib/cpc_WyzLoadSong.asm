; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007           **
; ******************************************************

XLIB cpc_WyzLoadSong

LIB cpc_WyzPlayer
XREF CARGA_CANCION_WYZ

.cpc_WyzLoadSong	
	;LD HL,2
	;ADD HL,SP
	;LD A,(HL)
	ld a,l
	JP CARGA_CANCION_WYZ+cpc_WyzPlayer
