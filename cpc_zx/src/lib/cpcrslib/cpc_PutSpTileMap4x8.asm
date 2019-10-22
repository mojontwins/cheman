; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **       Ra�l Simarro,      Artaburu 2007           **
; ******************************************************

; [na_th_an] Nueva versi�n reescrita por Mojon Twins 
; - eliminamos la "cabecera" de los sprites.
; - la funci�n marca por separado los tiles "anteriores" (ox,oy)
;   y los tiles "actuales" (cx, cy).
; - Intenta "podar" los casos en los que los rect�ngulos 
;   sean iguales.
; - Intenta "afinar" y marcar solo 1 de long en vez de 2
;   cuando sea posible.
; - Prescinde de bucles y otros c�lculos al ser un caso muy concreto

XLIB cpc_PutSpTileMap4x8

XDEF bit_ancho
XDEF bit_alto
XDEF solo_coordenadas 

XREF tiles_tocados
XREF pantalla_juego
XREF posiciones_super_buffer
XREF tiles

LIB cpc_UpdTileTable

.cpc_PutSpTileMap4x8
    ex  de, hl
    ld  ixh, d
    ld  ixl, e

    ; Tendr� que marcar 1, 2 o 4 cuadros dependiendo de las alineaciones.

    ld e, (ix + 10) ; ox
    ld d, (ix + 11) ; oy

    ; Marcar OX, OY

    call do_update

    ld e, (ix + 8) ; cx
    ld d, (ix + 9) ; cy

    ; Copiamos (cx,cy) -> (ox,oy)

    ld (ix + 10), e
    ld (ix + 11), d

    ; Marcar CX, CY

do_update:
    ; X est� en bytes. Estar� alineado a rejilla si es par.
    ld a, e
    and 1
    ld (ancho), a

    ; Y est� en pixeles. Estar� alineado si AND 7 == 0
    ld a, d
    and 7
    ld (alto), a

    ; Convertir a coordenadas de rejilla
    srl e                   ; E = X / 2
    srl d
    srl d
    srl d                   ; D = Y / 8

    ; Marco el tile origen
    call cpc_UpdTileTable   ; Marca el tile en DE

    ; Marcar el tile de la derecha?
    ld a, (ancho)
    or a
    jr z, origin_next_row

    push de
    inc e
    call cpc_UpdTileTable   ; Marca el tile en DE
    pop de

origin_next_row:
    ; Marcar fila de abajo?
    ld a, (alto)
    or a
    jr z, fin

    inc d
    call cpc_UpdTileTable   ; Marca el tile en DE

    ; Marcar el tile de la derecha?
    ld a, (ancho)
    or a
    jr z, fin

    inc e
    call cpc_UpdTileTable   ; Marca el tile en DE

fin:
    ret

ancho: defb 0
alto: defb 0
