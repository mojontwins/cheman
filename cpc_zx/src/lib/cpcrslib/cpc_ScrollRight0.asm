
XLIB cpc_ScrollRight0





XREF tiles
XREF ancho_pantalla_bytes 
XREF rightColumnScr
XREF alto_pantalla_bytes
XREF pantalla_juego
XREF posiciones_pantalla
XREF posicion_inicial_superbuffer

.cpc_ScrollRight0		;;scrollea el area de pantalla de tiles
ld hl,pantalla_juego+alto_pantalla_bytes*ancho_pantalla_bytes/16-1
ld de,pantalla_juego+alto_pantalla_bytes*ancho_pantalla_bytes/16
ld bc,alto_pantalla_bytes*ancho_pantalla_bytes/16 -1 ;-1
LDDR

;;scrollea el superbuffer
ld hl,posicion_inicial_superbuffer+alto_pantalla_bytes*ancho_pantalla_bytes-2 ; pantalla_juego+alto_pantalla_bytes*ancho_pantalla_bytes/16-1
ld de,posicion_inicial_superbuffer+alto_pantalla_bytes*ancho_pantalla_bytes ;pantalla_juego+alto_pantalla_bytes*ancho_pantalla_bytes/16
ld bc,alto_pantalla_bytes*ancho_pantalla_bytes-1 ;-1
LDDR
RET