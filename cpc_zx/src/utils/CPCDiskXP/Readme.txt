CPCDiskXP v2.5.1 - www.cpcmania.com

The program can be used by command line to facilitate the creation of Dsk's from a bat for those who make programs for the cpc...

Options:

-File BinaryName
Indicates the name of the binary to use

-AddAmsdosHeader MemoryAddressInHex
Optional to add to the file a Amsdos header

-AmsdosEntryAddress MemoryAddressInHex
Optional, if you omit this parameter and use -AddAmsdosHeader, EntryAddress value is the same as the used in -AddAmsdosHeader

-AddToExistingDsk DskFileName
Add the filename in "-File" to Dsk DskFileName. If the file already exists within the Dsk, is overwritten

-AddToNewDsk DskFileName
Optionally creates a Dsk, adding the binary in "-File"

-NewDskFormat FormatNumber
Optional, if we used "-AddToNewDsk", we indicate here the disc format you want, which defaults to 1
Values:
 1 "CPC DATA - Single Side - 40 Tracks - 64 Dir. Entries - 180K (178K Free)"
 2 "CPC DATA - Double Side - 40 Tracks - 64 Dir. Entries - 360K  (178K Free each side)"
 3 "CPC SYSTEM - Single Side - 40 Tracks - 64 Dir. Entries - 180K (169K Free)"
 4 "CPC SYSTEM - Double Side - 40 Tracks - 64 Dir. Entries - 360K  (169K Free each side)"
 5 "PARADOS 41 - Single Side - 41 Tracks - 64 Dir. Entries - 205K  (203K Free)"
 6 "PARADOS 40D - Double Side - 40 Tracks - 128 Dir. Entries - 400K  (396K Free)"
 7 "PARADOS 80 - Single Side - 80 Tracks - 128 Dir. Entries - 400K  (396K Free)"
 8 "ROMDOS D1 - Double Side - 80 Tracks - 128 Dir. Entries - 720K  (716K Free)"
 9 "ROMDOS D2 - Double Side - 80 Tracks - 256 Dir. Entries - 720K  (712K Free)"
10 "ROMDOS D10 - Double Side - 80 Tracks - 128 Dir. Entries - 800K  (796K Free)"
11 "ROMDOS D20 - Double Side - 80 Tracks - 256 Dir. Entries - 800K  (792K Free)"
13 "PCW/+3DOS - Single Side - 40 Tracks - 32 Dir. Entries - 200K (194K Free)"
14 "PCW/+3DOS - Double Side - 40 Tracks - 64 Dir. Entries - 400K (392K Free)"
15 "PCW/+3DOS - Double Side - 42 Tracks - 64 Dir. Entries - 420K (412K Free)"
16 "PCW/+3DOS - Double Side - 80 Tracks - 64 Dir. Entries - 720K (712K Free)"
17 "PCW/+3DOS - Double Side - 80 Tracks - 128 Dir. Entries - 800K (788K Free)"
18 "PCW/+3DOS - Double Side - 84 Tracks - 128 Dir. Entries - 840K (828K Free)"
19 "PCW/+3DOS - Double Side - 86 Tracks - 128 Dir. Entries - 860K (848K Free)"
20 "PCW/+3DOS - Double Side - 90 Tracks - 128 Dir. Entries - 900K (888K Free)"
21 "VORTEX - Double Side - 80 Tracks - 128 Dir. Entries - 720K  (704K Free)"
22 "IBM - Single Side - 40 Tracks - 64 Dir. Entries - 160K  (156K Free)"
23 "IBM - Single Side - 42 Tracks - 64 Dir. Entries - 168K  (162K Free"
24 "IBM - Single Side - 65 Tracks - 64 Dir. Entries - 260K  (254K Free)"
25 "CPC DATA - Single Side - 57 Tracks - 64 Dir. Entries - 256K (254K Free)"
26 "CPC SYSTEM - Single Side - 59 Tracks - 64 Dir. Entries - 265K (254K Free)"
27 "ROMDOS D1 - Double Side - 80 Tracks - 128 Dir. Entries - 720K  (716K Free) [USB Floppy]"


Examples:

-Add Amsdos header to a file (without Dsk):
CPCDiskXP -File Test.bin -AddAmsdosHeader 6000

-Add file to a new dsk:
CPCDiskXP -File Test.bin -AddToNewDsk Test.dsk


-Add Amsdos header to a file and add it to a new Dsk:
CPCDiskXP -File Test.bin -AddAmsdosHeader 6000 -AddToNewDsk Test.dsk

-Add file to a new file dsk, with format PARADOS 80:
CPCDiskXP -File Test.bin -AddToNewDsk Test.dsk -NewDskFormat 7

-Add file to an existing dsk:
CPCDiskXP -File Test.bin -AddToExistingDsk Test.dsk

