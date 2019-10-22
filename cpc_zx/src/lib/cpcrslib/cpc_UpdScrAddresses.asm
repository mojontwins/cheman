; ******************************************************
; **       Librer�a de rutinas para Amstrad CPC       **
; **	   Ra�l Simarro, 	  Artaburu 2007       **
; ******************************************************

XLIB cpc_UpdScrAddresses			;recoge los tiles tocados, los restaura-
			;datos de la pantalla, cada byte indica un tile
XREF posiciones_pantalla


.cpc_UpdScrAddresses
ex de,hl
ld bc,$50
ld a,1

ld ix, posiciones_pantalla
.bucle_pos
ld hl,0
push af
call mult
pop af
add hl,de
ld (ix+0),l
ld (ix+1),h
inc ix
inc ix
inc a
cp 20 

jp nz, bucle_pos
ret 

.mult
dec a
ret z
add hl,bc
jp mult