' General text parsing routines
' Copyleft 2016 The Mojon Twins

' I'm sick of cut'n'paste the same functions over and over.
' I should've done this long time ago.

#include "mtparser.bi"

Sub parseCoordinatesString (coordsString as String, coords () As Integer)
	Dim As Integer i, idx
	Dim As String m, coordString
	
	coordsString = coordsString & ","
	idx = 0
	
	For i = 1 To Len (coordsString)
		m = Mid (coordsString, i, 1)
		If m = "," Then
			coords (idx) = Val (coordString)
			idx = idx + 1
			coordString = ""			
		Else
			coordString = coordString & m
		End If
	Next i
End Sub

Sub parseTokenizeString (inString As String, tokens () As String, ignore As String, break As String)
	Dim As String m
	Dim As Integer i, l, windex, quotes

	l = uBound (tokens)
	For i = 0 To l
		tokens (i) = ""
	Next i

	inString = inString + " "
	l = Len (inString)
	windex = 0: quotes = 0
	For i = 1 To l 
		m = Mid (inString, i, 1)
		If quotes Then
			If m = Chr (34) Then 
				quotes = 0
			Else
				tokens (windex) = tokens (windex) & m 
			End If 
		Else 
			If Instr (break, m) Then
				Exit For
			'ElseIf Instr (ignore, m) Then
				' ignore
			ElseIf m = Chr (34) Then
				quotes = -1
			'ElseIf m = " " Then
			ElseIf m = " " Or Instr (ignore, m) Then
				If tokens (windex) <> "" Then 
					If windex < uBound (tokens) Then
						windex = windex + 1
					End If
				End If
			Else
				tokens (windex) = tokens (windex) & m 
			End If
		End If
	Next i
End Sub

Function parserFindTokenInTokens (token As String, tokens () As String, modifier As String) As Integer
	Dim As Integer found, i, l
	Dim As String curToken

	found = 0

	l = uBound (tokens)
	For i = 0 To l
		curToken = tokens (i)
		Select Case modifier
			case "ucase": curToken = uCase (curToken)
			case "lcase": curToken = lCase (curToken)
		End Select
		If curToken = token Then
			found = -1
			Exit For
		End If
	Next i

	parserFindTokenInTokens = found
End Function
