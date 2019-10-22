@echo off

SET game=cheman

echo ### PREPARING ###
..\utils\texts2array2.exe ..\texts\dialogue_sp.txt ..\dev\assets\ob_texts.h texts0 19

echo ### COMPILING ###
..\utils\mkcellpointers.exe ..\ports\zx\gfx\cell_pointers.spt assets\spriteset.h sprite_cells zx
zcc +zx -a -vn -O3 -signed -zorg=24050 -lsplib2 -DSPECCY -o cheman_zx.asm mk3.c > nul
zcc +zx -m -vn -O3 -signed -zorg=24050 -lsplib2 -DSPECCY -o %game%.bin mk3.c > nul

dir %game%.bin

echo ### MAKING TAP ###
..\utils\apack.exe %game%.bin gamec.bin
..\utils\apack.exe ..\ports\zx\bin\pre-loading.bin pre_scrc.bin
..\utils\apack.exe ..\ports\zx\bin\loading.bin scrc.bin
..\utils\imanol.exe in=loader\loaderzx.asm-orig out=loader\loader.asm mainbincompstart=?65000-gamec.bin mainbincomplength=?gamec.bin loadingcompstart=?65000-scrc.bin loadingcomplength=?scrc.bin preloadingcompstart=?65000-pre_scrc.bin preloadingcomplength=?pre_scrc.bin
..\utils\pasmo.exe loader\loader.asm loader.bin loader.txt
..\utils\GenTape.exe %game%.tap ^
	basic 'CHEMAN' 10 loader.bin ^
	data              pre_scrc.bin ^
	data              scrc.bin ^
	data              gamec.bin

echo ### MAKING ROM TAP ###
..\utils\bas2tap.exe -a10 -sCHEMAN loader\loader_rom.bas work\0.tap
..\utils\bin2tap.exe -o work\1.tap -a 16384 ..\ports\zx\bin\loading.bin
..\utils\bin2tap.exe -o work\2.tap -a 24050 %game%.bin
copy /b work\0.tap + work\1.tap + work\2.tap cheman_rom.tap

echo ### LIMPIANDO ###
del gamec.bin 
del scrc.bin
del pre_scrc.bin
del loader\loader.asm > nul
rem del loader.bin > nul
del loader.txt > nul
del %game%.bin > nul
del zcc_opt.def > nul

echo ### DONE ###
:fin
