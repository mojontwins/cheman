@echo off

if [%1]==[justcompile] goto :justcompile

echo Generating pals
..\utils\mkts.exe mode=pals pals=..\gfx\palts0.png out=work\palts0.h label=palts0 silent
..\utils\mkts.exe mode=pals pals=..\gfx\palss0.png out=work\palss0.h label=palss0 silent
..\utils\mkts.exe mode=pals pals=..\gfx\palts1.png out=work\palts1.h label=palts1 silent
..\utils\mkts.exe mode=pals pals=..\gfx\palss1.png out=work\palss1.h label=palss1 silent
..\utils\mkts.exe mode=pals pals=..\gfx\paltscuts.png out=work\paltscuts.h label=paltscuts silent
..\utils\mkts.exe mode=pals pals=..\gfx\pallang.png out=work\pallang.h label=pallang silent
copy /b work\pal*.h assets\palettes.h > nul
del work\pal*.h /q > nul 2> nul

echo Exporting chr
cd ..\gfx
..\utils\mkts.exe mode=scripted in=import_patterns.spt out=..\dev\tileset.chr silent

echo Exporting RLE'd screens
..\utils\namgen.exe in=hud.png out=..\dev\assets\hud_rle.h pals=palts0.png chr=..\dev\tileset.chr bank=0 rle=hud_rle
..\utils\namgen.exe in=title.png out=..\dev\assets\title_rle.h pals=paltscuts.png chr=..\dev\tileset.chr bank=0 rle=title_rle
..\utils\namgen.exe in=ending.png out=..\dev\assets\ending_rle.h pals=paltscuts.png chr=..\dev\tileset.chr bank=0 rle=ending_rle

echo Exporting enems
cd ..\enems
..\utils\eneexp3.exe level0.ene ..\dev\assets\enems0.h 0 1 gencounter
..\utils\eneexp3.exe level1.ene ..\dev\assets\enems1.h 1 1 gencounter

echo Compiling enembehs
cd ..\script
..\utils\pencompiler.exe enembehs.spt ..\dev\assets\compiled_enems.h

echo Making map
cd ..\map
..\utils\rle53mapMK1.exe ..\map\level0.map ..\dev\assets\map0.h 5 4 15 0 1
..\utils\rle53mapMK1.exe ..\map\level1.map ..\dev\assets\map1.h 4 5 15 1 0

echo Exporting music and sound
cd ..\dev
..\utils\text2data.exe ..\ogt\music.txt -ca65 -ch1..4
..\utils\nsf2data.exe ..\ogt\sounds.nsf -ca65 -ntsc
copy ..\ogt\music.s > nul
copy ..\ogt\sounds.s > nul

cd ..\dev

:justcompile
if [%2]==[noscript] goto :noscript

echo Building script
cd ..\script
..\utils\mscmk1.exe script.spt ..\dev\assets\mscnes.h 20
cd ..\dev

:noscript
..\..\cc65_2.13.2\bin\cc65 -Oi game.c --add-source
..\..\cc65_2.13.2\bin\ca65 crt0.s -o crt0.o -D CNROM=0
..\..\cc65_2.13.2\bin\ca65 game.s
..\..\cc65_2.13.2\bin\ld65 -v -C nes.cfg -o cart.nes crt0.o game.o runtime.lib -m labels.txt

del *.o
del game.s

del work\*.h /q 2> nul
del work\*.bin.* /q 2> nul

echo DONE!
