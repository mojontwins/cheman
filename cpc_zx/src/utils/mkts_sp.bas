' mkts_sp v0.1 - Converts graphics
' Copyleft 2017 The Mojon Twins

' fbc mkts_sp.bas cmdlineparser.bas mtparser.bas

' Todo: support unmasked sprites

#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#include "cmdlineparser.bi"
#include "mtparser.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Dim Shared As Integer silent, flipped, upsideDown, debug

Dim Shared As uByte mainBin (65535)
Dim Shared As uByte auxBin (65535)
Dim Shared As String cPool (255)
Dim Shared As uByte tMaps (255, 255)

Dim Shared As Integer mainIndex, auxIndex, cPoolIndex, tMapsIndex, defaultInk
Dim Shared As Integer outputPatterns
Dim Shared As Integer lastWmeta, lasthMeta

Sub fiPuts (s As String)
	If Not silent Then Puts s
End Sub

Sub usage
	Puts "Usage:"
	Puts ""
	Puts "$ mkts_sp.exe in=file.png out=output.bin mode=mode [offset=x,y] [size=w,h]"
	Puts "              [metasize=w,h] [tmapoffs=offset] [max=n] [silent] [defaultink=i]"
	Puts ""
	Puts "Supported modes: chars, mapped, sprites, bg, scripted"
	Puts "In scripted mode, parameter out will be ignored."
End Sub

Sub mbWrite (v As uByte)
	mainBin (mainIndex) = v
	mainIndex = mainIndex + 1
End Sub

Sub abWrite (v As uByte)
	auxBin (auxIndex) = v
	auxIndex = auxIndex + 1
End Sub

Function speccyColour (c As Integer) As Integer
	' Returns 0-7 (bright 0) or 9-15 (bright 1). Decode on target.
	Dim As Integer res, bright, r, g, b

	r = RGBA_R (c): g = RGBA_G (c): b = RGBA_B (c)

	bright = ((r > 224) Or (g > 224) Or (b > 224))
	If bright Then bright = 8

	res = bright
	If b >= 192 Then res = res + 1
	If r >= 192 Then res = res + 2
	If g >= 192 Then res = res + 4

	speccyColour = res
End Function

Function isBright (c As Integer) As Integer
	isBright = (c > 7)
End Function

Function getAttr (x0 As Integer, y0 As Integer, img As Any Ptr, ByRef c1 As Integer, ByRef c2 As Integer) As uByte
	Dim As uByte res
	Dim As Integer x, y

	c1 = speccyColour (Point (x0, y0, img))
	For y = 0 To 7
		For x = 0 To 7
			c2 = speccyColour (Point (x0 + x, y0 + y, img))
			If c2 <> c1 Then exit For
		Next x
		If c2 <> c1 Then Exit For
	Next y

	' If c2 = c1, complimentary paper
	If (c1 And 7) = (c2 And 7) Then 
		If defaultInk = -1 Then 
			If (c2 And 7) < 4 Then c1 = 7 Else c1 = 0
		Else
			c1 = defaultInk
		End If
	End If

	' Darker always paper
	If (c1 And 7) < (c2 And 7) Then Swap c1, c2

	res = (c1 And 7) Or ((c2 And 7) Shl 3)
	If isBright (c1) Or isBright (c2) Then res = res Or 64

	getAttr = res
End Function

Function getPaper (attr As uByte) As uByte
	getPaper = (attr Shr 3) And 7
End Function

Function getInk (attr As uByte) As uByte
	getInk = attr And 7
End Function

Function getBright (attr As uByte) As uByte
	getBright = (attr Shr 6) And 1
End Function

Function getBitmapFrom (x0 As Integer, y0 As Integer, c2 As Integer, img As Any Ptr) As uByte
	Dim As uByte res
	Dim As Integer x, c

	res = 0
	For x = 0 To 7
		c = speccyColour (Point (x + x0, y0, img))
		If c <> c2 Then res = res Or (1 Shl (7 - x))
	Next x

	getBitmapFrom = res
End Function

Sub extractPatternFrom (x0 As Integer, y0 As Integer, img As Any Ptr, pattern () As uByte, ByRef attr as uByte)
	Dim As Integer c1, c2
	Dim As Integer y

	attr = getAttr (x0, y0, img, c1, c2)
	If debug Then fiPuts "c1 = " & c1 & ", c2 = " & c2

	For y = 0 To 7
		pattern (y) = getBitmapFrom (x0, y + y0, c2, img)
	Next y
End Sub

Function patternToString (pattern () As uByte) As String
	Dim As String res
	Dim As Integer i 

	res = ""
	For i = 0 To uBound (pattern)
		res = res & Hex (pattern (i), 2)
	Next i

	patternToString = res
End Function

Sub addPatternToPool (patternS As String)
	cPool (cPoolIndex) = patternS
	cPoolIndex = cPoolIndex + 1
	outputPatterns = outputPatterns + 1
End Sub

Sub copyArrayToMainBin (array () As uByte)
	Dim As Integer i
	For i = lBound (array) To uBound (array)
		mbWrite array (i)
	Next i
End Sub

Function findPatternInPoolAndAdd (patternS As String, ByRef wasNew As Integer) As Integer
	Dim As Integer i

	wasNew = 0

	For i = 0 To cPoolIndex - 1
		If cPool (i) = patternS Then
			findPatternInPoolAndAdd = i
			Exit Function
		End If
	Next i

	wasNew = -1
	findPatternInPoolAndAdd = cPoolIndex
	addPatternToPool patternS
End Function

Sub zxDoChars (img As Any Ptr, xc0 As Integer, yc0 As Integer, w As Integer, h As Integer, max As Integer)
	Dim As Integer x, y, x0, y0, x1, y1, ct
	Dim As uByte attr 	' will be ignored in this Sub
	Dim As uByte pattern (7)

	x0 = xc0 * 8
	y0 = yc0 * 8
	x1 = x0 + w * 8 - 1
	y1 = x0 + h * 8 - 1
	ct = 0

	For y = y0 To y1 Step 8
		For x = x0 To x1 Step 8
			extractPatternFrom x, y, img, pattern (), attr
			addPatternToPool patternToString (pattern ())
			copyArrayToMainBin pattern ()
			ct = ct + 1
			If max <> -1 And ct = max Then Exit For
		Next x
		If max <> -1 And ct = max Then Exit For
	Next y

	Puts "- Chars mode, " & ct & " patterns extracted (" & (ct * 8) & " bytes)."
End Sub

Sub zxDoTmaps (img As Any Ptr, xc0 As Integer, yc0 As Integer, w As Integer, h As Integer, wMeta As Integer, hMeta As Integer, max As Integer)
	Dim As Integer x, y, x0, y0, x1, y1, ct, ctTmaps, xa, ya
	Dim As Integer xx, yy
	Dim As uByte attr 	' will be ignored in this Sub
	Dim As uByte pattern (7)
	Dim As Integer cTMapIndex
	Dim As Integer wasNew, pIndex

	lastwMeta = wMeta
	lasthMeta = hMeta

	x0 = xc0 * 8
	y0 = yc0 * 8
	x1 = x0 + w * wMeta * 8 - 1
	y1 = x0 + h * hMeta * 8 - 1
	ct = 0
	tMapsIndex = 0
	ctTmaps = 0
	
	For y = y0 To y1 Step 8 * wMeta
		For x = x0 To x1 Step 8 * hMeta
			
			' Read chars in current metatile
			cTMapIndex = 0
			ya = y
			For yy = 0 To hMeta - 1
				xa = x
				For xx = 0 To wMeta - 1
					extractPatternFrom xa, ya, img, pattern (), attr
					pIndex = findPatternInPoolAndAdd (patternToString (pattern ()), wasNew)
					If wasNew Then copyArrayToMainBin pattern (): ct = ct + 1

					' Add to current tmap
					tMaps (tMapsIndex, cTMapIndex) = attr: cTMapIndex = cTMapIndex + 1
					tMaps (tMapsIndex, cTMapIndex) = pIndex: cTMapIndex = cTMapIndex + 1

					xa = xa + 8
				Next xx

				ya = ya + 8
			Next yy

			tMapsIndex = tMapsIndex + 1: ctTmaps = ctTmaps + 1
		Next x
	Next y

	Puts "- Tmaps mode, " & ct & " patterns extracted (" & (ct * 8) & " bytes) from " & ctTmaps & " metatiles (" & (ctTmaps * 2 * wMeta * hMeta) & " bytes)."
End Sub

Sub zxDoSprites (img As Any Ptr, xc0 As Integer, yc0 As Integer, w As Integer, h As Integer, wMeta As Integer, hMeta As Integer, max As Integer)
	Dim As Integer x, y, x0, y0, x1, y1, ct, ctTmaps, xa, ya, i
	Dim As Integer xx, yy
	Dim As uByte attr 	' will be ignored in this Sub
	Dim As uByte pattern (7)
	Dim As Integer cTMapIndex
	Dim As Integer wasNew, pIndex
	Dim As Integer wMetaPixels, hMetaPixels

	' Still only masked sprites
	' Note that "zero" colour must be pitch black!

	x0 = xc0 * 8
	y0 = yc0 * 8
	wMetaPixels = wMeta * 8
	hMetaPixels = hMeta * 8
	x1 = x0 + w * wMetaPixels * 2 - 1
	y1 = x0 + h * hMetaPixels - 1
	ct = 0

	For y = y0 To y1 Step hMetaPixels
		For x = x0 To x1 Step wMetaPixels * 2

			' wMeta + 1 columns. The last will be empty
			xa = x
			For xx = 0 To wMeta
				If xx < wMeta Then
					' hMetaPixels sprite lines
					For yy = 0 To hMetaPixels - 1
						' Graphic 
						mbWrite getBitmapFrom (xa, y + yy, 0, img)
						' Mask is 16 pixels appart
						mbWrite getBitmapFrom (xa + wMetaPixels, y + yy, 0, img)
					Next yy
				Else
					' hMetaPixels empty lines for the last column
					For i = 0 To hMetaPixels - 1
						mbWrite 0: mbWrite 255
					Next i
				End If

				' 8 empty lines
				For i = 0 To 7
					mbWrite 0: mbWrite 255
				Next i

				xa = xa + 8
			Next xx

			ct = ct + 1
		Next x
	Next y

	Puts "- Sprites mode, " & ct & " " & wMetaPixels & "x" & hMetaPixels & " sprite cells with masks extracted (" & (mainIndex) & " bytes)."
End Sub

Sub zxDoBg (img As Any Ptr, xc0 As Integer, yc0 As Integer, w As Integer, h As Integer)
	Dim As Integer x, y, x0, y0, x1, y1, i
	Dim As uByte pattern (7)
	Dim As uByte attr, pIndex
	Dim As Integer wasNew, ct
	Dim As Integer baseIndex, patternTableSize

	x0 = xc0 * 8
	y0 = yc0 * 8
	x1 = x0 + w * 8 - 1
	y1 = y0 + h * 8 - 1

	auxIndex = 0
	baseIndex = mainIndex: mainIndex = mainIndex + 2
	ct = 0

	For y = y0 To y1 Step 8
		For x = x0 To x1 Step 8
			extractPatternFrom x, y, img, pattern (), attr
			pIndex = findPatternInPoolAndAdd (patternToString (pattern ()), wasNew)
			If wasNew Then copyArrayToMainBin pattern (): ct = ct + 1
		
			abWrite attr
			abWrite pIndex
		Next x
	Next y

	' Write size to main Binary
	patternTableSize = mainIndex - baseIndex
	mainBin (baseIndex) = patternTableSize And &HFF
	mainBin (baseIndex + 1) = patternTableSize Shr 8

	' Copy nametable to main binary
	For i = 1 To auxIndex - 1 Step 2
		mbWrite auxBin (i)
	Next i
	For i = 0 To auxIndex - 2 Step 2
		mbWrite auxBin (i)
	Next i

	Puts "- BG mode, " & ct & " patterns (" & (8*ct) & " bytes). NT is " & auxIndex & " bytes."
End Sub

Function writeBin (fOut As Integer, binArray () As uByte, binOffs As Integer, bytes As Integer) As Integer
	Dim As Integer i, upperBound
	upperBound = binOffs + bytes - 1
	If upperBound > uBound (binArray) Then upperBound = uBound (binArray)

	fiPuts "Writing " & bytes & " bytes to output."
	For i = binOffs To upperBound 
		Put #fOut, , binArray (i)
	Next i

	writeBin = upperBound - binOffs + 1
End Function

Sub writeFullBinary (fileName As String)
	Dim As Integer fOut
	Dim As Integer bytes

	fiPuts "Opening " & fileName & " for output."
	Kill fileName
	fOut = FreeFile
	Open fileName For Binary As #fOut
	bytes = writeBin (fOut, mainBin (), 0, mainIndex)
	Close #fOut
	fiPuts "+ " & bytes & " bytes written"
End Sub

Sub writeTsmaps (fileName As String)
	Dim As Integer fOut
	Dim As Integer bytes
	Dim As Integer i, j
	Dim As uByte d

	fiPuts "Opening " & fileName & " for output."
	Kill fileName
	fOut = FreeFile
	Open fileName For Binary As #fOut
	bytes = 0
	For i = 0 To tMapsIndex - 1
		For j = 0 To lastwMeta * lasthMeta * 2 - 1
			bytes = bytes + 1
			d = tMaps (i, j): Put #fOut, , d
		Next j
	Next i				
	Close #fOut
	fiPuts "+ " & bytes & " bytes written"
End Sub

Sub zxDoScripted (scriptFile As String)
	Dim As Integer fIn
	Dim As String lineIn
	Dim As String tokens (31)
	Dim As Integer xc0, yc0, w, h, wMeta, hMeta, max, imgOn
	Dim As Integer wIn, hIn
	Dim As Any Ptr img

	imgOn = 0
	fiPuts "Executing script " & scriptFile

	fIn = FreeFile
	Open scriptFile For Input As #fIn
	While Not Eof (fIn)
		Do
			Line Input #fIn, lineIn
			lineIn = Trim (lineIn, Any Chr (9) + Chr (32))
		Loop While Not Eof (fIn) And lineIn = ""
		parseTokenizeString lineIn, tokens (), ",;" & Chr (9), "#"

		Select Case Lcase (tokens (0))
			Case "defaultink"
				defaultInk = Val (tokens (1))

			Case "open"
				fiPuts "Reading input file " & tokens (1)
				If imgOn Then ImageDestroy img
				img = png_load (tokens (1))
				imgOn = -1

				If ImageInfo (img, wIn, hIn, , , , ) Then
					fiPuts "There was an error reading input file. Shitty png?": End
				End If

			Case "output"
				If tokens (1) = "patterns" Then writeFullBinary tokens (2)
				If tokens (1) = "tmaps" Then writeTsmaps tokens (2)

			Case "reset"
				If tokens (1) = "patterns" Then mainIndex = 0
				If tokens (1) = "tmaps" Then tMapsIndex = 0

			Case "fillto"
				While mainIndex < Val (tokens (1))
					mbWrite 0
				Wend

			Case "spriteset"
				xc0 = Val (tokens (1))
				yc0 = Val (tokens (2))
				w = Val (tokens (3))
				h = Val (tokens (4))
				wMeta = Val (tokens (5))
				hMeta = Val (tokens (6))
				max = Val (tokens (7)): If max = 0 Then max = -1

				zxDoSprites img, xc0, yc0, w, h, wMeta, hMeta, max

			Case "metatileset"
				xc0 = Val (tokens (1))
				yc0 = Val (tokens (2))
				w = Val (tokens (3))
				h = Val (tokens (4))
				wMeta = Val (tokens (5))
				hMeta = Val (tokens (6))
				max = Val (tokens (7)): If max = 0 Then max = -1
				
				zxDoTmaps img, xc0, yc0, w, h, wMeta, hMeta, max

			Case "charset"
				xc0 = Val (tokens (1))
				yc0 = Val (tokens (2))
				w = Val (tokens (3))
				h = Val (tokens (4))
				max = Val (tokens (7)): If max = 0 Then max = -1
				
				zxDoChars img, xc0, yc0, w, h, max

			Case "patternoffset"
				cPoolIndex = Val (tokens (1))

			Case "stats"
				Puts "stats: " & (mainIndex\8) & " patterns in pool (" & mainIndex & " bytes)"

		End Select
	Wend

	If imgOn Then ImageDestroy img
				
End Sub

Dim As String mandatory (2) => { "in", "out", "mode" }
Dim As String mandatoryScripted (1) => { "in", "mode" }
Dim As Integer xc0, yc0, w, h, wMeta, hMeta, max, i, j
Dim As Integer coords (9)
Dim As Integer wIn, hIn
Dim As String outputBaseFn, fileName
Dim As Integer fOut, bytes
Dim As Any Ptr img
Dim As uByte d

sclpParseAttrs
cPoolIndex = 0

' Extra params.

flipped = (sclpGetValue ("genflipped") <> "")
silent = (sclpGetValue ("silent") <> "")
debug = (sclpGetValue ("debug") <> "")

' Hello
fiPuts "mkts_sp v0.1.20170629"

' Mandatory params
If sclpGetValue ("mode") = "scripted" Then
	If Not sclpCheck (mandatoryScripted ()) Then usage: End
Else
	If Not sclpCheck (mandatory ()) Then usage: End
End If

' We need to read the input image at this point
screenres 640, 480, 32, , -1

If sclpGetValue ("mode") <> "scripted" Then
	fiPuts "Reading input file " & sclpGetValue ("in")
	img = png_load (sclpGetValue ("in"))

	If ImageInfo (img, wIn, hIn, , , , ) Then
		fiPuts "There was an error reading input file. Shitty png?": End
	End If
End If

' offset
If sclpGetValue ("offset") <> "" Then
	parseCoordinatesString sclpGetValue ("offset"), coords ()
	xc0 = coords (0): yc0 = coords (1)
Else
	xc0 = 0: yc0 = 0
End If

' metasize
If sclpGetValue ("mode") = "chars" Then
	wMeta = 1: hMeta = 1
Else
	If sclpGetValue ("metasize") <> ""Then
		parseCoordinatesString sclpGetValue ("metasize"), coords ()
		wMeta = coords (0): hMeta = coords (0)
	Else
		wMeta = 2: hMeta = 2
	End If
End If

' size
If sclpGetValue ("size") <> "" Then
	parseCoordinatesString sclpGetValue ("size"), coords ()
	w = coords (0): h = coords (1)
Else
	w = wIn \ (wMeta * 8): h = hIn \ (hMeta * 8)
End If

' tmapoffs
cPoolIndex = Val (sclpGetValue ("tmapoffs"))

' max
max = Val (sclpGetValue ("max")): If max < 1 Then max = -1	' Which means no limit

' default Ink
If sclpGetValue ("defaultink") <> "" Then 
	defaultInk = Val (sclpGetValue ("defaultink"))
Else
	defaultInk = -1
End If

' Fix output
outputBaseFn = sclpGetValue ("out")
If Instr (outputBaseFn, ".bin") Then outputBaseFn = Left (outputBaseFn, Instr (outputBaseFn, ".bin") - 1)

' And do.

Select Case sclpGetValue ("mode")
	Case "chars"
		zxDoChars img, xc0, yc0, w, h, max
		writeFullBinary outputBaseFn & ".bin"
		ImageDestroy img

	Case "mapped"
		zxDoTmaps img, xc0, yc0, w, h, wMeta, hMeta, max
		writeFullBinary outputBaseFn & ".patterns.bin"
		writeTsmaps outputBaseFn & ".tilemaps.bin" 
		ImageDestroy img

	Case "sprites"
		zxDoSprites img, xc0, yc0, w, h, wMeta, hMeta, max
		writeFullBinary outputBaseFn & ".bin"
		ImageDestroy img

	Case "bg"
		zxDoBg img, xc0, yc0, w, h
		writeFullBinary outputBaseFn & ".bin"
		ImageDestroy img

	Case "scripted"
		zxDoScripted sclpGetValue ("in")

End Select
				
fiPuts "DONE"

