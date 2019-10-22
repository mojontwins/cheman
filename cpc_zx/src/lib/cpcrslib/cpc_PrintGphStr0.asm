; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; **		Includes code by Kevin Thacker			**
; ******************************************************

XLIB cpc_PrintGphStr0
XDEF direcc_destino0
XDEF colores_camb

XREF cola_impresion0
XREF pos_cola0


LIB cpc_Chars
XREF first_char

.cpc_PrintGphStr0  

;DE destino
;HL origen
;ex de,hl
ld (doble),a

;trabajo previo: Para tener una lista de trabajos de impresi�n. No se interrumpe
;la impresi�n en curso.
ld a,(imprimiendo)
cp 1
jp z,add_elemento

ld (direcc_destino),hl
ex de,hl
call bucle_texto0

;antes de terminar, se mira si hay algo en cola.
.bucle_cola_impresion
ld a,(elementos_cola)
or a
jp z,terminar_impresion
call leer_elemento
jp bucle_cola_impresion


.terminar_impresion
xor a
ld (imprimiendo),a
ret

.entrar_cola_impresion
;si se est� imprimiendo se mete el valor en la cola

ret
.add_elemento
di
	ld ix,(pos_cola)
	ld (ix+0),l
	ld (ix+1),h
	ld (ix+2),e
	ld (ix+3),d
	inc ix
	inc ix
	inc ix
	inc ix
	ld (pos_cola),ix
	
	ld hl,elementos_cola
	inc (hl)
	;Se a�aden los valores hl y de
ei
	ret
.leer_elemento
di
	ld ix,(pos_cola)
	ld l,(ix+0)
	ld h,(ix+1)
	ld e,(ix+2)
	ld d,(ix+3)
	dec ix
	dec ix
	dec ix
	dec ix
	ld (pos_cola),ix
	
	ld hl,elementos_cola
	dec (hl)
ei
	ret

.elementos_cola defw 0
.pos_cola defw cola_impresion
;pos_escritura_cola defw cola_impresion
.cola_impresion defs 12

.bucle_texto0
ld a,1
ld (imprimiendo),a

ld a,(first_char)
ld b,a		;resto 48 para saber el n�mero del caracter (En ASCII 0=48)

ld a,(hl)
or a ;cp 0
ret z
sub b
ld bc,cpc_Chars	;apunto a la primera letra
push hl


ld l,a		;en A tengo la letra que ser�a
ld h,0
add hl,hl
add hl,hl
add hl,hl	;x8 porque cada letra son 8 bytes
add hl,bc	;ahora HL apunta a los datos de la letra correspondiente



call escribe_letra

ld a,(doble)
cp 1
; ANTES DE IMPRIMIR SE CHEQUEA SI ES DE ALTURA EL DOBLE Y SE ACT�A EN CONSECUENCIA	
call z, doblar_letra


ld hl,(direcc_destino)


ld a,(doble)
cp 1
;alto  
jr z,cont_doble
ld de,letra_decodificada
defb $fD
LD H,8		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
jr cont_tot


.cont_doble
ld de,letra_decodificada_tmp
defb $fD
LD H,16		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE

.cont_tot
call cpc_PutSp0


ld hl,(direcc_destino)
inc hl
inc hl
ld (direcc_destino),hl

pop hl
inc hl
jp bucle_texto0



.doble defb 0
.imprimiendo defb 0
.direcc_destino defw 0


.cpc_PutSp0
;	defb $fD
;  		LD H,16		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
		ld b,7
		ld c,b
	.loop_alto_2

	.loop_ancho_2		
		ex de,hl
		ldi
		ldi
		
	   defb $fD
	   dec H
	   ret z	
	   ex de,hl   	   
.salto_linea
		LD C,$fe			;&07f6 			;salto linea menos ancho
		ADD HL,BC
		jp nc,loop_alto_2 ;sig_linea_2zz		;si no desborda va a la siguiente linea
		ld bc,$c050
		add HL,BC
		ld b,7			;s�lo se dar�a una de cada 8 veces en un sprite
		jp loop_alto_2	
		
		
		
	
.doblar_letra 
	ld hl,letra_decodificada
	ld de,letra_decodificada_tmp
	ld b,8
	.buc_doblar_letra
	ld a,(hl)
	inc hl
	ld (de),a
	inc de
	inc de
	ld (de),a
	dec de
	ld a,(hl)
	inc hl
	ld (de),a
	inc de
	inc de
	ld (de),a
	inc de
	djnz buc_doblar_letra
	ret

		
.escribe_letra		; Code by Kevin Thacker
push de
ld iy,letra_decodificada
ld b,8
.bucle_alto
push bc
push hl

ld e,(hl)
call op_colores	
ld (iy+0),d
inc iy
call op_colores
ld (iy+0),d
inc iy

pop hl
inc hl
pop bc
djnz bucle_alto
pop de
ret

.op_colores
ld d,0			;; initial byte at end will be result of 2 pixels combined

call op_colores_pixel	;; do pixel 0 
rlc d
call op_colores_pixel
rrc d
ret

;; follow through to do pixel 1

.op_colores_pixel
;; shift out pixel into bits 0 and 1 (source)
rlc e
rlc e

;; isolate
ld a,e
and $3
ld hl,colores_b0
add a,l
ld l,a
ld a,h
adc a,0
ld h,a
;; read it and combine with pixel so far
ld a,d
or (hl)
ld d,a
ret


.dato defb @00011011  ;aqu� dejo temporalmente el byte a tratar

.byte_tmp defs 3
.colores_b0 ;defino los 4 colores posibles para el byte. Los colores pueden ser cualesquiera. 
	  ;Pero se tienen que poner bien, en la posici�n que le corresponda.
;defb @00000000,  @10101000, @00100000, @00001010  ;@00000010, @00001010, @00101010, @00000000
defb @00001010,@00100000,@10100000,@00101000

;defb @00000000,  @01010100, @00010000, @00000101  ;@00000001, @00000101, @00010101, @00000000

.letra_decodificada defs 16 ;16	;uso este espacio para guardar la letra que se decodifica
.letra_decodificada_tmp defs 32 ;16	;uso este espacio para guardar la letra que se decodifica para tama�o doble altura




DEFC direcc_destino0 = direcc_destino
DEFC colores_camb = colores_b0