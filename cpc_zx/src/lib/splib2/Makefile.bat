cd cwrapper
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

cd hashtable
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

cd heap
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

cd huffman
copy ..\SPconfig.def .
gencompile "zcc +zx -vn -make-lib -I.." sp_c.lst
del SPconfig.def
cd ..

z80asm -I. -d -ns -nm -Mo -DFORzx -xsplib2 @sp.lst

cd backgroundtiles
del *.o
cd ..

cd blockmemoryalloc
del *.o
cd ..

cd cwrapper
del *.o
cd ..

cd displaylist
del *.o
cd ..

cd globalvariables
del *.o
cd ..

cd hashtable
del *.o
cd ..

cd heap
del *.o
cd ..

cd huffman
del *.o
cd ..

cd input
del *.o
cd ..

cd interrupts
del *.o
cd ..

cd linkedlist
del *.o
cd ..

cd miscellaneous
del *.o
cd ..

cd screenaddress
del *.o
cd ..

cd sprites
del *.o
cd ..

cd updater
del *.o
cd ..
