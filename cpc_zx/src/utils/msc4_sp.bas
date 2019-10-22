' Nuevo compilador MojonTwins Script Compiler
' MT MK3 ZX v0.1+
' Copyleft 2017 The Mojon Twins

#include "cmdlineparser.bi"
#include "mtparser.bi"

' fbc msc4nes.bas cmdllineparser.bas mtparser.bas

Const LIST_WORDS_SIZE = 128
Const LIST_ALIAS_SIZE = 255
Const MACRO_SIZE = 32
Const MAX_MACROS = 31

Dim Shared As Integer rampage

Redim Shared As String script (0)
Redim Shared As Integer addresses (0)
Dim Shared As Integer clausulasUsed (255)
Dim Shared As Integer actionsUsed (255)
Dim Shared As uByte myBin (16383)
Dim Shared As uByte outBin (16383)
Dim Shared As Integer outBinIndex
Dim As uInteger maxClausuleSize
Dim Shared lP (LIST_WORDS_SIZE) As String
Dim Shared listaAlias (LIST_ALIAS_SIZE) As String
Dim Shared decoInclude As String
Dim Shared As Integer doIncludeDecos, decoFetch
Dim Shared As Byte decorated (255)
Dim Shared As Integer maxScr
Dim Shared As String macros (MAX_MACROS, MACRO_SIZE)
Dim Shared As Integer macrosPtr
Dim Shared As Integer mapadjust
Dim Shared As String thisLevelConstantName
Dim Shared As Integer lineNo

' Items
Dim Shared As Integer maxItem
Dim Shared As Integer itemSetx, itemSety, itemSetStep, itemSetOr, itemFlag, slotFlag
Dim Shared As Integer itemSelectClr, itemSelectC1, itemSelectC2, itemEmpty

maxClausuleSize = 0
itemEmpty = -1

Sub mbWrite (b As uByte)
	outBin (outBinIndex) = b 
	If outBinIndex < 16383 Then outBinIndex = outBinIndex + 1
End Sub

Sub resetScript (n as Integer)
	Dim as integer i
	For i = 0 to n
		script (i) = ""
	next i
	For i = 0 to 16383
		myBin (i) = 0
	Next i
End Sub

Sub stringToArray (in As String)
	Dim As Integer m, index, i1, i2, found, i, j
	Dim As String character, curWord
	
	For m = 0 To LIST_WORDS_SIZE: lP (m) = "": Next m
	in = Trim (in): If in = "" Then Exit Sub
		
	index = 0: curWord = "": in = in + " "
	
	For m = 1 To Len (in)
		character = Ucase (Mid (in, m, 1))
		If Instr (" " & Chr (9) & ",<=>;()", character) Then
			If curWord <> "" Then
				' Macro insertion
				If Left (curWord, 1) = "%" Then
					' Attempt to find macro
					found = 0
					For i1 = 0 TO MAX_MACROS
						If curWord = macros (i1, 0) Then
							For i2 = 1 TO MACRO_SIZE
								If macros (i1, i2) <> "" Then
									lP (index) = macros (i1, i2)			
									index = index + 1
									IF index >= LIST_WORDS_SIZE Then Exit For
								End If
							Next i2
							found = -1
							Exit For
						End If
					Next i1
					If Not found Then
						lP (index) = curWord
						index = index + 1
						If index >= LIST_WORDS_SIZE Then Exit For
					End If
				Else
					lP (index) = curWord
					index = index + 1
					If index >= LIST_WORDS_SIZE Then Exit For
				End If
				curWord = ""
			End If
			If Instr (" " & Chr (9), character) = 0 Then
				lP (index) = character
				index = index + 1
				If index >= LIST_WORDS_SIZE Then Exit For
			End If
		Else
			curWord = curWord & character
		End If
	Next m
	'for m = 0 to index:Print lP (m); " ";:next m: Print

	' Fix <>, !=

	For i = 0 To index - 1
		If (lP (i) = "<" And lP (i+1) = ">") Or (lP (i) = "!" And lP (i+1) = "=") Then
			lP (i) = lP (i) & lP (i+1)
			For j = i + 1 to index - 1
				lP (j) = lP (j + 1)
			Next j
			index = index + 1
		End If
	Next i
End Sub

Function pval (s as string) as integer
	Dim res as integer
	Dim i as integer
	' Patch
	If s = "SLOT_SELECTED" then
		pval = 128 + slotFlag
	elseif s = "ITEM_SELECTED" then
		pval = 128 + itemFlag
	Else
		If (left(s, 1) = "#") Then
			'? "CALL TO GET VALUE OF " & right (s, len(s) - 1)
			res = 128 + pval (right (s, len(s) - 1))
			'? "WHICH WAS " & (res - 128)
		ElseIf (left (s, 1) = "$") Then
			res = 0
			For i = 0 To LIST_ALIAS_SIZE
				If s = listaAlias (i) Then res = i: Exit For
			Next i
			'? "ALIAS: " & s & " VALUE:" & res
		Else
			res = val (s)
		End If
		pval = res
	End If
end function

Sub ProcesaItems (f As Integer)
	Dim terminado As Integer
	Dim linea As String
	terminado = 0
	While Not terminado
		Line input #f, linea
		lineNo = lineNo + 1
		linea = Trim (linea, Any chr (32) + chr (9))
		stringToArray (linea)
		Select Case Ucase (lP (0))
			Case "SLOT_FLAG":
				slotFlag = val (lP (1))
			Case "ITEM_FLAG":
				itemFlag = val (lP (1))
			Case "LOCATION":
				itemSetX = val (lP (1))
				itemSetY = val (lP (3))
			Case "DISPOSITION":
				itemSetStep = val (lP (3))
				If lP (1) = "HORZ" then itemSetOr = 0 Else ItemSetOr = 1
			Case "SELECTOR":
				itemSelectClr = val (lP (1))
				itemSelectC1 = val (lP (3))
				itemSelectC2 = val (lP (5))
			Case "EMPTY":
				itemEmpty = val (lP (1))
			Case "SIZE":
				maxItem = val (lP (1))
			Case "END":
				terminado = Not 0
		End Select
		If eof (f) Then terminado = Not 0
	Wend
End Sub

Sub addAlias (nameA As String, flag As Integer)
	listaAlias (flag) = nameA
	'? "Adding " & flag & " = " & nameA
End Sub

Sub AddMacro ()
	' Macro name is lP (0)
	' Macro is from lP (1) onwards (MACRO_SIZE words)
	Dim As Integer i
	For i = 0 To MACRO_SIZE
		macros (macrosPtr, i) = lP (i)
	Next i
	If macrosPtr < MAX_MACROS Then macrosPtr = macrosPtr + 1 Else Print "** WARNING ** MAX_MACROS reached! Next will overwrite last."
End Sub

Sub ProcesaAlias (f As Integer)
	Dim terminado As Integer
	Dim linea As String
	terminado = 0
	While Not terminado
		Line input #f, linea
		lineNo = lineNo + 1
		linea = Trim (linea, Any chr (32) + chr (9))
		stringToArray (linea)
		If lP (0) = "END" Then terminado = Not 0
		If Left (lP (0), 1) = "$" Then
			AddAlias lP (0), pval (lP (1))
		ElseIf Left (lP (0), 1) = "%" Then
			AddMacro
		End If
		If eof (f) Then terminado = Not 0
	Wend
End Sub

Sub autoExpandFlags ()
	Dim As Integer irw, didsm, jrw
	' Esta función auto-expande "#X" por "FLAG X" en el primer parámetro
	' vale para no tener que poner "SET FLAG $HOLA = 1" y poder poner "SET $HOLA = 1"
	' que me parece un poco menos coñazo y, endehe luego, más legible.
	
	' En cualquier caso está en LP 1, y al detectarla hay que echar lo demás una casilla "pátrás" 
	' y meter flag en LP 1 y el valor en LP 2.
	
	' ¿Cuántos echar p'atrás? Pongamos que 10, cubrirá esto mucho rato hasta que casque y
	' yo me tire 2 horas preguntándome por qué.
	
	' Pêro para no variar la CALIDAZZ de este códigow.
	
	'If Len (lP (1)) > 1 Then
	''	If Left (lP (1), 1) = "$" Then
	''		For irw = 10 to 2 Step -1
	''			lP (irw) = lP (irw - 1)
	''		Next irw
	''		lP (1) = "FLAG"
	''	End If
	'End If	

	' Hecho de nuevo. Ahora es más general y sustituye en más sitios
	Do
		didsm = 0
		For irw = 1 To 15
			If Left (lP (irw), 1) = "$" Then
				If lP (irw - 1) <> "FLAG" Then
					For jrw = 15 to irw + 1 Step -1
						lP (jrw) = lP (jrw - 1)
					Next jrw
					lP (irw) = "FLAG"
					didsm = -1
				End If
			End If
		Next irw
	Loop While didsm
End Sub

Function procesaClausulas (f As integer) As String
	' Lee cláusulas de la pantalla nPant del archivo abierto f
	Dim linea As String
	Dim sc_terminado As Integer
	Dim estado As integer
	Dim clausulas As String
	Dim clausula As String
	Dim numclausulas As Integer
	Dim longitud As Integer
	Dim ai As Integer
	Dim itt As Integer
	
	Dim As Integer fzx1, fzx2, fzy1, fzy2, i

	Dim As Integer dF

	sc_terminado = 0
	estado = 0
	numclausulas = 0
	longitud = 0
	clausulas = ""

	'' ===========================================================================
	' Decorations?
	If doIncludeDecos Then
		' Abrimos el archivo
		dF = FreeFile
		Open decoInclude For Input as #dF
			' Buscamos la pantalla en cuestión

			While Not sc_terminado And Not Eof (dF)
				Line input #dF, linea
				linea = Trim (linea, Any chr (32) + chr (9))
				If linea <> "" Then
					stringToArray (linea)
					If lP (0) = "ENTERING" and val (lP (2)) = decoFetch Then
						estado = 1
						sc_terminado = Not 0
					End If
				End If
			Wend

			If estado = 1 Then
				? "Including custom decorations for screen " & decoFetch

				' Creamos una nueva clausula IF TRUE
				clausula = chr (&HF0)
				clausulasUsed (&HF0) = -1

				' Then
				clausula = clausula + Chr (255)

				' Ahora buscamos la sección DECORATIONS
				sc_terminado = 0
				While Not sc_terminado And Not Eof (dF)
					Line input #dF, linea
					linea = Trim (linea, Any chr (32) + chr (9))
					stringToArray (linea)

					If lP(0) = "DECORATIONS" Then
						' parsear e incluir una lista de prints.
						clausula = clausula + Chr (&HF4)
						actionsUsed (&HF4) = -1

						do
							Line input #dF, linea
							linea = Trim (linea, Any chr (32) + chr (9))
							If ucase (linea)="END" then sc_terminado = -1: exit do
							stringToArray (linea)
							' X,Y,T -> XY T
							clausula = clausula + Chr ((Val(lP(0)) Shl 4) + (Val(lP(2)) And 15)) + Chr (Val(lP(4)))
						loop

						' END del decorations
						clausula = clausula + Chr (&HFF)
					End If
				Wend

				' End de la cláusula
				clausula = clausula + Chr (&HFF)

				' Añadimos la longitud de la cláusula a la cláusula
				clausula = Chr (len (clausula)) + clausula

				' Y la cláusula a la lista de cláusulas.
				clausulas = clausulas + clausula
			End If
		Close dF
	End If
	'' ===========================================================================

	clausula = ""
	sc_terminado = 0
	estado = 0

	If f Then
		While not sc_terminado And Not eof (f)
			Line input #f, linea
			lineNo = lineNo + 1
			linea = Trim (linea, Any chr (32) + chr (9))
			'?estado & " " & linea
			'?linea ;"-";:displayMe clausula
			stringToArray (linea)

			If estado <> 1 then
				' Leyendo cláusulas
				Select Case lP (0)
					case "IF":
						autoExpandFlags ()
						Select Case lP (1)
							Case "PLAYER_HAS_ITEM":
								clausula = clausula + chr (&H1) + chr (pval (lP (2)))
								numClausulas = numClausulas + 1
								clausulasUsed (&H1) = -1
							Case "PLAYER_HASN'T_ITEM":
								clausula = clausula + chr (&H2) + chr (pval (lP (2)))
								numClausulas = numClausulas + 1
								clausulasUsed (&H2) = -1
							Case "SEL_ITEM":
								Select case lP (2)
									Case "=":
										clausula = clausula + chr (&H10) + chr (itemFlag) + chr (pval (lP (3)))
										numClausulas = numClausulas + 1
										clausulasUsed (&H10) = -1
									Case "<>", "!=":
										clausula = clausula + chr (&H13) + chr (itemFlag) + chr (pval (lP (3)))
										numClausulas = numClausulas + 1
										clausulasUsed (&H13) = -1
								End Select
							Case "ITEM":
								Select case lP (3)
									Case "=":
										clausula = clausula + chr (&H3) + chr (pval (lP (2))) + chr (pval(lP (4)))
										numClausulas = numClausulas + 1
										clausulasUsed (&H3) = -1
									Case "<>", "!=":
										clausula = clausula + chr (&H4) + chr (pval (lP (2))) + chr (pval(lP (4)))
										numClausulas = numClausulas + 1
										clausulasUsed (&H4) = -1
								End Select
							Case "FLAG":
								Select Case lP (3)
									Case "=":
										If lP (4) = "FLAG" Then
											clausula = clausula + chr (&H14) + chr (pval (lP (2))) + chr (pval(lP (5)))
											clausulasUsed (&H14) = -1
										Else
											clausula = clausula + chr (&H10) + chr (pval (lP (2))) + chr (pval(lP (4)))
											clausulasUsed (&H10) = -1
										End If
									Case "<":
										If lP (4) = "FLAG" Then
											clausula = clausula + chr (&H15) + chr (pval (lP (2))) + chr (pval(lP (5)))
											clausulasUsed (&H15) = -1
										Else
											clausula = clausula + chr (&H11) + chr (pval (lP (2))) + chr (pval(lP (4)))
											clausulasUsed (&H11) = -1
										End If
									Case ">":
										If lP (4) = "FLAG" Then
											clausula = clausula + chr (&H16) + chr (pval (lP (2))) + chr (pval(lP (5)))
											clausulasUsed (&H16) = -1
										Else
											clausula = clausula + chr (&H12) + chr (pval (lP (2))) + chr (pval(lP (4)))
											clausulasUsed (&H12) = -1
										End If
									Case "<>", "!=":
										If lP (4) = "FLAG" Then
											clausula = clausula + chr (&H17) + chr (pval (lP (2))) + chr (pval(lP (5)))
											clausulasUsed (&H17) = -1
										Else
											clausula = clausula + chr (&H13) + chr (pval (lP (2))) + chr (pval(lP (4)))
											clausulasUsed (&H13) = -1
										End If
								End Select
								numClausulas = numClausulas + 1
							Case "PLAYER_TOUCHES":
								clausula = clausula + chr (&H20) + chr (pval (lP (2))) + chr (mapadjust + pval (lP (4)))
								clausulasUsed (&H20) = -1
								numClausulas = numClausulas + 1
							Case "PLAYER_IN_X":
								clausula = clausula + chr (&H21) + chr (val (lP (2))) + chr (val (lP (4)))
								clausulasUsed (&H21) = -1
								numClausulas = numClausulas + 1
							Case "PLAYER_IN_X_TILES":
								fzx1 = val (lP (2)) * 16 - 7
								If fzx1 < 0 Then fzx1 = 0
								fzx2 = val (lP (4)) * 16 + 15
								If fzx2 > 255 Then fzx2 = 255
								clausula = clausula + chr (&H21) + chr (fzx1) + chr (fzx2)
								clausulasUsed (&H21) = -1
								numClausulas = numClausulas + 1
							Case "PLAYER_IN_Y":
								clausula = clausula + chr (&H22) + chr (mapadjust * 16 + val (lP (2))) + chr (mapadjust * 16 + val (lP (4)))
								clausulasUsed (&H22) = -1
								numClausulas = numClausulas + 1
							Case "PLAYER_IN_Y_TILES":
								fzx1 = (val (lP (2)) + mapadjust) * 16 - 15
								If fzx1 < 0 Then fzx1 = 0
								fzx2 = (val (lP (4)) + mapadjust) * 16 + 15
								If fzx2 > 191 Then fzx2 = 191
								clausula = clausula + chr (&H22) + chr (fzx1) + chr (fzx2)
								clausulasUsed (&H22) = -1
								numClausulas = numClausulas + 1
							Case "ALL_ENEMIES_DEAD"
								clausula = clausula + chr (&H30)
								clausulasUsed (&H30) = -1
								numClausulas = numClausulas + 1
							Case "ENEMIES_KILLED_EQUALS"
								clausula = clausula + chr (&H31) + chr (pval (lP (2)))
								clausulasUsed (&H31) = -1
								numClausulas = numClausulas + 1
							Case "PLAYER_HAS_OBJECTS"
								clausula = clausula + chr (&H40)
								clausulasUsed (&H40) = -1
								numClausulas = numClausulas + 1
							Case "OBJECT_COUNT"
								clausula = clausula + chr (&H41) + chr (pval (lP (3)))
								clausulasUsed (&H41) = -1
								numClausulas = numClausulas + 1
							Case "NPANT"
								clausula = clausula + chr (&H50) + chr (pval (lP (2)))
								clausulasUsed (&H50) = -1
								numClausulas = numClausulas + 1
							Case "NPANT_NOT"
								clausula = clausula + chr (&H51) + chr (pval (lP (2)))
								clausulasUsed (&H51) = -1
								numClausulas = numClausulas + 1
							Case "JUST_PUSHED"
								clausula = clausula + chr (&H60)
								clausulasUsed (&H60) = -1
								numClausulas = numClausulas + 1
							Case "TIMER"
								If lP (2) = ">=" Then
									clausula = clausula + chr (&H70) + chr (pval (lP (3)))
									clausulasUsed (&H70) = -1
									numClausulas = numClausulas + 1
								ElseIf lP (2) = "<=" Then
									clausula = clausula + chr (&H71) + chr (pval (lP (3)))
									clausulasUsed (&H71) = -1
									numClausulas = numClausulas + 1
								End If
							Case "LEVEL"
								If lP (2) = "=" Then
									clausula = clausula + Chr (&H80) + chr (pval (lP (3)))
									clausulasUsed (&H80) = -1
									numClausulas = numClausulas + 1
								End If
							Case "TRUE"
								clausula = clausula + chr (&HF0)
								clausulasUsed (&HF0) = -1
								numClausulas = numClausulas + 1
							Case Else
								' Intento recuperar para construcciones tipo IF #3 = 4!
								'											 0	1  2 3
								If lP (1) <> "" Then
									If lP (1) = "SLOT_SELECTED" Then lP (1) = "#" & slotFlag
									If lP (1) = "ITEM_SELECTED" Then lP (1) = "#" & itemFlag
									If Left (lP (1), 1) = "#" Then
										' Generar un IF FLAG n = ...
										' Shift:
										For itt = 5 To 3 Step -1
											lP (itt) = lP (itt - 1)
										Next itt
										
										lP (2) = Right (lP (1), len (lP (1)) - 1)
														
										Select Case lP (3)
											Case "=":
												If lP (4) = "FLAG" Then
													clausula = clausula + chr (&H14) + chr (pval (lP (2))) + chr (pval(lP (5)))
													clausulasUsed (&H14) = -1
												Else
													clausula = clausula + chr (&H10) + chr (pval (lP (2))) + chr (pval(lP (4)))
													clausulasUsed (&H10) = -1
												End If
											Case "<":
												If lP (4) = "FLAG" Then
													clausula = clausula + chr (&H15) + chr (pval (lP (2))) + chr (pval(lP (5)))
													clausulasUsed (&H15) = -1
												Else
													clausula = clausula + chr (&H11) + chr (pval (lP (2))) + chr (pval(lP (4)))
													clausulasUsed (&H11) = -1
												End If
											Case ">":
												If lP (4) = "FLAG" Then
													clausula = clausula + chr (&H16) + chr (pval (lP (2))) + chr (pval(lP (5)))
													clausulasUsed (&H16) = -1
												Else
													clausula = clausula + chr (&H12) + chr (pval (lP (2))) + chr (pval(lP (4)))
													clausulasUsed (&H12) = -1
												End If
											Case "<>", "!=":
												If lP (4) = "FLAG" Then
													clausula = clausula + chr (&H17) + chr (pval (lP (2))) + chr (pval(lP (5)))
													clausulasUsed (&H17) = -1
												Else
													clausula = clausula + chr (&H13) + chr (pval (lP (2))) + chr (pval(lP (4)))
													clausulasUsed (&H13) = -1
												End If
										End Select
										numClausulas = numClausulas + 1
									End If
								End If
						End Select
					case "THEN":
						clausula = clausula + Chr (255)
						If numclausulas = 0 Then Print "ERROR: THEN with no clausules @ line " & lineNo: sc_terminado = -1
						estado = 1
					case "END":
						If estado = 0 then
						sc_terminado = -1
						End If
				end select
			Else
				' Leyendo acciones
				Select Case lP (0)
					Case "CLEAREXEC":
						clausula = clausula + Chr (&HF)
						actionsUsed (&HF) = -1
					Case "SET":
						autoExpandFlags ()							
						Select Case lP (1)
							Case "ITEM":
								clausula = clausula + Chr (&H0) + Chr (pval (lP (2))) + chr (pval (lP (4)))
								actionsUsed (&H0) = -1
							Case "FLAG":
								clausula = clausula + Chr (&H1) + Chr (pval (lP (2))) + chr (pval (lP (4)))
								actionsUsed (&H1) = -1
							Case "TILE":
								clausula = clausula + Chr (&H20) + Chr (pval (lP (3))) + Chr (pval (lP (5))) + Chr (pval (lP (8)))
								actionsUsed (&H20) = -1
							Case "SAFE":
								If lp (2) = "HERE" Then
									clausula = clausula + Chr (&HEA)
									actionsUsed (&HEA) = -1
								Else
									clausula = clausula + Chr (&HE9) + Chr (pval (lP (2))) + Chr (pval (lp (4))) + Chr (pval (lp (6)))
									actionsUsed (&HE9) = -1
								End If
							Case "TRUE":
								clausula = clausula + Chr (&H19) + Chr (pval (lP (3)))
								actionsUsed (&H19) = -1
							Case "FALSE":
								clausula = clausula + Chr (&H1A) + Chr (pval (lP (3)))
								actionsUsed (&H1A) = -1
						End Select
					Case "INC":
						autoExpandFlags ()
						Select Case lP (1)
							Case "FLAG":
								clausula = clausula + Chr (&H10) + Chr (pval (lP (2))) + chr (pval (lP (4)))
								actionsUsed (&H10) = -1
							Case "LIFE":
								clausula = clausula + Chr (&H30) + Chr (pval (lP (2)))
								actionsUsed (&H30) = -1
							Case "OBJECTS":
								clausula = clausula + Chr (&H40) + Chr (pval (lP (2)))
								actionsUsed (&H40) = -1
						End Select
					Case "DEC":
						autoExpandFlags ()
						Select Case lP (1)
							Case "FLAG":
								clausula = clausula + Chr (&H11) + Chr (pval (lP (2))) + chr (pval (lP (4)))
								actionsUsed (&H11) = -1
							Case "LIFE":
								clausula = clausula + Chr (&H31) + Chr (pval (lP (2)))
								actionsUsed (&H31) = -1
							Case "OBJECTS":
								clausula = clausula + Chr (&H41) + Chr (pval (lP (2)))
								actionsUsed (&H41) = -1
						End Select
					Case "ADD":
						clausula = clausula + Chr (&H12) + Chr (pval (lP (2))) + chr (pval (lP (4)))
						actionsUsed (&H12) = -1
					Case "SUB":
						clausula = clausula + Chr (&H13) + Chr (pval (lP (2))) + chr (pval (lP (4)))
						actionsUsed (&H13) = -1
					Case "SWAP":
						clausula = clausula + Chr (&H14) + Chr (pval (lP (1))) + chr (pval (lP (3)))
						actionsUsed (&H14) = -1
					Case "FLIPFLOP":
						clausula = clausula + Chr (&H15) + Chr (pval (lP (1)))
						actionsUsed (&H15) = -1
					Case "MOD":
						autoExpandFlags ()
						clausula = clausula + Chr (&H16) + Chr (pval (lP (2))) + chr (pval (lp (4)))
						actionsUsed (&H16) = -1
					Case "DECRANGE":
						' DECRANGE flag, min, max [1 3 5]
						clausula = clausula + Chr (&H17) + Chr (pval (lP (1))) + chr (pval (lp (3))) + chr (pval (lp (5)))
						actionsUsed (&H17) = -1
					Case "INCRANGE":
						clausula = clausula + Chr (&H18) + Chr (pval (lP (1))) + chr (pval (lp (3))) + chr (pval (lp (5)))
						actionsUsed (&H18) = -1
					Case "FLICKER":
						clausula = clausula + Chr (&H32)
						actionsUsed (&H32) = -1
					Case "DIZZY":
						clausula = clausula + Chr (&H33)
						actionsUsed (&H33) = -1
					Case "PRINT_TILE_AT":
						clausula = clausula + Chr (&H50) + Chr (pval (lP (2))) + Chr (pval (lP (4))) + Chr (pval (lP (7)))
						actionsUsed (&H50) = -1
					Case "SET_FIRE_ZONE":
						clausula = clausula + Chr (&H51) + Chr (pval (lP (1))) + Chr (16 * mapadjust + pval (lP (3))) + Chr (pval (lP (5))) + Chr (16 * mapadjust + pval (lP (7)))
						actionsUsed (&H51) = -1
					Case "SET_FIRE_ZONE_TILES":
						fzx1 = pval (lP (1)) * 16 - 15
						If fzx1 < 0 Then fzx1 = 0
						fzy1 = (mapadjust + pval (lP (3))) * 16 - 15
						If fzy1 < 0 Then fzy1 = 0
						fzx2 = pval (lP (5)) * 16 + 15
						If fzx2 > 254 Then fzx2 = 254
						fzy2 = (mapadjust + pval (lP (7))) * 16 + 15
						If fzy2 > 191 Then fzy2 = 191
						
						clausula = clausula + Chr (&H51) + Chr (fzx1) + Chr (fzy1) + Chr (fzx2) + Chr (fzy2)
						actionsUsed (&H51) = -1
					Case "SHOW_COINS":
						clausula = clausula + Chr (&H60)
						actionsUsed (&H60) = -1
					Case "HIDE_COINS":
						clausula = clausula + Chr (&H61)
						actionsUsed (&H61) = -1
					Case "ENABLE_KILL_SLOWLY"
						clausula = clausula + Chr (&H62)
						actionsUsed (&H62) = -1
					Case "DISABLE_KILL_SLOWLY"
						clausula = clausula + Chr (&H63)
						actionsUsed (&H63) = -1
					Case "ENABLE_TYPE_6"
						clausula = clausula + Chr (&H64)
						actionsUsed (&H64) = -1
					Case "DISABLE_TYPE_6"
						clausula = clausula + Chr (&H65)
						actionsUsed (&H65) = -1
					Case "ENABLE_MAKE_TYPE_6"
						clausula = clausula + Chr (&H66)
						actionsUsed (&H66) = -1
					Case "DISABLE_MAKE_TYPE_6"
						clausula = clausula + Chr (&H67)
						actionsUsed (&H67) = -1
					Case "REDRAW"
						clausula = clausula + Chr (&H6E)
						actionsUsed (&H6E) = -1
					Case "REENTER"
						clausula = clausula + Chr (&H6F)
						actionsUsed (&H6F) = -1
					Case "REHASH"
						clausula = clausula + Chr (&H73)
						actionsUsed (&H73) = -1
					Case "WARP_TO"
						clausula = clausula + Chr (&H6D) + Chr (pval (lP (1))) + Chr (pval (lP (3))) + Chr (pval (lP (5)))
						actionsUsed (&H6D) = -1
					Case "REPOSTN"
						clausula = clausula + Chr (&H6C) + Chr (pval (lP (1))) + Chr (pval (lP (3)))
						actionsUsed (&H6C) = -1
					Case "SETX"
						clausula = clausula + Chr (&H6B) + Chr (pval (lP (1)))
						actionsUsed (&H6B) = -1
					Case "SETY"
						clausula = clausula + Chr (&H6A) + Chr (pval (lP (1)))
						actionsUsed (&H6A) = -1
					Case "SETXY"
						clausula = clausula + Chr (&H68) + Chr (pval (lP (1))) + Chr (pval (lP (3)))
						actionsUsed (&H68) = -1
					Case "WARP_TO_LEVEL"
						clausula = clausula + Chr (&H69) + Chr (pval (lP (1))) + Chr (pval (lP (3))) + Chr (pval (lP (5))) + Chr (pval (lP (7))) + Chr (pval (lP (9)))
						actionsUsed (&H69) = -1
					Case "SET_TIMER"
						clausula = clausula + Chr (&H70) + Chr (pval (lP (1))) + Chr (pval (lP (3)))
						actionsUsed (&H70) = -1
					Case "TIMER_START"
						clausula = clausula + Chr (&H71)
						actionsUsed (&H71) = -1
					Case "TIMER_STOP"
						clausula = clausula + Chr (&H72)
						actionsUsed (&H72) = -1
					Case "ENEMY"
						If lP (2) = "ON" Then
							clausula = clausula + Chr (&H80) + Chr (pval (lP (1)))
							actionsUsed (&H80) = -1
						ElseIf lP (2) = "OFF" Then
							clausula = clausula + Chr (&H81) + Chr (pval (lP (1)))
							actionsUsed (&H81) = -1
						ElseIf lp (2) = "TYPE" Then
							clausula = clausula + Chr (&H83) + Chr (pval (lP (1))) + Chr (pval (lP (3)))
							actionsUsed (&H83) = -1
						End If
					Case "ENEMIES"
						If lp (1) = "RESTORE" Then
							If lp (2) = "ALL" Then
								clausula = clausula + Chr (&H85)
								actionsUsed (&H85) = -1
							Else
								clausula = clausula + Chr (&H84)
								actionsUsed (&H84) = -1
							End If
						End If
					Case "ADD_FLOATING_OBJECT"
						clausula = clausula + Chr (&H82) + Chr (pval (lP (1))) + Chr (pval (lP (3))) + Chr (pval (lP (5)))
						actionsUsed (&H82) = -1
					Case "ADD_CONTAINER"
						'clausula = clausula + Chr (&H82) + Chr (128 + pval (lP (1))) + Chr (pval (lP (3))) + Chr (pval (lP (5)))
						'actionsUsed (&H82) = -1
						clausula = clausula + Chr (&H86) + Chr (pval (lP (1))) + Chr (pval (lP (3))) + Chr (pval (lP (5)))
						actionsUsed (&H86) = -1
					Case "SHOW_CONTAINERS"
						clausula = clausula + Chr (&H87)
						actionsUsed (&H87) = -1
					Case "NEXT_LEVEL":
						clausula = clausula + Chr (&HD0)
						actionsUsed (&HD0) = -1
					Case "SOUND":
						clausula = clausula + Chr (&HE0) + Chr (pval (lP (1)))
						actionsUsed (&HE0) = -1
					Case "SHOW":
						clausula = clausula + Chr (&HE1)
						actionsUsed (&HE1) = -1
					Case "RECHARGE":
						clausula = clausula + Chr (&HE2)
						actionsUsed (&HE2) = -1
					Case "TEXT":
						clausula = clausula + Chr (&HE3) + Chr (pval (lP (1)))
						'For ai = 1 To Len (lP (1))
						''	If ai = 15 Then Exit For
						''	If Mid (lP (1), ai, 1) = "_" Then
						''		clausula = clausula + Chr (0)
						''	Else
						''		clausula = clausula + Chr (Asc(Mid (lP (1), ai, 1)) - 32)
						''	End If
						'Next ai
						'clausula = clausula + Chr (&HEE)
						actionsUsed (&HE3) = -1
					Case "OPENTEXT":
						clausula = clausula + Chr (&HEB)
						actionsUsed (&HEB) = -1
					Case "CLOSETEXT":
						clausula = clausula + Chr (&HEC)
						actionsUsed (&HEC) = -1
					Case "TEXTWINDOW":
						clausula = clausula + Chr (&HED) + Chr (Val (lP (1)))
						actionsUsed (&HED) = -1
					Case "EXTERN":
						clausula = clausula + Chr (&HE4) + Chr (Val (lP (1)))
						actionsUsed (&HE4) = -1
					Case "EXTERN_E":
						clausula = clausula + Chr (&HE8) + Chr (Val (lP (1))) + Chr (Val (lP (3)))
						actionsUsed (&HE8) = -1
					Case "PAUSE":
						clausula = clausula + Chr (&HE5) + Chr (Pval (lP (1)))
						actionsUsed (&HE5) = -1
					Case "MUSIC"
						clausula = clausula + Chr (&HE6) + Chr (Pval (lP (1)))
						actionsUsed (&HE6) = -1
					Case "REDRAW_ITEMS"
						clausula = clausula + Chr (&HE7)
						actionsUsed (&HE7) = -1
					Case "GAME":
						clausula = clausula + Chr (&HF0)
						actionsUsed (240) = -1
					Case "WIN":
						clausula = clausula + Chr (&HF1)
						actionsUsed (241) = -1
					Case "BREAK":
						clausula = clausula + Chr (&HF2)
						actionsUsed (&HF2) = -1
					Case "GAME_ENDING":
						clausula = clausula + Chr (&HF3)
						actionsUsed (&HF3) = -1
					case "DECORATIONS"
						' parsear e incluir una lista de prints.
						clausula = clausula + Chr (&HF4)
						actionsUsed (&HF4) = -1
						do
							Line input #f, linea
							lineNo = lineNo + 1
							linea = Trim (linea, Any chr (32) + chr (9))
							If ucase (linea)="END" then exit do
							stringToArray (linea)
							' X,Y,T -> XY T
							clausula = clausula + Chr ((Val(lP(0)) Shl 4) + (Val(lP(2)) And 15)) + Chr (Val(lP(4)))
						loop
						clausula = clausula + Chr (&HFF)
					Case "END":
						clausula = clausula + Chr (&HFF)
						clausula = Chr (len (clausula)) + clausula
						clausulas = clausulas + clausula
						numclausulas = 0
						estado = 0
						clausula = ""
				End Select
			End If
		Wend
	End If
	If Clausulas <> "" Then procesaClausulas = Clausulas + Chr (255)
End Function

Sub displayMe (clausula As String)
	Dim i As Integer
	Dim p As String

	For i = 1 To Len (clausula)
		p = Str (asc (mid (clausula, i, 1)))
		If Len (p) = 1 Then p = "00" + p
		If Len (p) = 2 Then p = "0" + p
		? p;
		If i < Len (clausula) Then ? ", ";
	Next i
	Print
End Sub

Sub printGenName (f2 As Integer, i As Integer, maxidx As Integer)
	Print #f2, "script_" & thisLevelConstantName & "_";
	If i < maxidx Then
		If (i And 1) = 0 Then 
			Print #f2, "entering";
		Else
			Print #f2, "pfire_at";
		End If
		Print #f2, "_" & (i\2);
	Else
		If i = maxidx Then 
			Print #f2, "entering_game";
		ElseIf i = maxidx + 1 Then 
			Print #f2, "entering_any";
		ElseIf i = maxidx + 2 Then 
			Print #f2, "pfire_at_any";
		ElseIf i = maxidx + 3 Then 
			Print #f2, "on_timer_off";
		ElseIf i = maxidx + 4 Then
			Print #f2, "get_coin";
		ElseIf i = maxidx + 5 Then
			Print #f2, "kill_enemy";
		End If
	End If
End Sub

Dim As Integer f, f2, f3, f0, i, j, k, clin, nPant, maxidx, scriptCount, binPt, offsPt
Dim As String linea, clausulas, o, inFileName, outFileName
Dim As Integer keepGoing, sDone, nSections, killing
Dim As String mandatory (3) = { "in", "interpreter", "scripts", "maxpants" }
Dim As String levelNamesList (31)
Dim As Integer levelNamesListIndex
Dim As uByte d

sclpParseAttrs

If Not sclpCheck (mandatory ()) Or Val (sclpGetValue ("maxpants")) = 0 Then
	Print "MojonTwins Scripts Compiler 4 [ZX/CPC/...] 20170719"
	Print "MT Engine MK3 v0.1+"
	Print
	Print "Usage:"
	Print "$ msc4nes in=script.spt interpreter=msc.h scripts=scripts.bin maxpants=n [mapadjust=n] [rampage=n]"
	Print
	System
End If

inFileName = sclpGetValue ("in")
outFileName = sclpGetValue ("interpreter")
maxidx = 2 * Val (sclpGetValue ("maxpants"))
maxScr = Val (sclpGetValue ("maxpants"))
mapadjust = Val (sclpGetValue ("mapadjust"))

rampage = Val (sclpGetValue ("rampage"))

ReDim script (maxidx + 5)
ReDim addresses (maxidx + 5)
resetScript (maxidx + 5)

'Kill "scripts.bin"

macrosPtr = 0
For i = 0 To MAX_MACROS
	For j = 0 TO MACRO_SIZE
		macros (i, j) = ""
	Next j
Next i

f = Freefile
Open inFileName for input as #f
f2 = Freefile
Open outFileName For Output as #f2
f0 = FreeFile
Open sclpGetValue ("scripts") For Binary As #f0
f3 = Freefile

lineNo = 0

Print #f2, "// MT MK3 ZX"
Print #f2, "// Copyleft 2017 by The Mojon Twins"
Print #f2, ""
Print #f2, "// script interpreter"
Print #f2, "// generated by msc4_sp.exe from " & inFileName
Print #f2, ""
'Print #f2, "unsigned char _x, _y, sc_n, sc_c;"
'Print #f2, "const unsigned char *next_script;"
'Print #f2, "const unsigned char *script;"
'Print #f2, "unsigned char script_result, sc_terminado, sc_continuar;"
'Print #f2, "unsigned char commands_executed;"
'Print #f2, "#ifdef ENABLE_FIRE_ZONE"
'Print #f2, "unsigned char fzx1, fzy1, fzx2, fzy2, f_zone_ac;"
'Print #f2, "#endif"
'Print #f2, ""
'Print #f2, "const unsigned char * const *script_pool;"

maxClausuleSize = 0
scriptCount = 0
offsPt = 0
outBinIndex = 0
nSections = 0
killing = 0

Print "Parsing " & inFileName
Print

keepGoing = -1
sDone = 0
decoInclude = ""
thisLevelConstantName = ""
levelNamesListIndex = 0
While keepGoing
	If (eof (f)) then
		keepGoing = 0
		linea = ""
		'If sDone then
			lP (0) = "END_OF_LEVEL"
			killing = -1
		'End If
	Else
		Line input #f, linea
		lineNo = lineNo + 1
		linea = Trim (linea, Any chr (32) + chr (9))
		stringToArray (linea)
	End If

	doIncludeDecos = 0

	Select Case lP (0)
		Case "LEVELID":
			thisLevelConstantName = lP (1)
			? "Level " & scriptcount & "'s name is " & thisLevelConstantName
		Case "INC_DECORATIONS":
			decoInclude = lP (1)
			? "Extra decorations file for current level is " & decoInclude
			For i = 0 To maxScr: decorated (i) = 0: Next i
		Case "ITEMSET":
			procesaItems f
		Case "DEFALIAS"
			procesaAlias f
		Case "ENTERING":
			sDone = -1
			If lP (1) <> "GAME" And lp (1) <> "ANY" And decoInclude <> "" Then
				doIncludeDecos = -1
				decoFetch = Val (lP (2))
				decorated (decoFetch) = -1
			End If
			clausulas = procesaClausulas (f)
			stringToArray (linea)
			If lP (1) = "GAME" then
				script (maxidx) = clausulas
			elseif lP (1) = "ANY" then
				script (maxidx + 1) = clausulas
			Else
				For i = 2 to LIST_WORDS_SIZE
					If lP (i) <> "" And lP (i) <> "," Then
						script (2 * val(lP(i))) = clausulas
					End If
				Next i
			endif
			nSections = nSections + 1
		Case "PRESS_FIRE":
			sDone = -1
			clausulas = procesaClausulas (f)
			stringToArray (linea)
			If lP (2) = "ANY" then
				script (maxidx + 2) = clausulas
			Else
				For i = 3 to LIST_WORDS_SIZE
					If lP (i) <> "" And lP (i) <> "," Then
						script (1 + 2 * val(lP(i))) = clausulas
					End If
				Next i
			End If
			nSections = nSections + 1
		Case "ON_TIMER_OFF":
			sDone = -1
			clausulas = procesaClausulas (f)
			stringToArray (linea)
			script (maxidx + 3) = clausulas
			nSections = nSections + 1
		Case "PLAYER_GETS_COIN":
			sDone = -1
			clausulas = procesaClausulas (f)
			stringToArray (linea)
			script (maxidx + 4) = clausulas
			nSections = nSections + 1
		Case "PLAYER_KILLS_ENEMY":
			sDone = -1
			clausulas = procesaClausulas (f)
			stringToArray (linea)
			script (maxidx + 5) = clausulas
			nSections = nSections + 1
		Case "END_OF_LEVEL":
			' Decorations: check If screens containing to ENTERING script
			' Should be decorated...
			If decoInclude <> "" Then
				For i = 0 To maxScr
					If Not decorated (i) Then
						doIncludeDecos = -1
						decoFetch = i
						clausulas = procesaClausulas (0)
						script (2 * i) = clausulas
						nSections = nSections + 1
					End If
				Next i
			End If

			If killing Then
				Print "End Of Script reached."
				If nSections Then Print "Sections for the game: " & nSections
			Else
				Print "End Of Level reached."
				Print "Sections in this level: " & nSections
			End If
			Print

			If sDone Then
				' Add entry point as a define
				offsPt = outBinIndex
				levelNamesList (levelNamesListIndex) = thisLevelConstantName
				levelNamesListIndex = levelNamesListIndex + 1
				Print #f2, "#define SCRIPT_" & thisLevelConstantName & "_OFFSET 0x" & Hex (offsPt, 4)

				' Write current script
				' Leave space for the index
				outBinIndex = outBinIndex + (maxidx + 6) * 2
				For i = 0 To maxidx + 5
					' Add entry to index
					If Len (script (i)) = 0 Then
						outBin (offsPt + i*2) = 0
						outBin (offsPt + i*2 + 1) = 0
					Else
						outBin (offsPt + i*2) = outBinIndex And &HFF
						outBin (offsPt + i*2 + 1) = outBinIndex Shr 8
					
						' Write script to binary
						For j = 1 To Len (script (i))
							mbWrite Asc (Mid (script (i), j, 1))
						Next j
					End If
				Next i

				scriptCount = scriptCount + 1
				resetScript (maxidx + 5)
			EndIf				
			sDone = 0
			decoInclude = ""
			thisLevelConstantName = ""
			nSections = 0
	End Select
Wend

Print #f2, ""
Print #f2, "const unsigned int level_script_offsets [] = {"
For j = 0 To levelNamesListIndex - 1
	Print #f2, "    SCRIPT_" & levelNamesList (j) & "_OFFSET";
	If j < levelNamesListIndex - 1 Then Print #f2, ", " Else Print #f2, ""
Next j
Print #f2, "};"
Print #f2, ""

'Print #f2, "void script_init (unsigned char l) {"
'Print #f2, "	script_pool = level_scripts [l];"
'Print #f2, "}"
'Print #f2, ""

If maxItem > 0 then

	'Print #f3, ""
	'Print #f3, "// This game uses items..."
	'Print #f3, ""
	'Print #f3, "#define MSC_MAXITEMS " & str (maxitem)
	'Print #f3, "#define FLAG_SLOT_SELECTED " & slotFlag
	'Print #f3, "#define FLAG_ITEM_SELECTED " & itemFlag
	'Print #f3, "#define ITEM_EMPTY " & itemEmpty
	'Print #f3, " "
	'Print #f3, "unsigned char items [MSC_MAXITEMS];"
	'Print #f3, "unsigned char its_it, its_p;"
	'Print #f3, " "
	'Print #f3, "int key_z;"
	'Print #f3, "unsigned char key_z_pressed = 0;"
	'Print #f3, " "
'	'
	'Print #f3, "void draw_cursor (unsigned char a, unsigned char b, unsigned char x, unsigned char y) {"
	'Print #f3, "	If (a != b) {"
	'Print #f3, "		sp_PrintAtInv (y, x, 0, 0);"
	'Print #f3, "		sp_PrintAtInv (y, x + 1, 0, 0);"
	'Print #f3, "	} Else {"
	'Print #f3, "		sp_PrintAtInv (y, x, " & itemSelectClr & ", " & itemSelectC1 & ");"
	'Print #f3, "		sp_PrintAtInv (y, x + 1, " & itemSelectClr & ", " & itemSelectC2 & ");"
	'Print #f3, "	}"
	'Print #f3, "}"
	'Print #f3, " "
	
	' Generate display_items
	'If itemSetOr = 0 Then
		' Horizontal
		'Print #f3, "void display_items (void) {"
		'Print #f3, "	 its_p = " & itemSetX & ";"
		'Print #f3, "	 for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
		'If itemEmpty <> -1 then
			'Print #f3, "		 If (items [its_it]) {"
			'Print #f3, "			 draw_coloured_tile (its_p, " & itemSetY & ", items [its_it]);"
			'Print #f3, "		 } Else {"
			'Print #f3, "			 draw_coloured_tile (its_p, " & itemSetY & ", " & itemEmpty & ");"
			'Print #f3, "		 }"
		'Else
			'Print #f3, "		 draw_coloured_tile (its_p, " & itemSetY & ", items [its_it]);"
		'End If
		'Print #f3, "		 draw_cursor (its_it, flags [FLAG_SLOT_SELECTED], its_p, " & (itemSetY + 2) & ");"
		'Print #f3, "		 its_p += " & itemSetStep & ";"
		'Print #f3, "	 }"
		'Print #f3, "}"
		'Print #f3, " "
	'Else
		' Vertical
		'Print #f3, "void display_items (void) {"
		'Print #f3, "	 its_p = " & itemSetY & ";"
		'Print #f3, "	 for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
		'If itemEmpty <> -1 then
			'Print #f3, "		 If (items [its_it]) {"
			'Print #f3, "			 draw_coloured_tile (" & itemSetX & ", its_p, items [its_it]);"
			'Print #f3, "		 } Else {"
			'Print #f3, "			 draw_coloured_tile (" & itemSetX & ", its_p, " & itemEmpty & ");"
			'Print #f3, "		 }"
		'Else
			'Print #f3, "		 draw_coloured_tile (" & itemSetX & ", its_p, items [its_it]);"
		'End If
		'Print #f3, "		 draw_cursor (its_it, flags [FLAG_SLOT_SELECTED], " & itemSetX & ", its_p + 2);"
		'Print #f3, "		 its_p += " & itemSetStep & ";"
		'Print #f3, "	 }"
		'Print #f3, "}"
		'Print #f3, " "
	'End If
	
	'Print #f3, "void do_inventory_fiddling (void) {"
	'Print #f3, "	If (sp_KeyPressed (key_z)) {"
	'Print #f3, "		If (!key_z_pressed) {"
	'Print #f3, "#ifdef MODE_128K"
	'Print #f3, "			_AY_PL_SND (2);"
	'Print #f3, "#Else"
	'Print #f3, "			peta_el_beeper (2);"
	'Print #f3, "#endif"
	'Print #f3, "#ifdef MSC_MAXITEMS"
	'Print #f3, "			flags [FLAG_SLOT_SELECTED] = (flags [FLAG_SLOT_SELECTED] + 1) % MSC_MAXITEMS;"
	'Print #f3, "#Else"
	'Print #f3, "			flags [FLAG_SLOT_SELECTED] = (flags [FLAG_SLOT_SELECTED] + 1) % SIM_DISPLAY_MAXITEMS;"
	'Print #f3, "#endif"
	'Print #f3, "			display_items ();"
	'Print #f3, "		}"
	'Print #f3, "		key_z_pressed = 1;"
	'Print #f3, "	} Else {"
	'Print #f3, "		key_z_pressed = 0;"
	'Print #f3, "	}"
	'Print #f3, "}"
	'Print #f3, " "

	'If clausulasUsed (&H1) Or clausulasUsed (&H2) Then
		' Search item
		'Print #f3, "unsigned char search_item (unsigned char t) {"
		'Print #f3, "	 for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
		'Print #f3, "		 If (items [its_it] == t) return 1;"
		'Print #f3, "	 }"
		'Print #f3, "	 return 0;"
		'Print #f3, "}"
	'End If

	'Print #f3, ""
End If

Close #f

' Write binary
For i = 0 To outBinIndex - 1
	d = outBin (i)
	Put #f0, , d
Next i
Close #f0

Print #f2, "#ifdef CLEAR_FLAGS"
Print #f2, "void msc_clear_flags (void) {"
Print #f2, "	gpit = MAX_FLAGS; while (gpit --) flags [gpit] = 0;"
Print #f2, "}"
Print #f2, "#endif"
Print #f2, ""
If rampage <> 0 Then
	Print #f2, "unsigned char read_byte (void) {"
	Print #f2, "    set_bank (" & rampage & ");"
	Print #f2, "    sc_c = *script ++;"
	Print #f2, "    set_bank (0);"
	Print #f2, "    return sc_c;"
	Print #f2, "}"
	Print #f2, ""
	Print #f2, "unsigned char read_vbyte (void) {"
	Print #f2, "	sc_c = read_byte ();"
	Print #f2, "	if (sc_c & 128) return flags [sc_c & 127];"
	Print #f2, "	return sc_c;"
	Print #f2, "}"
	Print #f2, ""
Else
	Print #f2, "unsigned char read_byte (void) {"
	Print #f2, "	return *script ++;"
	Print #f2, "}"
	Print #f2, ""
	Print #f2, "unsigned char read_vbyte (void) {"
	Print #f2, "	sc_c = *script ++;"
	Print #f2, "	if (sc_c & 128) return flags [sc_c & 127];"
	Print #f2, "	return sc_c;"
	Print #f2, "}"
	Print #f2, ""
End If
If clausulasUsed (&H21) Or clausulasUsed (&H22) Then
	Print #f2, "void readxy (void) {"
	Print #f2, "	_x = read_byte ();"
	Print #f2, "	_y = read_byte ();"
	Print #f2, "}"
	Print #f2, ""
End If
Print #f2, "void readvxy (void) {"
Print #f2, "	_x = read_vbyte ();"
Print #f2, "	_y = read_vbyte ();"
Print #f2, "}"
Print #f2, ""
If actionsUsed (&H68) Or actionsUsed (&H6c) Or actionsUsed (&H6D) Then
	Print #f2, "void reloc_player (void) {"
	Print #f2, "	px = read_vbyte () << (4+FIX_BITS);"
	Print #f2, "	py = read_vbyte () << (4+FIX_BITS);"
	Print #f2, "	player_reset_movement ();"
	Print #f2, "}"
	Print #f2, ""
End If
Print #f2, "void run_script (unsigned char whichs) {"
Print #f2, "	commands_executed = 0;"
Print #f2, "    script_result = 0;"
Print #f2, ""
Print #f2, "    gp_gen = (unsigned char *) (scripts_index + (whichs << 1));"
Print #f2, "    rda = *gp_gen ++; rdb = *gp_gen;"
Print #f2, "	if ((rda | rdb) == 0) return;"
Print #f2, "	script = scripts + ((rdb << 8) | rda);"
Print #f2, ""
Print #f2, "	// todo : update selected item flag"
Print #f2, ""
Print #f2, "	while ((sc_c = read_byte ()) != 0xff) {"
Print #f2, "		next_script = script + sc_c;"
Print #f2, "		sc_terminado = sc_continuar = 0;"
Print #f2, "		while (!sc_terminado) {"
Print #f2, "			switch (read_byte ()) {"

'' TODO
If clausulasUsed (&H1) Then
	Print #f2, "				case 0x01:"
	Print #f2, "					// IF PLAYER_HAS_ITEM _x"
	Print #f2, "					// Opcode: 01 _x"
	Print #f2, "					sc_terminado = (!search_item (read_vbyte ()));"
	Print #f2, "					break;"
End If

If clausulasUsed (&H2) Then
	Print #f2, "				case 0x02:"
	Print #f2, "					// IF PLAYER_HASN'T_ITEM _x"
	Print #f2, "					// Opcode: 02 _x"
	Print #f2, "					sc_terminado = (search_item (read_vbyte ()));"
	Print #f2, "					break;"
End If

If clausulasUsed (&H3) Then
	Print #f2, "				case 0x03:"
	Print #f2, "					// IF ITEM x = n"
	Print #f2, "					// Opcode: 03 x n"
	Print #f2, "					sc_terminado = items [read_vbyte ()] != read_vbyte ();"
	Print #f2, "					break;"
End If

If clausulasUsed (&H4) Then
	Print #f2, "				case 0x04:"
	Print #f2, "					// IF ITEM x <> n"
	Print #f2, "					// Opcode: 04 x n"
	Print #f2, "					sc_terminado = items [read_vbyte ()] == read_vbyte ();"
	Print #f2, "					break;"
End If
'' EOTODO

If clausulasUsed (&H10) Then
	Print #f2, "				case 0x10:"
	Print #f2, "					// IF FLAG _x = sc_n"
	Print #f2, "					// Opcode: 10 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] != _y);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H11) Then
	Print #f2, "				case 0x11:"
	Print #f2, "					// IF FLAG _x < sc_n"
	Print #f2, "					// Opcode: 11 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] >= _y);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H12) Then
	Print #f2, "				case 0x12:"
	Print #f2, "					// IF FLAG _x > sc_n"
	Print #f2, "					// Opcode: 12 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] <= _y);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H13) Then
	Print #f2, "				case 0x13:"
	Print #f2, "					// IF FLAG _x <> sc_n"
	Print #f2, "					// Opcode: 13 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] == _y);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H14) Then
	Print #f2, "				case 0x14:"
	Print #f2, "					// IF FLAG _x = FLAG _y"
	Print #f2, "					// Opcode: 14 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] != flags [_y]);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H15) Then
	Print #f2, "				case 0x15:"
	Print #f2, "					// IF FLAG _x < FLAG _y"
	Print #f2, "					// Opcode: 15 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] >= flags [_y]);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H16) Then
	Print #f2, "				case 0x16:"
	Print #f2, "					// IF FLAG _x > FLAG _y"
	Print #f2, "					// Opcode: 16 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] <= flags [_y]);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H17) Then
	Print #f2, "				case 0x17:"
	Print #f2, "					// IF FLAG _x <> FLAG _y"
	Print #f2, "					// Opcode: 17 _x sc_n"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = (flags [_x] == flags [_y]);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H20) Then
	Print #f2, "				case 0x20:"
	Print #f2, "					// IF PLAYER_TOUCHES x, y"
	Print #f2, "					// Opcode: 20 _x _y"
	'Print #f2, "					readvxy ();"
	'Print #f2, "					_x <<= 4; _y <<= 4;"
	'Print #f2, "					sc_terminado = (!(prx + 7 >= _x && prx <= _x + 15 && pry + 15 >= _y && pry <= _y + 15));"
	Print #f2, "					readvxy ();"
	Print #f2, "					sc_terminado = ((prx + 4) >> 4) != _x || ((pry + 8) >> 4) != _y;"
	Print #f2, "					break;"
End If

If clausulasUsed (&H21) Then
	Print #f2, "				case 0x21:"
	Print #f2, "					// IF PLAYER_IN_X x1, x2"
	Print #f2, "					// Opcode: 21 x1 x2"
	Print #f2, "					readxy ();"
	Print #f2, "					sc_terminado = (!(prx >= _x && prx <= _y));"
	Print #f2, "					break;"
End If

If clausulasUsed (&H22) Then
	Print #f2, "				case 0x22:"
	Print #f2, "					// IF PLAYER_IN_Y y1, y2"
	Print #f2, "					// Opcode: 22 y1 y2"
	Print #f2, "					readxy ();"
	Print #f2, "					sc_terminado = (!(pry >= _x && pry <= _y));"
	Print #f2, "					break;"
End If

If clausulasUsed (&H30) Then
	Print #f2, "				case 0x30:"
	Print #f2, "					// IF ALL_ENEMIES_DEAD"
	Print #f2, "					// Opcode: 30"
	Print #f2, "					sc_terminado = (pkilled != BADDIES_COUNT);"
	Print #f2, "					break;"
End If

If clausulasUsed (&H31) Then
	Print #f2, "				case 0x31:"
	Print #f2, "					// IF ENEMIES_KILLED_EQUALS sc_n"
	Print #f2, "					// Opcode: 31 sc_n"
	Print #f2, "					sc_terminado = (pkilled != read_vbyte ());"
	Print #f2, "					break;"
End If

If clausulasUsed (&H40) Then
	Print #f2, "				case 0x40:"
	Print #f2, "					 // IF PLAYER_HAS_OBJECTS"
	Print #f2, "					 // Opcode: 40"
	Print #f2, "					 sc_terminado = (pobjs == 0);"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H41) Then
	Print #f2, "				case 0x41:"
	Print #f2, "					 // IF OBJECT_COUNT = sc_n"
	Print #f2, "					 // Opcode: 41 sc_n"
	Print #f2, "					 sc_terminado = (pobjs != read_vbyte ());"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H50) Then
	Print #f2, "				case 0x50:"
	Print #f2, "					 // IF NPANT sc_n"
	Print #f2, "					 // Opcode: 50 sc_n"
	Print #f2, "					 sc_terminado = (n_pant != read_vbyte ());"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H51) Then
	Print #f2, "				case 0x51:"
	Print #f2, "					 // IF NPANT_NOT sc_n"
	Print #f2, "					 // Opcode: 51 sc_n"
	Print #f2, "					 sc_terminado = (n_pant == read_vbyte ());"
	Print #f2, "					 break;"
End If

'' TODO
If clausulasUsed (&H60) Then
	Print #f2, "				case 0x60:"
	Print #f2, "					 // IF JUST_PUSHED"
	Print #f2, "					 // Opcode: 60"
	Print #f2, "					 sc_terminado = (!just_pushed);"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H70) Then
	Print #f2, "				case 0x70:"
	Print #f2, "					 // IF TIMER >= _x"
	Print #f2, "					 sc_terminado = (ctimer_t < read_vbyte ());"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H71) Then
	Print #f2, "				case 0x71:"
	Print #f2, "					 // IF TIMER <= _x"
	Print #f2, "					 sc_terminado = (ctimer_t > read_vbyte ());"
	Print #f2, "					 break;"
End If

If clausulasUsed (&H80) Then
	Print #f2, "				case 0x80:"
	Print #f2, "					 // IF LEVEL = sc_n"
	Print #f2, "					 // Opcode: 80 sc_n"
	Print #f2, "					 sc_terminado = (read_vbyte () != level);"
	Print #f2, "					 break;"
End If
'' EOTODO

If clausulasUsed (&HF0) Then
	' No es necesario generar este código...
	'Print #f2, "				case 0xF0:"
	'Print #f2, "					 // IF TRUE"
	'Print #f2, "					 // Opcode: F0"
	'Print #f2, "					 break;"
End If

Print #f2, "				case 0xff:"
Print #f2, "					// then"
Print #f2, "					// opcode: ff"
Print #f2, "					sc_terminado = sc_continuar = 1;"
Print #f2, "					break;"
Print #f2, "			}"
Print #f2, "		}"
Print #f2, ""
Print #f2, "		if (sc_continuar) {"
Print #f2, "			sc_terminado = 0;"
Print #f2, "			commands_executed = 1;"
Print #f2, "			while (!sc_terminado) {"
Print #f2, "				switch (sc_n = read_byte ()) {"

'' TODO
If actionsUsed (&H0) Then
	Print #f2, "					case 0x00:"
	Print #f2, "						// SET ITEM _x sc_n"
	Print #f2, "						// Opcode: 00 _x sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						items [_x] = _y;"
	Print #f2, "						display_items ();"
	Print #f2, "						break;"
End If
'' EOTODO

If actionsUsed (&H1) Then
	Print #f2, "					case 0x01:"
	Print #f2, "						// SET FLAG _x = sc_n"
	Print #f2, "						// Opcode: 01 _x sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [_x] = _y;"
	Print #f2, "						break;"
End If

If actionsUsed (&HF) Then
	Print #f2, "					case 0x0f:"
	Print #f2, "						commands_executed = 0;"
	Print #f2, "						break;"
End If

If actionsUsed (&H10) Then
	Print #f2, "					case 0x10:"
	Print #f2, "						// INC FLAG _x, sc_n"
	Print #f2, "						// Opcode: 10 _x sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [_x] += _y;"
	Print #f2, "						break;"
End If

If actionsUsed (&H11) Then
	Print #f2, "					case 0x11:"
	Print #f2, "						// DEC FLAG _x, sc_n"
	Print #f2, "						// Opcode: 11 _x sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [_x] -= _y;"
	Print #f2, "						break;"
End If

If actionsUsed (&H12) Then
	Print #f2, "					case 0x12:"
	Print #f2, "						// ADD FLAGS _x, _y"
	Print #f2, "						// Opcode: 12 _x _y"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [_x] = flags [_x] + flags [_y];"
	Print #f2, "						break;"
End If

If actionsUsed (&H13) Then
	Print #f2, "					case 0x13:"
	Print #f2, "						// SUB FLAGS _x, _y"
	Print #f2, "						// Opcode: 13 _x _y"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [_x] = flags [_x] - flags [_y];"
	Print #f2, "						break;"
End If

If actionsUsed (&H14) Then
	Print #f2, "					case 0x14:"
	Print #f2, "						// SWAP FLAGS _x, _y"
	Print #f2, "						// Opcode: 14 _x _y"
	Print #f2, "						readvxy ();"
	Print #f2, "						sc_n = flags [_x];"
	Print #f2, "						flags [_x] = flags [_y];"
	Print #f2, "						flags [_y] = sc_n;"
	Print #f2, "						break;"
End If

If actionsUsed (&H15) Then
	Print #f2, "					case 0x15:"
	Print #f2, "						// FLIPFLOP _x"
	Print #f2, "						// Opcode: 15 _x"
	Print #f2, "						_x = read_vbyte ();"
	Print #f2, "						flags [_x] = 1 - flags [_x];"
	Print #f2, "						break;"
End If

If actionsUsed (&H16) Then
	print #f2, "					case 0x16:"
	print #f2, "						// MOD FLAG _x, _y"
	print #f2, "						// Opcode: 16 _x _y"
	print #f2, "						readvxy ();"
	print #f2, "						flags [_x] %= _y;"
	print #f2, "						break;"
End If

If actionsUsed (&H17) Then
	Print #f2, "					case 0x17:"
	Print #f2, "						// DECRANGE sc_n, _x, _y"
	Print #f2, "						sc_n = read_vbyte ();"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [sc_n] = flags [sc_n] > _x ? flags [sc_n] - 1 : _y;"
	Print #f2, "						break;"
End If

If actionsUsed (&H18) Then
	Print #f2, "					case 0x18:"
	Print #f2, "						// INCRANGE sc_n, _x, _y"
	Print #f2, "						sc_n = read_vbyte ();"
	Print #f2, "						readvxy ();"
	Print #f2, "						flags [sc_n] = flags [sc_n] < _y ? flags [sc_n] + 1 : _x;"
	Print #f2, "						break;"
End If

If actionsUsed (&H19) Or actionsUsed (&H1A) Then
	Print #f2, "					case 0x19:"
	Print #f2, "					case 0x1a:"
	Print #f2, "						flags [read_vbyte ()] = sc_n & 1;"
	Print #f2, "						break;"
End If

If actionsUsed (&H20) Then
	Print #f2, "					case 0x20:"
	Print #f2, "						// SET TILE (_x, _y) = sc_n"
	Print #f2, "						// Opcode: 20 _x _y sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						_t = read_vbyte ();"
	Print #f2, "						set_map_tile ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H30) Then
	Print #f2, "					case 0x30:"
	Print #f2, "						// INC LIFE sc_n"
	Print #f2, "						// Opcode: 30 sc_n"
	Print #f2, "						plife += read_vbyte ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H31) Then
	Print #f2, "					case 0x31:"
	Print #f2, "						// DEC LIFE sc_n"
	Print #f2, "						// Opcode: 31 sc_n"
	Print #f2, "						plife -= read_vbyte ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H32) Then
	Print #f2, "					case 0x32:"
	Print #f2, "						// FLICKER"
	Print #f2, "						// Opcode: 32"
	Print #f2, "						pflickers = 100;"
	Print #f2, "						break;"
End If


If actionsUsed (&H40) Then
	Print #f2, "					case 0x40:"
	Print #f2, "						// INC OBJECTS sc_n"
	Print #f2, "						// Opcode: 40 sc_n"
	Print #f2, "						pobjs += read_vbyte ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H41) Then
	Print #f2, "					case 0x41:"
	Print #f2, "						// DEC OBJECTS sc_n"
	Print #f2, "						// Opcode: 41 sc_n"
	Print #f2, "						pobjs -= read_vbyte ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H50) then
	Print #f2, "					case 0x50:"
	Print #f2, "						// PRINT_TILE_AT (_x, _y) = sc_n"
	Print #f2, "						// Opcode: 50 _x _y sc_n"
	Print #f2, "						readvxy ();"
	Print #f2, "						_t = read_vbyte ();"
	Print #f2, "						draw_tile ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H51) Then
	Print #f2, "					case 0x51:"
	Print #f2, "						// SET_FIRE_ZONE x1, y1, x2, y2"
	Print #f2, "						// Opcode: 51 x1 y1 x2 y2"
	Print #f2, "						fzx1 = read_byte ();"
	Print #f2, "						fzy1 = read_byte ();"
	Print #f2, "						fzx2 = read_byte ();"
	Print #f2, "						fzy2 = read_byte ();"
	Print #f2, "						f_zone_ac = 1;"
	Print #f2, "						break;"
End If

If actionsUsed (&H68) Then
	Print #f2, "					case 0x68:"
	Print #f2, "						// SETXY _x _y"
	Print #f2, "						reloc_player ();"	
	Print #f2, "						break;"
End If

If actionsUsed (&H6A) Then
	Print #f2, "					case 0x6A:"
	Print #f2, "						// SETY _y"
	Print #f2, "						// Opcode: 6B _y"
	Print #f2, "						py = read_vbyte () << 10;"
	Print #f2, "						stop_player ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H6B) Then
	Print #f2, "					case 0x6B:"
	Print #f2, "						// SETX _x"
	Print #f2, "						// Opcode: 6B _x"
	Print #f2, "						px = read_vbyte () << 10;"
	Print #f2, "						stop_player ();"
	Print #f2, "						break;"
End If

'' TODO
If actionsUsed (&H6C) Then
	Print #f2, "					case 0x6C:"
	Print #f2, "						// REPOSTN _x _y"
	Print #f2, "						// Opcode: 6C _x _y"
	Print #f2, "						do_respawn = 0;"
	Print #f2, "						reloc_player ();"
	Print #f2, "						on_pant = 99;"
	Print #f2, "						sc_terminado = 1;"
	Print #f2, "						break;"
End If
'' EOTODO

If actionsUsed (&H6D) Then
	Print #f2, "					case 0x6D:"
	Print #f2, "						// WARP_TO sc_n _x _y"
	Print #f2, "						// Opcode: 6D sc_n"
	Print #f2, "						n_pant = read_vbyte ();"
	Print #f2, "						on_pant = 99;"
	Print #f2, "						reloc_player ();"
	Print #f2, "						return;"
End If

'If actionsUsed (&H6E) Then
'	Print #f2, "					case 0x6E:"
'	Print #f2, "						// REDRAW"
'	Print #f2, "						// Opcode: 6E"
'	Print #f2, "						draw_scr_background ();"
'	Print #f2, "#ifdef ENABLE_FLOATING_OBJECTS"
'	Print #f2, "						FO_paint_all ();"
'	Print #f2, "#endif"
'	Print #f2, "						break;"
'End If

' New implementation (testing ...)
'If actionsUsed (&H6E) Then
'	Print #f2, "					case 0x6E:"
'	Print #f2, "						// REDRAW"
'	Print #f2, "						// Opcode: 6E"
'	Print #f2, "						_x = _y = 0;"
'	Print #f2, "						for (sc_c = 0; sc_c < 192; sc_c ++) {"
'	Print #f2, "							update_tile (_x, _y, map_attr [sc_c], map_buff [sc_c]);"
'	Print #f2, "							_x ++; If (_x == 15) { _x = 0; _y ++; }"
'	Print #f2, "						}"
'	Print #f2, "#ifdef ENABLE_FLOATING_OBJECTS"
'	Print #f2, "						FO_paint_all ();"
'	Print #f2, "#endif"
'	Print #f2, "						break;"
'End If

' URM this will look ugly but...
If actionsUsed (&H6E) Then
	Print #f2, "					case 0x6e:"
	Print #f2, "						// redraw"
	Print #f2, "						// opcode: 6e"
	Print #f2, "						draw_scr_buffer ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H6F) Then
	Print #f2, "					case 0x6F:"
	Print #f2, "						// REENTER"
	Print #f2, "						// Opcode: 6F"
	Print #f2, "						//do_respawn = 0;"
	Print #f2, "						on_pant = 99; "
	Print #f2, "						return;"
End If

'' TODO
If actionsUsed (&H70) Then
	Print #f2, "					case 0x70:"
	Print #f2, "						// SET_TIMER a, b"
	Print #f2, "						// Opcode: 0x70 a b"
	Print #f2, "						ctimer_t = read_vbyte ();"
	Print #f2, "						ctimer_frames = read_vbyte ();"
	Print #f2, "						ctimer_count = ctimer_zero = 0;"
	Print #f2, "						break;"
End If

If actionsUsed (&H71) Then
	Print #f2, "					case 0x71:"
	Print #f2, "						// TIMER_START"
	Print #f2, "						// Opcode: 0x71"
	Print #f2, "						ctimer_on = 1;"
	Print #f2, "						break;"
End If

If actionsUsed (&H72) Then
	Print #f2, "					case 0x72:"
	Print #f2, "						// TIMER_START"
	Print #f2, "						// Opcode: 0x72"
	Print #f2, "						ctimer_on = 0;"
	Print #f2, "						break;"
End If

If actionsUsed (&H73) Then
	Print #f2, "					case 0x73:"
	Print #f2, "						// REHASH"
	Print #f2, "						// Opcode: 73"
	Print #f2, "						do_respawn = 0;"
	Print #f2, "						on_pant = 99; "
	Print #f2, "						sc_terminado = 1;"
	Print #f2, "						no_draw = 1;"
	Print #f2, "						return;"
End If

If actionsUsed (&H80) Then
	Print #f2, "					case 0x80:"
	Print #f2, "						// ENEM n ON"
	Print #f2, "						// Opcode: 0x80 n"
	Print #f2, "						en_t [read_vbyte ()] &= 0xf7;"
	Print #f2, "						break;"
End If

If actionsUsed (&H81) Then
	Print #f2, "					case 0x81:"
	Print #f2, "						// ENEM n OFF"
	Print #f2, "						// Opcode: 0x81 n"
	Print #f2, "						en_t [read_vbyte ()] |= 0x08;"
	Print #f2, "						break;"
End If

If actionsUsed (&H82) Then
	Print #f2, "					case 0x82:"
	Print #f2, "						// ADD_FLOATING_OBJECT n, x, y"
	Print #f2, "						sc_n = read_byte ();"
	Print #f2, "						readvxy ();"
	Print #f2, "						sc_m = FO_add (_x, _y, sc_n);"
	Print #f2, "						FO_paint (sc_m);"
	Print #f2, "						break;"
End If

If actionsUsed (&H86) Then
	Print #f2, "					case 0x86:"
	Print #f2, "						// ADD_CONTAINER f, x, y"
	Print #f2, "						sc_n = read_vbyte (); readvxy ();"
	Print #f2, "						containers_add ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H87) Then
	Print #f2, "					case 0x87:"
	Print #f2, "						// SHOW_CONTAINERS"
	Print #f2, "						containers_draw ();"
	Print #f2, "						break;"
End If

If actionsUsed (&H83) Then
	Print #f2, "					case 0x83:"
	Print #f2, "						// ENEMY n TYPE t"
	Print #f2, "						en_t [read_vbyte ()] = read_vbyte ();"
	Print #f2, "						break;"
End If

'' TODO
If actionsUsed (&H84) Then
	Print #f2, "					case 0x84:"
	Print #f2, "						// ENEMIES RESTORE"
	Print #f2, "						for (sc_n = 0; sc_n < 3; sc_n ++) {"
	Print #f2, "							enoffsmasi = enoffs + sc_n;"
	Print #f2, "							baddies [enoffsmasi].t = enemy_backup [enoffsmasi];"
	Print #f2, "							en_an_base_frame [sc_n] = (baddies [enoffsmasi].t & 3) << 1;"
	Print #f2, "						}"
	Print #f2, "						break;" 
End If

If actionsUsed (&H85) Then
	Print #f2, "					case 0x84:"
	Print #f2, "						// ENEMIES RESTORE ALL"
	Print #f2, "						for (sc_n = 0; sc_n < 3 * MAP_W * MAP_H; sc_n ++) {";
	Print #f2, "							baddies [sc_n].t = enemy_backup [sc_n];"
	Print #f2, "						}"
	Print #f2, "						break;" 
End If
'' TODO

If actionsUsed (&HD0)  Then
	Print #f2, "					case 0xD0:"
	Print #f2, "						// NEXT_LEVEL"
	Print #f2, "						// Opcode: D0"
	Print #f2, "						n_pant ++;"
	Print #f2, "						init_player ();"
	Print #f2, "						break;"
End If
'' EOTODO

If actionsUsed (&HE0) Then
	Print #f2, "					case 0xE0:"
	Print #f2, "						// SOUND sc_n"
	Print #f2, "						// Opcode: E0 sc_n"
	Print #f2, "						SFX_PLAY (read_vbyte ());"
	Print #f2, "						break;"
End If

If actionsUsed (&HE1) Then
	Print #f2, "					case 0xE1:"
	Print #f2, "						// SHOW"
	Print #f2, "						// Opcode: E1"
	Print #f2, "						SCREEN_UPDATE;"
	Print #f2, "						break;"
End If

If actionsUsed (&HE2) Then
	Print #f2, "					case 0xE2:"
	Print #f2, "						// RECHARGE"
	Print #f2, "						plife = LIFE_INI;"
	Print #f2, "						break;"
End If

If actionsUsed (&HE3) Then
	Print #f2, "					case 0xE3:"
	Print #f2, "						_x = LINE_OF_TEXT_X; _y = LINE_OF_TEXT_Y;"
	Print #f2, "						p_s (script_texts [read_vbyte ()]);"
	Print #f2, "						break;"
End If

If actionsUsed (&HEB) Then
	Print #f2, "					case 0xEB:"
	Print #f2, "						// OPENTEXT"
	Print #f2, "						text_box_open (); break;"
End If

If actionsUsed (&HEC) Then
	Print #f2, "					case 0xEC:"
	Print #f2, "						// CLOSETEXT"
	Print #f2, "						text_box_close (); break;"
End If

If actionsUsed (&HED) Then
	Print #f2, "					case 0xED:"
	Print #f2, "						// TEXTWINDOW sc_n"
	Print #f2, "						// Opcode: 0xED sc_n"
	Print #f2, "						_t = read_byte () - 1;"
	Print #f2, "						text_window ();"
	Print #f2, "						break;"
End If

'' TODO
If actionsUsed (&HE4) Then
	Print #f2, "					case 0xE4:"
	Print #f2, "						// EXTERN sc_n"
	Print #f2, "						// Opcode: 0xE4 sc_n"
	Print #f2, "						sc_n = read_byte ();"
	Print #f2, "						do_extern_action ();"
	Print #f2, "						break;"
End IF

If actionsUsed (&HE8) Then
	Print #f2, "					case 0xE8:"
	Print #f2, "						// EXTERN_E sc_n, sc_m"
	Print #f2, "						// Opcode: 0xE8 sc_n, sc_m"
	Print #f2, "						readxy ();"
	Print #f2, "						do_extern_action ();"
	Print #f2, "						break;"
End IF

If actionsUsed (&HE5) Then
	Print #f2, "					case 0xE5:"
	Print #f2, "						// PAUSE sc_n"
	Print #f2, "						// Opcode: 0xE5 sc_n"
	Print #f2, "                        delay (read_vbyte ());"
	Print #f2, "						break;"
End If

If actionsUsed (&HE6) Then
	Print #f2, "					case 0xE6:"
	Print #f2, "						// MUSIC sc_n"
	Print #f2, "						// Opcde: 0xE6 sc_n"
	Print #f2, "                        music_play (read_vbyte ())"
	Print #f2, "						break;"
End If

If actionsUsed (&HE7) Then
	Print #f2, "					case 0xE7:"
	Print #f2, "						// REDRAW_ITEMS"
	Print #f2, "						// Opcode: 0xE7"
	Print #f2, "						display_items ();"
	Print #f2, "						break;"
End If
'' EOTODO

If actionsUsed (&HE9) Then
	Print #f2, "					case 0xE9:"
	Print #f2, "						// SET SAFE n, x, y"
	Print #f2, "						// Opcode: 0xE9 n x y"
	Print #f2, "						safe_n_pant = read_byte ();"
	Print #f2, "						safe_prx = read_byte () << 4;"
	Print #f2, "						safe_pry = read_byte () << 4;"
	Print #f2, "						break;" 
End If

If actionsUsed (&HEA) Then
	Print #f2, "					case 0xEA:"
	Print #f2, "						// SET SAFE HERE"
	Print #f2, "						// Opcode: 0xEA"
	Print #f2, "						player_register_safe_spot ();"
	Print #f2, "						break;" 
End If

If actionsUsed (&HF0) Then
	Print #f2, "					case 0xF0:"
	Print #f2, "						// GAME OVER"
	Print #f2, "						// Opcode: 0xF0"
	Print #f2, "						script_result = 2;"
	Print #f2, "						return;"
End If

If actionsUsed (&HF1) Then
	Print #f2, "					case 0xF1:"
	Print #f2, "						// WIN"
	Print #f2, "						// Opcode: 0xF1"
	Print #f2, "						script_result = 1;"
	Print #f2, "						return;"
End If

If actionsUsed (&HF2) Then
	Print #f2, "					case 0xF2:"
	Print #f2, "						// BREAK"
	Print #f2, "						// Opcode: 0xF2"
	Print #f2, "						return;"
End If

If actionsUsed (&HF3) Then
	Print #f2, "					case 0xF3:"
	Print #f2, "						// Super Ultra Ending"
	Print #f2, "						// Opcode: 0xF3"
	Print #f2, "						script_result = 4;"
	Print #f2, "						return;"
	Print #f2, "						break;"
End If

If actionsUsed (&HF4) Then
	Print #f2, "					case 0xF4:"
	Print #f2, "						// DECORATIONS"
	Print #f2, "						// Opcode: 0xF4 XY T XY T XY T... 0xff"
	Print #f2, "						while (0xff != (_x = read_byte ())) {"
	Print #f2, "							_x = _x >> 4; _y = _x & 0xf; _t = read_byte ();"
	Print #f2, "							set_map_tile ();"
	Print #f2, "						}"
	Print #f2, "						break;"
End If

Print #f2, "					case 0xff:"
Print #f2, "						sc_terminado = 1;"
Print #f2, "						break;"
Print #f2, "				}"
Print #f2, "			}"
Print #f2, "		}"

Print #f2, "		script = next_script;"
Print #f2, "	}"
Print #f2, "}"

close #f3

Print "DONE!"
