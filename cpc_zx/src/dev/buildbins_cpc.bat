@echo off

mkdir ..\ports\cpc\bin 2> nul
del ..\ports\cpc\bin\*.bin /q /s > nul 2>  nul
del ..\ports\cpc\bin\level0\*.bin /q /s > nul 2>  nul
del ..\ports\cpc\bin\level0\*.h /q /s > nul 2>  nul
del ..\ports\cpc\bin\level1\*.bin /q /s > nul 2>  nul
del ..\ports\cpc\bin\level1\*.h /q /s > nul 2>  nul
del ..\ports\cpc\bin\*.h /q /s > nul 2>  nul

echo.
echo Building binary assets
echo ======================

echo.
echo General assets
echo --------------
..\utils\pasmo.exe assets\cpc_TrPixLut.asm ..\ports\cpc\bin\trpixlut.bin
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssch.png    out=..\ports\cpc\bin\ssch      size=12,1 metasize=2,3 silent
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssempty.png out=..\ports\cpc\bin\ssempty   size=1,1  metasize=2,3 silent
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssen.png    out=..\ports\cpc\bin\ssen      size=6,1  metasize=2,3 silent
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\sssmall.png out=..\ports\cpc\bin\sssmall   size=1,1  metasize=1,1 silent
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ssextra.png out=..\ports\cpc\bin\ssextra   size=2,1  metasize=2,3 silent
..\utils\mkts_om.exe platform=cpc mode=sprites  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\pumpkin.png out=..\ports\cpc\bin\sspumpkin size=1,1  metasize=2,2 silent

echo.
echo Fixed screens
echo -------------
..\utils\mkts_om.exe platform=cpc mode=scr brickInput pal=..\ports\cpc\gfx\pal_loading.png in=..\ports\cpc\gfx\loading.png out=..\ports\cpc\bin\loading.bin silent
..\utils\mkts_om.exe platform=cpc mode=scr brickInput pal=..\ports\cpc\gfx\pal_loading.png in=..\ports\cpc\gfx\pre-loading.png out=..\ports\cpc\bin\pre-loading.bin silent

echo.
echo Level 0 assets
echo --------------
mkdir ..\ports\cpc\bin\level0 2> nul
del ..\ports\cpc\bin\level0\*.bin /q /s > nul 2>  nul
del ..\ports\cpc\bin\level0\*.h /q /s > nul 2>  nul
..\utils\rle53map_sp.exe in=..\map\level0.map out=..\ports\cpc\bin\level0\ size=5,4 tlock=15 fixmappy nodecos noindex scrsize=16,12
..\utils\eneexp3b_sp.exe in=..\enems\level0.ene out=..\ports\cpc\bin\level0\ yadjust=1 prefix=0 genallcounters
..\utils\list2bin.exe  ..\ports\cpc\gfx\ts0.behs ..\ports\cpc\bin\level0\behs.bin
..\utils\mkts_om.exe platform=cpc mode=mapped  brickInput pal=..\ports\cpc\gfx\pal.png in=..\ports\cpc\gfx\ts0.png out=..\ports\cpc\bin\level0\ts size=8,5 metasize=2,2 tmapoffs=100 max=36 silent 

echo.
echo Level 1 assets
echo --------------
mkdir ..\ports\cpc\bin\level1 2> nul
del ..\ports\cpc\bin\level1\*.bin /q /s > nul 2>  nul
del ..\ports\cpc\bin\level1\*.h /q /s > nul 2>  nul
..\utils\rle53map_sp.exe in=..\map\level1.map out=..\ports\cpc\bin\level1\ size=4,5 tlock=15 nodecos noindex scrsize=16,12
..\utils\eneexp3b_sp.exe in=..\enems\level1.ene out=..\ports\cpc\bin\level1\ yadjust=1 prefix=1 genallcounters
..\utils\list2bin.exe  ..\ports\cpc\gfx\ts1.behs ..\ports\cpc\bin\level1\behs.bin
..\utils\mkts_om.exe platform=cpc mode=mapped  brickInput pal=..\ports\cpc\gfx\pal2.png in=..\ports\cpc\gfx\ts1.png out=..\ports\cpc\bin\level1\ts size=8,5 metasize=2,2 tmapoffs=100 max=36 silent 

echo.
echo Creating main pattern set and level-based tilemaps
echo --------------------------------------------------
cd ..\ports\cpc\gfx
..\..\..\utils\mkts_om.exe platform=cpc mode=scripted in=ts.spt silent
cd ..\..\..\dev

echo.
echo ARKOS tracker player stuff
echo --------------------------
cd ..\lib\arkos\
echo Assembling player
..\..\utils\pasmo.exe ArkosTrackerPlayer_CPC_MSX.asm ..\..\ports\cpc\bin\arkos.bin arkos.lst
echo Compiling assets
cd ..\..\ports\cpc\ogt\
..\..\..\utils\AKSToBIN.exe -a 32250 cheman_v1.aks ..\bin\m0.bin
..\..\..\utils\AKSToBIN.exe -s -a 60928 sfx___vol_1.aks ..\bin\sfx.bin
cd ..\..\..\dev\
..\utils\apack.exe ..\ports\cpc\bin\arkos.bin ..\ports\cpc\bin\arkos.c.bin >nul
..\utils\apack.exe ..\ports\cpc\bin\sfx.bin ..\ports\cpc\bin\sfx.c.bin >nul
copy /b ..\ports\cpc\bin\arkos.c.bin + ..\ports\cpc\bin\sfx.c.bin ..\ports\cpc\arkos_sfx.c.bin >nul
..\utils\apack.exe ..\ports\cpc\bin\m0.bin ..\ports\cpc\bin\m0.c.bin >nul

echo.
echo Compressing some
echo ================
..\utils\apack.exe ..\ports\cpc\bin\trpixlut.bin ..\ports\cpc\bin\trpixlutc.bin
echo Level 0 assets
for %%f in (..\ports\cpc\bin\level0\*.bin) do ..\utils\apack.exe "%%~pf%%~nf.bin" "%%~pf%%~nf.c.bin"  >nul
echo Level 1 assets
for %%f in (..\ports\cpc\bin\level1\*.bin) do ..\utils\apack.exe "%%~pf%%~nf.bin" "%%~pf%%~nf.c.bin"  >nul

echo.
echo The Librarian!
echo ==============
..\utils\librarian_48.exe list=library_cpc.txt librarian=util\librarian.h library=assets\library_cpc.h pathprefix=..\ports\cpc\bin removebin
