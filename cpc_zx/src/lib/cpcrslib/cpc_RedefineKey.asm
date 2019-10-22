; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_RedefineKey

LIB cpc_TestKeyboard

LIB cpc_KeysData
XREF  tabla_teclas

.cpc_RedefineKey

	;ld hl,2
    ;add hl,sp	
    ;ld a,(hl)
; En A se tiene el valor de la tecla seleccionada a comprobar [0..11]
	;A*2
;______________________________________________________________________________________________
;	;En A viene la tecla a redefinir (0..11)
	;rla	 	;A*2	;
	;ld e,a
	;ld d,0
	
	
	sla l
	ld h,0
	ld de,cpc_KeysData+tabla_teclas
	;ld hl,cpc_TestKeyboard+tabla_teclas

; gracias a Mochilote por detectar un error aqu�:	
	add hl,de ;Nos colocamos en la tecla a redefinir 

	ld (hl),$ff		; y la borramos
	inc hl
	ld (hl),$ff
	dec hl
	push hl
	call ejecutar_deteccion_teclado ;A tiene el valor del teclado
	ld a,d
; A tiene el byte (<>0)
; B tiene la linea	
	;guardo linea y byte
	pop hl	;recupera posici�n le�da
	ld a,(linea)
	ld (hl),a ;byte
	inc hl
	;ld a,b	  ;linea
	ld a,(bte)
	ld (hl),a
	ret
	

	
	
.ejecutar_deteccion_teclado
	LD A,$40
.bucle_deteccion_tecla	
	PUSH AF
	LD (bte),A
	
	call cpc_TestKeyboard					;en A vuelve los valores de la linea
	
	or a ;	CP 0
	Jr NZ, tecla_pulsada					; retorna si no se ha pulsado ninguna tecla
	POP AF
	INC A
	CP $4A
	Jr NZ, bucle_deteccion_tecla
	Jr ejecutar_deteccion_teclado

.tecla_pulsada
	ld (linea),a
	;LD A,(tmb)
	;ld (bte),A
	POP AF
	call comprobar_si_tecla_usada
	ret nc
	Jr bucle_deteccion_tecla 
;.tmb defb 0	
		




.comprobar_si_tecla_usada ; A tiene byte, B linea
	;ld (linea),a
	;LD A,B
	;add $40
	;ld (bte),A
	ld b,12		;numero m�ximo de tecla redefinibles
	ld ix,cpc_KeysData+tabla_teclas ;-2 ;tecla_0
	ld c,(ix+0)
.bucle_bd_teclas
;comprobar byte	
	ld a,(linea)
	ld c,(ix+0)
	cp (ix+0)
	jr z, comprobar_linea	
	inc ix
	inc ix
	djnz bucle_bd_teclas
scf
ccf
	
	ret	; si vuelve despu�s de comprobar, que sea NZ
.comprobar_linea	;si el byte es el mismo, mira la linea
	ld a,(bte)
	cp (ix+1)
;	ret z	; Vuelve con Z si coincide el byte y la linea
	jr z, tecla_detectada
	inc ix
	inc ix
	djnz bucle_bd_teclas

scf
ccf
	ret ; si vuelve despu�s de comprobar, que sea NZ
.tecla_detectada
	scf
	ret
	

.linea defb 0
.bte defb 0

	
