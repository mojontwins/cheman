' packmap_sp v0.1
' fbc packmap_sp.bas cmdlineparser.bas mtparser.bas

#include "cmdlineparser.bi"
#include "mtparser.bi"

Dim Shared As uByte mainBin (65535)
Dim Shared As Integer mainIndex

Sub usage 
	Print "usage:"
	Print ""
	Print "packmap_sp.exe in=map.map out=map.bin size=W,H [tlock=T] [noindex]"
	Print "               [scrsize=w,h] [fixmappy] [nodecos] [t0=N] [verbose]"
	Print "               in is the input filename."
	Print "               out is the output filename."
	Print "               size is the size, in screens."
	Print "               tlock is the tile representing locks/bolts"
	Print "               scrsize is the size of the screen in tiles. Default is 15x10"
	Print "               fixmappy will substract 1 from every byte read"
	Print "               nodecos will throw away any tile out of range i.o. generating decos"
	Print "               t0 defines # of 1st tile, default = 0"
	Print "               noindex will output all screens and produce no index"
End Sub

Sub mbWrite (v As uByte)
	mainBin (mainIndex) = v
	mainIndex = mainIndex + 1
End Sub

Function formatFileName (s As String) As String
	Dim As String res 

	res = s
	If Instr (res, ".bin") Then res = Left (res, Instr (res, ".bin") - 1)
	formatFileName = res
End Function

Function makeFileName (prefix As String, ext As String) As String
	Dim As String res

	res = prefix
	If Len (prefix) > 0 Then 
		If Right (prefix, 1) <> "/" And Right (prefix, 1) <> "\" Then res = res & "."
	End If
	res = res & ext
	makeFileName = res
End Function

Dim As String mandatory (2) = { "in", "out", "size" }
Dim As Integer coords (7), mapW, mapH, scrW, scrH, nPant, maxPants, mapWtiles, fixMappy, realPant
Dim As Integer fIn, fOut, xP, yP, x, y, i, j, tLock, locksI, n, cMapI, ctr, totalBytes, t0, lockssize, screensum
Dim As uByte BigMap (127, 255)
Dim As uByte cMap (127, 255), scrSizes (127)
Dim As String*512 cMapAmalgam (127)
Dim As uByte locks (63)
Dim As uByte d, dp
Dim As uByte scrMaps (127)
Dim As String fileName
Dim As Integer scrOffsets (127)
Dim As Integer mapSize
Dim As Integer verbose
Dim As Integer noindex

' decos
Dim As Integer decosAre, decosize
Dim As uByte decoT, decoCT
Dim As uByte decos (127, 127), decosYX (127, 127), YX (127), decosO (127, 127), decosI (127), decosOI (127)

Print "packmap_sp v0.1.20170707 ";

' Parse & check parameters

sclpParseAttrs
If Not sclpCheck (mandatory ()) Then usage: End

verbose = (sclpGetValue ("verbose") <> "")
noindex = (sclpGetValue ("noindex") <> "")

' Map size
parseCoordinatesString sclpGetValue ("size"), coords ()
mapW = coords (0): mapH = coords (1)
maxPants = mapW * mapH

' Screen size
If sclpGetValue ("scrsize") <> "" Then
	parseCoordinatesString sclpGetValue ("scrsize"), coords ()
	scrW = coords (0): scrH = coords (1)
Else 
	scrW = 15: scrH = 10
End If

' Map width in tiles
mapWtiles = mapW * scrW

' Lock detection
If sclpGetValue ("tlock") <> "" Then tLock = Val (sclpGetValue ("tlock")) Else tLock = -1

' Index of base tile
If sclpGetValue ("t0") <> "" Then t0 = Val (sclpGetValue ("t0")) Else t0 = 0

' Fix output filenames
fileName = formatFileName (sclpGetValue ("out"))

fIn = FreeFile
Open sclpGetValue ("in") For Binary As #fIn

Print "Reading ~ ";

fixMappy = (sclpGetValue ("fixmappy") <> ""): If fixMappy Then Print "[fixmappy] ";

i = 0: locksI = 0: dp = 0
While Not Eof (fIn)
	' Read from file
	Get #fIn, , d
	If fixMappy And d Then d = d - 1
	
	' Screen coordinates
	xP = (i \ scrW) Mod mapW
	yP = i \ (scrW * scrH * mapW)
	
	' Tile coordinates
	x = i Mod scrW
	y = (i \ mapWtiles) Mod scrH
	
	' screen number
	nPant = xp + yp * mapW

	' Next n
	i = i + 1

	' tlock?
	If d = tLock Then
		locks (locksI) = nPant: locksI = locksI + 1
		locks (locksI) = (y Shl 4) Or x: locksI = locksI + 1
	End if

	' Is d a decoration' 
	If d < t0 Or d > t0 + 31 Then
		If Not decosAre Then 
			Print "Found T(s) OOR ";
			If sclpGetValue ("nodecos") <> "" Then Print "(ignored) ~ "; Else Print "(decos) ~ ";
			decosAre = -1
		End If			
		' Write to decos
		decosYX (nPant, decosI (nPant)) = y * 16 + x
		decos (nPant, decosI (nPant)) = d
		decosI (nPant) = decosI (nPant) + 1
		' Reset to previous (so there's more repetitions)
		d = dp
	End If

	' Write
	BigMap (nPant, scrW * y + x) = d - t0
	dp = d
Wend

Print "Packing ~ ";: If verbose Then Print

totalBytes = 0
For nPant = 0 To maxPants - 1
	
	cMapAmalgam (nPant) = ""
	screensum = 0
	cMapI = 0
	For i = 0 To scrW*scrH-1 Step 2
		screensum = screensum + BigMap (nPant, i) + BigMap (nPant, i + 1)
		cMap (nPant, cMapI) = ((BigMap (nPant, i) And 15) Shl 4) Or (BigMap (nPant, i + 1) And 15)
		cMapAmalgam (nPant) = cMapAmalgam (nPant) & Hex (cMap (nPant, cMapI), 2)
		cMapI = cMapI + 1
	Next i

	'If verbose Then 
	''	Print "Screen " & nPant
	''	For i = 0 To cMapI-1
	''		Print Hex (cMap (nPant, i), 2) & "  ";
	''	Next i
	''	Print
	'End If

	realPant = nPant

	' Detect empty screen
	If screensum = 0 Then 
		realPant = 255: cMapI = 0
	Else
		' Search for repeated screens
		For j = 0 To nPant - 1
			If cMapAmalgam (j) = cMapAmalgam (nPant) Then
				realPant = j
				cMapI = 0
				Exit For
			End If
		Next j
	End If

	scrSizes (nPant) = cMapI
	scrMaps (nPant) = realPant '' Fixe here
	totalBytes = totalBytes + cMapI
Next nPant


Print "Generating map binary ~ ";

If noindex Then 
	mainIndex = 0

	For nPant = 0 To maxPants - 1
		For i = 0 To scrW*scrH\2 - 1
			If scrMaps (nPant) = 255 Then 
				mbWrite 0
			Else
				mbWrite cMap (nPant, i)
			End If
		Next i
	Next nPant
Else
	mainIndex = 2 * mapW * mapH

	For nPant = 0 To maxPants - 1
		If scrMaps (nPant) = 255 Then
			' skip empty screen
			mainBin (nPant * 2)     = 0
			mainBin (nPant * 2 + 1) = 0
		ElseIf scrSizes (nPant) Then
			' Write current offset to the index
			mainBin (nPant * 2)     = mainIndex And &HFF   ' LSB
			mainBin (nPant * 2 + 1) = mainIndex Shr 8      ' MSB

			scrOffsets (nPant) = mainIndex
			' Write current screen (which will advance mainIndex)
			if verbose Then Print nPant
			For i = 0 To scrSizes (nPant) - 1
				mbWrite cMap (nPant, i)
				if verbose Then Print Hex (cMap (nPant, i), 2);
			Next i
			If verbose Then Print "=" & scrSizes(nPant)
		Else
			' skip duplicated screen
			mainBin (nPant * 2)     = scrOffsets (scrMaps (nPant)) And &HFF
			mainBin (nPant * 2 + 1) = scrOffsets (scrMaps (nPant)) Shr 8
		End If
	Next nPant
End If

mapSize = mainIndex

Print "Writing ~ ";
fOut = FreeFile
Open makeFileName (fileName, "map.bin") For Binary As #fOut
For i = 0 To mainIndex - 1
	Put #fOut, , mainBin (i)
Next i
Close #fOut

' Decorations
decosize = 0
If sclpGetValue ("nodecos") = "" And decosAre Then
	Print "Writing decos ~ ";
	For nPant = 0 To maxPants - 1
		If decosI (nPant) Then
			For i = 0 To decosI (nPant) - 1
				decoT = decos (nPant, i)
				
				If decoT <> &Hff Then
					decoCT = 1
					YX (0) = decosYX (nPant, i)
					' Find more:
					For j = i + 1 To decosI (nPant) - 1
						If decos (nPant, i) = decos (nPant, j) Then
							' Found! DESTROY!
							YX (decoCT) = decosYX (nPant, j)
							decoCT = decoCT + 1
							decos (nPant, j) = &Hff
						End If
					Next j
					If decoCT = 1 Then
						' T | 128, YX
						decosO (nPant, decosOI (nPant)) = decoT Or 128: decosOI (nPant) = decosOI (nPant) + 1
						decosO (nPant, decosOI (nPant)) = YX (0): decosOI (nPant) = decosOI (nPant) + 1
					Else
						' T N YX YX YX YX...
						decosO (nPant, decosOI (nPant)) = decoT: decosOI (nPant) = decosOI (nPant) + 1
						decosO (nPant, decosOI (nPant)) = decoCT: decosOI (nPant) = decosOI (nPant) + 1
						For j = 0 To decoCT - 1
							decosO (nPant, decosOI (nPant)) = YX (j): decosOI (nPant) = decosOI (nPant) + 1
						Next j
					End If
				End If
			Next i
		End If
	Next nPant

	mainIndex = 2 * mapW * mapH

	For nPant = 0 To maxPants - 1
		If decosOI (nPant) Then
			mainBin (nPant * 2)     = mainIndex And &HFF   ' LSB
			mainBin (nPant * 2 + 1) = mainIndex Shr 8      ' MSB
			For i = 0 To decosOI (nPant) - 1
				mbWrite decosO (nPant, i)
			Next i
		Else
			mainBin (nPant * 2)     = 0
			mainBin (nPant * 2 + 1) = 0
		End If
	Next nPant

	decoSize = mainIndex

	fOut = FreeFile
	Open makeFileName (fileName, "decos.bin") For Binary As #fOut
	For i = 0 To mainIndex - 1
		Put #fOut, , mainBin (i)
	Next i
	Close #fOut
End If

' Write locks
lockssize = 0
If locksI Then
	fOut = FreeFile
	Open makeFileName (fileName, "locks.bin") For Binary As #fOut
	For i = 0 To locksI - 1
		d = locks (i): Put #fOut, , d
		lockssize = lockssize + 1
	Next i
End If

Print "DONE! M=" & mapSize & " D=" & decoSize & " L=" & lockssize 
