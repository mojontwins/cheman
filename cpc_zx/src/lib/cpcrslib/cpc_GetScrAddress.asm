; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_GetScrAddress
LIB cpc_GetScrAddress0

.cpc_GetScrAddress
	;ld ix,2		;14
    ;add ix,sp	;15
    
    ;ld l,(ix+0)	;19
    ;ld a,(ix+2)	;19
    ;67
    
    
	ld hl,2	;10
    add hl,sp	;11		
    
	ld e,(hl)	;7
	inc hl		;6
	inc hl		;6
	ld a,(hl)	;7
	;ex de,hl	;4
	ld l,e		;4
	;51
	jp cpc_GetScrAddress0
	
