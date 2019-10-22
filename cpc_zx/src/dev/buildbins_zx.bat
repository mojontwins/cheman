@echo off

mkdir ..\ports\zx\bin 2> nul
del ..\ports\zx\bin\*.bin /q /s > nul 2>  nul
del ..\ports\zx\bin\level0\*.bin /q /s > nul 2>  nul
del ..\ports\zx\bin\level0\*.h /q /s > nul 2>  nul
del ..\ports\zx\bin\level1\*.bin /q /s > nul 2>  nul
del ..\ports\zx\bin\level1\*.h /q /s > nul 2>  nul
del ..\ports\zx\bin\*.h /q /s > nul 2>  nul


echo.
echo Building binary assets
echo ======================

echo.
echo General assets
echo --------------
..\utils\mkts_om.exe platform=zx mode=sprites  in=..\ports\zx\gfx\ssch.png    out=..\ports\zx\bin\ssch      size=5,2  metasize=2,3 max=9 silent
..\utils\mkts_om.exe platform=zx mode=sprites  in=..\ports\zx\gfx\ssen.png    out=..\ports\zx\bin\ssen      size=6,1  metasize=2,3 silent
..\utils\mkts_om.exe platform=zx mode=sprites  in=..\ports\zx\gfx\sssmall.png out=..\ports\zx\bin\sssmall   size=1,1  metasize=1,1 silent
..\utils\mkts_om.exe platform=zx mode=sprites  in=..\ports\zx\gfx\ssextra.png out=..\ports\zx\bin\ssextra   size=2,1  metasize=2,3 silent
..\utils\mkts_om.exe platform=zx mode=sprites  in=..\ports\zx\gfx\pumpkin.png out=..\ports\zx\bin\sspumpkin size=1,1  metasize=2,2 silent

echo.
echo Fixed screens
echo -------------
..\utils\png2scr.exe ..\ports\zx\gfx\loading.png ..\ports\zx\bin\loading.bin > nul
..\utils\png2scr.exe ..\ports\zx\gfx\pre-loading.png ..\ports\zx\bin\pre-loading.bin > nul

echo.
echo Level 0 assets
echo --------------
mkdir ..\ports\zx\bin\level0 2> nul
del ..\ports\zx\bin\level0\*.bin /q /s > nul 2>  nul
del ..\ports\zx\bin\level0\*.h /q /s > nul 2>  nul
..\utils\rle53map_sp.exe in=..\map\level0.map out=..\ports\zx\bin\level0\ size=5,4 tlock=15 fixmappy nodecos noindex scrsize=16,12
..\utils\eneexp3b_sp.exe in=..\enems\level0.ene out=..\ports\zx\bin\level0\ yadjust=1 prefix=0 genallcounters
..\utils\list2bin.exe  ..\ports\zx\gfx\ts0.behs ..\ports\zx\bin\level0\behs.bin
..\utils\mkts_om.exe platform=zx mode=mapped in=..\ports\zx\gfx\ts0.png out=..\ports\zx\bin\level0\ts size=8,5 metasize=2,2 tmapoffs=83 max=36 defaultink=7 silent 

echo.
echo Level 1 assets
echo --------------
mkdir ..\ports\zx\bin\level1 2> nul
del ..\ports\zx\bin\level1\*.bin /q /s > nul 2>  nul
del ..\ports\zx\bin\level1\*.h /q /s > nul 2>  nul
..\utils\rle53map_sp.exe in=..\map\level1.map out=..\ports\zx\bin\level1\ size=4,5 tlock=15 nodecos noindex scrsize=16,12
..\utils\eneexp3b_sp.exe in=..\enems\level1.ene out=..\ports\zx\bin\level1\ yadjust=1 prefix=1 genallcounters
..\utils\list2bin.exe  ..\ports\zx\gfx\ts1.behs ..\ports\zx\bin\level1\behs.bin
..\utils\mkts_om.exe platform=zx mode=mapped in=..\ports\zx\gfx\ts1.png out=..\ports\zx\bin\level1\ts size=8,5 metasize=2,2 tmapoffs=83 max=36 defaultink=7 silent 

echo.
echo Creating main pattern set and level-based tilemaps
echo --------------------------------------------------
cd ..\ports\zx\gfx
..\..\..\utils\mkts_om.exe platform=zx mode=scripted in=ts.spt silent
cd ..\..\..\dev

echo.
echo Compressing some
echo ================
echo Level 0 assets
for %%f in (..\ports\zx\bin\level0\*.bin) do ..\utils\apack.exe "%%~pf%%~nf.bin" "%%~pf%%~nf.c.bin"  >nul
echo Level 1 assets
for %%f in (..\ports\zx\bin\level1\*.bin) do ..\utils\apack.exe "%%~pf%%~nf.bin" "%%~pf%%~nf.c.bin"  >nul

echo.
echo The Librarian!
echo ==============
..\utils\librarian_48.exe list=library_zx.txt librarian=util\librarian.h library=assets\library_speccy.h pathprefix=..\ports\zx\bin removebin
