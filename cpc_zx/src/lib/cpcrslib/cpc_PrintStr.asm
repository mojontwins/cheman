; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007           **
; ******************************************************

;Rutina que emplea el firmware

XLIB cpc_PrintStr

.cpc_PrintStr 
	 
	;ld hl,2
    ;add hl,sp			
	;ld e,(hl)
	;inc hl
	;ld d,(hl)
	
	;pop af		;guardo la pila
	;pop de		;recogo el par�metro
	;push af		;restauro la pila
	
	.bucle_imp_cadena
		ld a,(hl)	
		or a ;		cp 0
		jr z,salir_bucle_imp_cadena
		call $bb5a
		inc hl
		jr bucle_imp_cadena
	.salir_bucle_imp_cadena
		ld a,$0d	; para terminar hace un salto de l�nea
		call $bb5a 
		ld a,$0a
		jp $bb5a 
		
		;ret
