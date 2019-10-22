' list2bin v0.1
' Copyleft 2017 by The Mojon Twins

Sub usage
	Print "usage:"
	Print 
	Print "list2bin.exe list.txt list.bin"
	Print "Converts a comma-separated list of values to a binary file."
End Sub

Dim As Integer fIn, fOut
Dim As uByte d
Dim As Integer bytes

Print "list2bin v0.1.20170705 ~ ";

If Command (2) = "" Then usage: System

Print "converting ~ ";

fIn = FreeFile
Open Command (1) For Input As #fIn
fOut = FreeFile
Open Command (2) For Output As #fOut

bytes = 0
While Not Eof (fIn)
	Input #fIn, d
	Put #fOut, , d
	bytes = bytes + 1
Wend

Close
Print "DONE! B=" & bytes
