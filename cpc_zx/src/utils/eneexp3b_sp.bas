' eneexp3b_sp v0.1
' fbc eneexp3b_sp.bas cmdlineparser.bas

#include "cmdlineparser.bi"

Dim Shared As uByte mainBin (65535)
Dim Shared As Integer mainIndex

Sub usage
	Print "usage:"
	Print ""
	print "$ eneexp3b_sp.exe in=enems.ene out=out.bin prefix=prefix [yadjust=t] [nohotspots]"
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

Dim As String mandatory (1) = { "in", "out" }
Dim As Integer fIn, fOut, ctrr
Dim As uByte d, a, b
Dim As String Dummy, prefix, fileName
Dim As Integer mapW, mapH, nEnems, mapPants, nPant, i, j, hl, yadjust, noHotspots
Dim As uByte t, xy1, xy2, mn
Dim As Integer typeCounters (255)
Dim As Integer enTypeCounters (255)
Dim As uByte miniBin (255)
Dim As Integer miniBinIdx
Dim As Integer screenOn (255)
Dim As Integer totalBytes
Dim As Integer genallcounters

Print "eneexp3b_sp v0.1.20170630 ";

'' Parse the command line

sclpParseAttrs
If Not sclpCheck (mandatory ()) Then usage: End

yadjust = Val (sclpGetValue ("yadjust"))
noHotspots = Val (SclpGetValue ("nohotspots"))
fileName = formatFileName (sclpGetValue ("out"))
prefix = sclpGetValue ("prefix")
genallcounters = (sclpGetValue ("genallcounters")<>"")

' Outputs 4 bytes per entry
' T for type
' XY for ini
' XY for end
' MN for properties
' T = 0xff means end marker for current screen!

' Then generates an index.

' .ENE contains...
' t x1 y1 x2 y2 n s1 s2
' n is speed
' s1, s2 are unused.

fIn = FreeFile
Open sclpGetValue ("in") For Binary As #fIn

Print "Reading ~ ";

' Header
dummy = Input (256, fIn)
Get #fIn, , d: mapW = d
Get #fIn, , d: mapH = d
Get #fIn, , d: Get #fIn, , d
Get #fIn, , d: nEnems = d

mapPants = mapW * mapH

' Read pants, store current, write back.

Print "Writing ~ ";

For i = 1 To mapPants
	ctrr = 0
	For j = 1 to nEnems
		Get #fIn, , t
		Get #fIn, , a: Get #fIn, , b: If t <> 0 Then b = b + yadjust
		xy1 = (b Shl 4) Or (a And 15)
		Get #fIn, , a: Get #fIn, , b: If t <> 0 Then b = b + yadjust
		xy2 = (b Shl 4) Or (a And 15)
		Get #fIn, , mn
		Get #fIn, , d: Get #fIn, , d

		' t == 0 means no enemy defined
		If t Then
			If genallcounters Then
				enTypeCounters (t) = enTypeCounters (t) + 1
			Else
				enTypeCounters (t And &HF0) = enTypeCounters (t And &HF0) + 1
			End If
		End If

		mbWrite t
		mbWrite xy1
		mbWrite xy2
		mbWrite mn		
	Next j

Next i

'' Write
Print "Writing enems ~ ";
fOut = FreeFile
Open makeFileName (fileName, "enems.bin") For Binary As #fOut
For i = 0 To mainIndex - 1
	Put #fOut, , mainBin (i)
Next i
Close #fOut

fOut = FreeFile
Open makeFileName (fileName, "enems.h") For Output As #fOut
Print #fOut, "// Enemy type counter for " & sclpGetValue ("in")
Print #fOut, ""
For i = 1 To 255
	If enTypeCounters (i) Then Print #fOut, "#define MAX_ENEMS_" & Ucase (prefix) & "_TYPE_" & Ucase (Hex (i, 2)) & "	" & enTypeCounters (i)
next i
Print #fOut, ""
Close #fOut

If Not noHotspots Then
	Print "Writing hotspots ~ ";

	Open makeFileName (fileName, "hotspots.bin") For Binary As #fOut	
	For i = 1 To mapPants
		Get #fIn, , xy1
		Get #fIn, , xy2: xy2 = xy2 + yadjust
		xy1 = (xy2 Shl 4) Or (xy1 And 15)
		Get #fIn, , t: If t = 0 Then xy1 = 0: xy2 = 0
		
		Put #fOut, , t: Put #fOut, , xy1

		typeCounters (t) = typeCounters (t) + 1
	Next i
	Close #fOut

	Open makeFileName (fileName, "hotspots.h") For Output As #fOut
	Print #fOut, "// Hotspots type counter for " & sclpGetValue ("in")
	Print #fOut, ""

	For i = 0 To 255
		If typeCounters (i) <> 0 then
			Print #fOut, "#define MAX_HOTSPOTS_" & Ucase (prefix) & "_TYPE_" & i & "	" & typeCounters (i)	
		End If
	Next i
	Close #fOut
End If

Close #fIn

Print "DONE! E=" & (mainIndex) & "," &(mapPants *2)
