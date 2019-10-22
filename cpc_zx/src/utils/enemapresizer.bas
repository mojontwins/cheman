Type EnemyIn
	t As uByte
	x As uByte
	y As uByte
	xx As uByte
	yy As uByte
	n As uByte
	s1 As uByte
	s2 As uByte
End Type

Type HotSpot
	x as uByte
	y as uByte
	t as uByte
End Type

Dim As EnemyIn enems (32,32,8)
Dim As EnemyIn emptyEnem
Dim As HotSpot hs (32,32)
Dim As uByte d, mapW, mapH, xt, yt, scrW, scrH, nEnems, xy
Dim As Integer i, iHi, iHf, iHs, iVi, iVf, iVs, index, x, y, xr, yr, w, h
Dim As String dummy

Dim As Integer x0, y0, outw, outh

If Command (6) = "" Then
	Print "enemapresizer in.ene out.ene x0 y0 w h [2bytes]"
	System
End If

x0 = Val (Command (3))
y0 = Val (Command (4))
w = Val (Command (5))
h = Val (Command (6))

' First read
Open Command (1) For Binary as #1

' Skip header
dummy = Input (256, 1)

' Read...
Get #1, , mapW
Get #1, , mapH

Get #1, , scrW
Get #1, , scrH
Get #1, , nEnems

' And get all the enemies
For y = 0 To mapH-1
	For x = 0 To mapW-1
		For i = 0 To nEnems-1
			Get #1, , enems (y, x, i).t
			Get #1, , enems (y, x, i).x
			Get #1, , enems (y, x, i).y
			Get #1, , enems (y, x, i).xx
			Get #1, , enems (y, x, i).yy
			Get #1, , enems (y, x, i).n
			Get #1, , enems (y, x, i).s1
			Get #1, , enems (y, x, i).s2
			'Print enems (y, x, i).t;" (";enems (y, x, i).x;",";enems (y, x, i).y;") - (";enems (y, x, i).xx;",";enems (y, x, i).yy;") ";enems (y, x, i).n;" ";enems (y, x, i).s1;enems (y, x, i).s2
Next i, x, y

' Hotspots
If Command (7) = "2bytes" Then
	For y = 0 To mapH-1
		For x = 0 To mapW-1
			Get #1, , xy
			hs (y, x).x = xy Shr 4
			hs (y, x).y = xy And 15
			Get #1, , hs (y, x).t
			'Print "" & hs (y, x).t & " "  & hs (y, x).x & " " & hs (y, x).y & ", ";
		Next x
		'Print
	Next y
Else
	For y = 0 To mapH-1
		For x = 0 To mapW-1
			Get #1, , hs (y, x).x
			Get #1, , hs (y, x).y
			Get #1, , hs (y, x).t
			'Print "" & hs (y, x).t & " "  & hs (y, x).x & " " & hs (y, x).y & ", ";
		Next x
		'Print
	Next y
End If

Close

' Resize.

Open Command (2) For Binary as #1
Put #1, , dummy
d = w: Put #1, , d
d = h: Put #1, , d

Put #1, , scrW
Put #1, , scrH
Put #1, , nEnems

' Enems
Print "" & mapW & "x" & mapH & " -> " & w & "x" & h & " @ " & x0 & "," & y0
For y = 0 To h - 1
	yR = y - y0
	Print "<" & y & "|" & yR & ">"
	For x = 0 To w - 1
		xR = x - x0
		Print "[" & x & "|" & xR & "] ";
		For i = 0 To nEnems - 1
			If yR >= 0 And yR < mapH And xR >= 0 And xR < mapW Then
				Put #1, , enems (yR, xR, i).t
				Put #1, , enems (yR, xR, i).x
				Put #1, , enems (yR, xR, i).y
				Put #1, , enems (yR, xR, i).xx
				Put #1, , enems (yR, xR, i).yy
				Put #1, , enems (yR, xR, i).n
				Put #1, , enems (yR, xR, i).s1
				Put #1, , enems (yR, xR, i).s2
				Print enems(yR,xR,i).t;" ";
			Else
				' Generate an empty screen
				d = 0
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Put #1, , d
				Print "X ";
			End If
		Next i
	Next x
	Print
Next y

' Hotspots
For y = 0 To h - 1
	yR = y - y0
	Print "<" & y & "|" & yR & ">"
	For x = 0 To w - 1
		xR = x - x0
		Print "[" & x & "|" & xR & "] ";
		If yR >= 0 And yR < mapH And xR >= 0 And xR < mapW Then
			Put #1, , hs (yR, xR).x
			Put #1, , hs (yR, xR).y
			Put #1, , hs (yR, xR).t
			Print hs (yR, xR).t;" ";
		Else
			d = 0
			Put #1, , d
			Put #1, , d
			Put #1, , d
			Print "X ";
		End If
	Next x
	Print
Next y

Close
