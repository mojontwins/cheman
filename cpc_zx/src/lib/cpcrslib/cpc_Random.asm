; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_Random

.cpc_Random
;push af

LD A,(valor_previo)
LD L,A
LD A,R 
ADD L
;los 2 �ltimos bits de A dir�n si es 0,1,2,3
LD (valor_previo),A
LD L,A ;se devuelve L (CHAR)
;pop af
ld h,0
RET
.valor_previo defb $FF