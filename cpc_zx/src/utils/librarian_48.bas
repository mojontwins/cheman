' librarian_48 v0.1
'' fbc librarian_48.bas cmdlineparser.bas

#include "cmdlineparser.bi"

' This program will generate a binaries.h which will include:
' - externs and INCBINs for all biaries in the list.
' - labels for all binaries in the list.
' - array of resources->addresses
' - librarian which will call the depacker

Sub usage
	Print "usage:"
	Print ""
	Print "librarian_48.exe in=list.txt librarian=librarian.h library=library.h"
	Print "                 [pathprefix=pathprefix] [removebin]"
	Print ""
	Print "* Will add files in list.txt to a resource library"
	Print "* if especified, pathprefix will be prepended to file paths in BINARYs"
	Print "* if especified, removebin will trim the _BIN from identifiers."
End Sub

Function MyReplace (Byval subject As String, find As String, replace As String) As String
	Dim As Integer it
	For it = 1 To Len (subject)
		If Mid (subject, it, 1) = find Then Mid (subject, it, 1) = replace
	Next it
	Return subject
End Function

Function procruste (subject As String, n As Integer) As String
	If Len (subject) < n Then
		subject = subject + Space (n - Len (subject))
	End If
	Return subject
End Function

Dim As Integer fIn, fOut, fL, i
Dim As String linea, ident
Dim As String idents (255)
Dim As Integer identsIdx
Dim As String mandatory (2) = {"list", "librarian", "library"}
Dim As String pathprefix
Dim As Integer removebin

Print "librarian_48 v0.1.20170630 ~ ";

'' Parse the command line

sclpParseAttrs
If Not sclpCheck (mandatory ()) Then usage: End

pathprefix = sclpGetValue ("pathprefix")
If pathprefix <> "" Then
	pathprefix = MyReplace (pathprefix, "\", "/")
	If Right (pathprefix, 1) <> "/" Then pathprefix = pathprefix & "/"
	Print "Using prefix " & pathprefix & " ~ ";
End If

removebin = (sclpGetValue ("removebin") <> "")

fIn = FreeFile
Open sclpGetValue ("list") For Input As #fIn
fL = FreeFile
Open sclpGetValue ("librarian") For Output As #fL
fOut = FreeFile
Open sclpGetValue ("library") For Output As #fOut

Print #fL, "// MTEZX MK3"
Print #fL, "// Copyleft 2017 by The Mojon Twins"
Print #fL, ""
Print #fL, "// librarian"
Print #fL, ""
Print #fL, "void librarian_get_resource (unsigned char rn, unsigned char *dst) {"
Print #fL, "	if (rn)"
Print #fL, "	#ifndef USE_EXOMIZER"
Print #fL, "		unpack (library [rn], dst);"
Print #fL, "	#else"
Print #fL, "		cpc_UnExo ((int *)(library [rn]), (int *)(dst));"
Print #fL, "	#endif"
Print #fL, "}"
Print #fL, ""

Print #fOut, "// MTEZX MK3"
Print #fOut, "// Copyleft 2017 by The Mojon Twins"
Print #fOut, ""
Print #fOut, "// library"
Print #fOut, ""

' Processing list
identsIdx = 1
Print "Processing " & sclpGetValue ("list") & " ~ ";
While Not Eof (fIn)
	Line Input #fIn, linea
	linea = MyReplace (Trim (linea), "\", "/")
	ident = linea
	If removebin Then
		If Len (ident) > 4 Then
			If Right (ident, 4) = ".bin" Then
				ident = Left (ident, Len (ident) - 4)
			End If
		End If
	End If
	ident = MyReplace (MyReplace (ident, "/", "_"), ".", "_")
	idents (identsIdx) = ident: identsIdx = identsIdx + 1

	Print #fOut, "extern const unsigned char " & ident & " [0];"
	Print #fOut, "#asm"
	Print #fOut, "	._" & ident
	Print #fOut, "		BINARY """ & pathprefix & linea & """"
	Print #fOut, "#endasm"
	Print #fOut, ""
Wend

Print #fOut, "const unsigned char * library [] = {"
Print #fOut, "	";
Print #fOut, "0,"
For i = 1 To identsIdx - 1
	Print #fOut, "	";
	Print #fOut, idents (i);
	If i < identsIdx - 1 Then Print #fOut, ", " Else Print #fOut, ""
Next i
Print #fOut, "};"
Print #fOut, ""

For i = 1 To identsIdx - 1
	Print #fOut, "#define " & UCASE (idents (i)) & " 0x" & Hex (i, 2)
Next i
Print #fOut, ""

Close
Print "DONE! " & identsIdx & " entries."
