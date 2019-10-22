; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_PutMaskSpTileMap2b

XREF tiles_tocados
XREF pantalla_juego					;datos de la pantalla, cada byte indica un tile
XREF posiciones_super_buffer
XREF tiles
XREF ancho_pantalla_bytes 
XREF posicion_inicial_superbuffer

.cpc_PutMaskSpTileMap2b
;seg�n las coordenadas x,y que tenga el sprite, se dibuja en el buffer
   
    ex de,hl
    LD IXH,d	;9
    LD IXL,e	;9 
    

   
    ld a,(ix+8)
    ld e,(ix+9)
    
include "multiplication1.asm"
   


	ld b,0
	ld c,a
	add hl,bc
	;HL=E*H+D




	
	ld de,posicion_inicial_superbuffer
	add hl,de
	;hl apunta a la posici�n en buffer (destino)
	
	ld (ix+4),l		;update superbuffer address
    ld (ix+5),h
    
	ld e,(ix+0)
    ld d,(ix+1)	;HL apunta al sprite
	
    ;con el alto del sprite hago las actualizaciones necesarias a la rutina
    ld a,(de)
    ld (loop_alto_map_sbuffer+2),a
    ld b,a
    ld a,ancho_pantalla_bytes
    sub b
    ld (ancho_2+1),a
	inc de
	ld a,(de)
	inc de
	
	;ld a,16		;necesito el alto del sprite
	
	
	
.sp_buffer_mask
	ld b,0
.ancho_2	
	ld c,ancho_pantalla_bytes-4 ;60	;;DEPENDE DEL ANCHO

	;defb $fd
	;LD H,A		;ALTO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
	ld ixh,a
.loop_alto_map_sbuffer
		;defb $fd
		;LD L,4		;ANCHO, SE PUEDE TRABAJAR CON HX DIRECTAMENTE
		ld ixl,4
		ex de,hl
.loop_ancho_map_sbuffer		

			
		LD A,(DE)	;leo el byte del fondo
		AND (HL)	;lo enmascaro		
		INC HL
		OR (HL)		;lo enmascaro 
		LD (DE),A	;actualizo el fondo
		INC DE
		INC HL
		
		;defb $fD
		;DEC L		;resta ancho
		dec ixl
		JP NZ,loop_ancho_map_sbuffer
		
	   ;defb $fd
	   ;dec H
	   dec ixh
	   ret z
	   EX DE,HL
;hay que sumar 72 bytes para pasar a la siguiente l�nea
		add HL,BC	
		jp loop_alto_map_sbuffer
