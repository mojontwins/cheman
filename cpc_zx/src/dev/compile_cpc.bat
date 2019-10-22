@echo off

SET game=cheman
..\utils\texts2array2.exe ..\texts\dialogue_sp.txt ..\dev\assets\ob_texts.h texts0 19
..\utils\mkts_om.exe platform=cpc mode=pals in=..\ports\cpc\gfx\pal.png prefix=my_inks out=assets\pal.h silent
..\utils\mkts_om.exe platform=cpc mode=pals in=..\ports\cpc\gfx\pal2.png prefix=my_inks2 out=assets\pal2.h silent

if [%1]==[tape] goto :tape
if [%1]==[disk] goto :disc

:sna
echo *** SNA version ***
echo ### COMPILING ###
..\utils\mkcellpointers.exe ..\ports\cpc\gfx\cell_pointers.spt assets\spriteset.h sprite_cells cpc
zcc +cpc -a -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -o %game%.asm tilemap_conf.asm mk3.c > nul 
zcc +cpc -m -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -o %game%.bin tilemap_conf.asm mk3.c > nul 
if errorlevel 0 goto :cool
goto :error
:cool

dir %game%.bin

echo ### MAKING SNA ###
copy %game%.bin game.bin > nul 
copy ..\ports\cpc\arkos_sfx.c.bin arkos.bin > nul 
..\utils\cpct_bin2sna game.bin 0x400 arkos.bin 0x7dfa -pc 0x400 > cheman.sna

echo ### LIMPIANDO ###
del %game%.bin  > nul 
del game.bin > nul
del arkos.bin > nul 
del zcc_opt.def  > nul 
goto :fin

:disc
echo *** DSK version ***

echo ### COMPILING ###
..\utils\mkcellpointers.exe ..\ports\cpc\gfx\cell_pointers.spt assets\spriteset.h sprite_cells cpc
zcc +cpc -a -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -o %game%.asm tilemap_conf.asm mk3.c > nul 
zcc +cpc -m -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -o %game%.bin tilemap_conf.asm mk3.c > nul 
if errorlevel 0 goto :cool
goto :error
:cool

rem zcc +cpc -vn -O3 -unsigned -m -notemp -zorg=1024 -lcpcrslib -DCPC -o %game%.bin tilemap_conf.asm mk3.c
dir %game%.bin

echo ### MAKING DSK ###
copy %game%.bin game.bin > nul 
copy ..\ports\cpc\base.dsk %game%.dsk > nul 
copy ..\ports\cpc\arkos_sfx.c.bin arkos.bin > nul 
copy ..\ports\cpc\bin\loading.bin loading.bin > nul
copy ..\ports\cpc\bin\pre-loading.bin pre-loading.bin > nul
..\utils\CPCDiskXP\CPCDiskXP.exe -File game.bin -AddAmsDosHeader 400 -AddToExistingDsk %game%.dsk
..\utils\CPCDiskXP\CPCDiskXP.exe -File arkos.bin -AddAmsDosHeader 7DFA -AddToExistingDsk %game%.dsk
..\utils\CPCDiskXP\CPCDiskXP.exe -File loading.bin -AddAmsDosHeader C000 -AddToExistingDsk %game%.dsk
..\utils\CPCDiskXP\CPCDiskXP.exe -File pre-loading.bin -AddAmsDosHeader C000 -AddToExistingDsk %game%.dsk

echo ### LIMPIANDO ###
del %game%.bin  > nul 
del game.bin > nul
del arkos.bin > nul 
del loading.bin > nul 2> nul
del pre-loading.bin > nul 2> nul
del zcc_opt.def  > nul 
goto :fin

:tape
echo *** CDT version ***
echo ### COMPILING ###
zcc +cpc -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -DTAPE -o %game%.bin tilemap_conf.asm mk3.c > nul 
zcc +cpc -a -vn -O3 -unsigned -zorg=1024 -lcpcrslib -DCPC -DTAPE -o %game%.asm tilemap_conf.asm mk3.c > nul 
dir %game%.bin

echo ### MAKING TAP ###

..\utils\apack.exe %game%.bin gamec.bin
..\utils\apack.exe ..\ports\cpc\bin\pre-loading.bin scrc0.bin
..\utils\apack.exe ..\ports\cpc\bin\loading.bin scrc1.bin

copy ..\ports\cpc\arkos_sfx.c.bin arkos_sfx.c.bin > nul 

set loader_org=$a300
rem 46848 is b700
rem 41728 is a300

..\utils\imanol.exe in=loader\loadercpc.asm-orig out=loader\loader.asm binsize=?%game%.bin scrc_size=?scrc0.bin scrc1_size=?scrc1.bin mainbin_addr=?41728-gamec.bin mainbin_size=?gamec.bin arkos_sfx_c_size=?arkos_sfx.c.bin arkos_c_size=?..\ports\cpc\bin\arkos.c.bin loader_org=%loader_org% > nul
..\utils\pasmo.exe loader\loader.asm loader.bin  > nul

dir loader.bin

..\utils\2cdt.exe -n -r %game% -s 1 -X %loader_org% -L %loader_org% loader.bin %game%.cdt  > nul
..\utils\2cdt.exe -r scr -s 1 -m 2 scrc0.bin %game%.cdt  > nul
..\utils\2cdt.exe -r scr -s 1 -m 2 scrc1.bin %game%.cdt  > nul
..\utils\2cdt.exe -r game -s 1 -m 2 gamec.bin %game%.cdt  > nul
..\utils\2cdt.exe -r arkos -s 1 -m 2 arkos_sfx.c.bin %game%.cdt  > nul

echo ### LIMPIANDO ###
rem del loader\loader.asm > nul
rem del loader.bin > nul 
del %game%.bin  > nul 
del gamec.bin > nul
del arkos_sfx.c.bin > nul 
del loading.bin > nul 2> nul
del zcc_opt.def  > nul 
del scrc0.bin > nul
del scrc1.bin > nul

goto :fin

:error
	echo ERROR!

:fin
