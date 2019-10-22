; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutSpTileMap		;se encarga de actualizar los tiles que toca el sprite 

XDEF bit_ancho
XDEF bit_alto
XDEF solo_coordenadas 

XREF tiles_tocados
XREF pantalla_juego					;datos de la pantalla, cada byte indica un tile
XREF posiciones_super_buffer
XREF tiles




LIB cpc_UpdTileTable

.cpc_PutSpTileMap
;seg�n las coordenadas x,y que tenga el sprite, se dibuja en el buffer
    ;ld ix,2
    ;add ix,sp
    ;ld l,(ix+0)
    ;ld h,(ix+1)	;HL apunta al sprite
    
	
	
    ex de,hl	;4
	LD IXH,d	;9
    LD IXL,e	;9   

                                                ;Obtencion de
;dimensiones, solo usadas para calcular iteraciones -> BC
ld l, (ix+0)
ld h, (ix+1)        ;dimensiones del sprite
ld C,(hl)    ;; ANCHO
inc hl
ld B,(hl) ;; ANCHO
Dec b
Dec c
;->BC coord -1

    ld l, (ix+10)
    ld h, (ix+11)    ;recoje coordenadas anteriores

    ld e, (ix+8)
    ld d, (ix+9)
    ld  (ix+10),e
    ld  (ix+11),d


;Obtencion x0y0 -> HL
PUSH HL
Srl l  ; x0/2
Srl h
Srl h
Srl h ; y0/8
Ex de,hl  ;-> Guarda de con origen de loops

POP hl ;(recuperar coord xoyo)
Add hl,bc  ;(Suma de dimensiones)
Srl l ; (x0+ancho)/2
Srl h
Srl h
Srl h; (y0+alto)/2

xor a
SBC hl,de        ;diferencia entre bloque inicial y bloque con dimensiones

;Hl tiene iteraciones en i,j partiendo de origen loops
Ld a,h
Inc a
Ld (pasos_alto_xW+1),a
Ld a,l
Inc a
;Ld (pasos_ancho_x+1),a

;Loop from d, i veces
;Loop from e, j veces

pasos_ancho_xW:    ; *parametro
    ld b,a
bucle_pasos_anchoW:
    push de
pasos_alto_xW: ; *parametro
    ld c,0
bucle_pasos_altoW:
        ; Mete E y D
            call cpc_UpdTileTable
        inc d
        dec c
        jp nz,bucle_pasos_altoW

    pop de
    inc e
    dec b
    jp nz,bucle_pasos_anchoW

    ret
