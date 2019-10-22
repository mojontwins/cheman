(Artaburu)

Sobre el Arkos, funciona con los mismos principios que el Wyz, vamos, que se pone en la interrupcion que cada 6 veces, una llame al player.

La pega que tiene es que las canciones se deben compilar en una dirección de memoria y ejecutarlas desde esa posición de memoria, si no, la cosa o no suena o suena fatal o peor.

El primer paso es activar la canción, el segundo tocar y el tercero parar de tocar.

Los FX van en una segunda canción que también hay que activar antes de llamar a los FX. La llamada es un poco más complicada que en WYZ porque hay que especificar muchas cosas.

Os dejo el código del arkos que estoy usando en Galactic Tomb, la interrupción y las llamadas a los efectos.

Yo cargo el Arkos en &0350. En la inicialización, DE apunta a la canción. Recordad que se ha tenido que compilar en el tracker para esa dirección de memoria.

```
   __asm
      ld de,#0x1010         
      call #0x350+0x6c5   ; PLY_INIT
   __endasm;
```

Esta es la parada de la música:

```
   __asm
   call 0x350+0x71a   ;PLY_STOP
   __endasm;
```

Los FX se activan igual (en mi caso es una canción en &7e00):

```
      __asm
         ld de,#0x7e00         
      call #0x350+0x6c5   ; PLY_INIT
      __endasm;
```

y para llamar un FX (cuidado que también se estropean los registros):

```
__asm
   fx_disparo:
;      push hl
;      push de
;      push bc
;      push af
      xor a
      ld hl,#0x0f01
      ld de,#0x0027
      ld bc,#0
;   To play a sound effect =
;   A = No Channel (0,1,2)
;   L = SFX Number (>0)
;   H = Volume (0...F)
;   E = Note (0...143)
;   D = Speed (0 = As original, 1...255 = new Speed (1 is the fastest))
;   BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.      
      call 0x0a8d   ;PLY_SFX_Init
;      pop af
;      pop bc
;      pop de
;      pop hl
      ret
__endasm;
```

Esta es una interrupción que se instala y llama al player. Ojo que se corrompen todos los registros, los normales y los espejo (HL',DE',BC'):

```
void inst_interrup1(void)
{
__asm
    DI
    ld a,#0xc3
    LD   (#0x0038),a
    ld hl,#interrupcion0
    LD   (#0x0039),HL
   xor a
   ld (#contador+1),a
   ei
   ret
interrupcion0:
di
push bc
push hl
push de
push af
contador8:
ld a,#0
inc a
cp #6
jp nz,c1118
exx
push de
push hl
push bc
push af
push ix
push iy
call 0x350+1   ;PLY_PLAY
pop iy
pop ix
pop af
pop bc
pop hl
pop de
exx
xor a
c1118:
ld (#contador8+1),a
pop af
pop de
pop hl
pop bc
ei
ret
__endasm;
}
```

