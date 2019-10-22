;this file for FamiTone2 library generated by text2data tool

music_music_data:
	.byte 1
	.word @instruments
	.word @samples-3
	.word @song0ch0,@song0ch1,@song0ch2,@song0ch3,@song0ch4,307,256

@instruments:
	.byte $f0 ;instrument $00
	.word @env1,@env0,@env5
	.byte $00
	.byte $30 ;instrument $08
	.word @env2,@env4,@env0
	.byte $00
	.byte $f0 ;instrument $09
	.word @env3,@env0,@env0
	.byte $00

@samples:
@env0:
	.byte $c0,$00,$00
@env1:
	.byte $c8,$00,$00
@env2:
	.byte $c5,$c5,$c4,$c4,$c3,$c0,$00,$05
@env3:
	.byte $cb,$02,$c9,$c6,$02,$c0,$00,$05
@env4:
	.byte $c6,$c6,$c0,$00,$02
@env5:
	.byte $c0,$0b,$c1,$c2,$c3,$c4,$c3,$c2,$c1,$c0,$00,$02


@song0ch0:
	.byte $fb,$06
@song0ch0loop:
@ref0:
	.byte $f9,$85
@ref1:
	.byte $f9,$85
@ref2:
	.byte $80,$22,$87,$00,$84,$22,$22,$24,$24,$24,$2a,$2a,$2a,$24,$2a,$80
	.byte $22,$87,$00,$84,$22,$22,$24,$2a,$30,$2a,$30,$32,$2c,$2a,$80,$22
	.byte $87,$00,$84,$22,$22,$24,$24,$24,$2a,$2a,$2a,$24,$2a,$80,$22,$87
	.byte $00,$84,$22,$22,$3c,$44,$3c,$44,$42,$3a,$42,$3a
	.byte $ff,$34
	.word @ref2
@ref4:
	.byte $bf,$80,$5e,$60,$8b,$5c,$85,$5b,$00,$a1
@ref5:
	.byte $22,$87,$00,$84,$22,$22,$24,$24,$24,$2a,$2a,$2a,$24,$2a,$80,$22
	.byte $87,$00,$84,$22,$22,$24,$2a,$30,$2a,$30,$32,$2c,$2a,$80,$22,$87
	.byte $00,$84,$22,$22,$24,$24,$24,$2a,$2a,$2a,$24,$2a,$80,$22,$87,$00
	.byte $84,$22,$22,$3c,$44,$3c,$44,$42,$3a,$42,$3a
	.byte $ff,$34
	.word @ref2
@ref7:
	.byte $80,$22,$85,$23,$3b,$3c,$85,$23,$37,$3a,$85,$23,$33,$36,$85,$23
	.byte $84,$31,$33,$31,$2d,$2a,$81
	.byte $ff,$15
	.word @ref7
	.byte $ff,$15
	.word @ref7
@ref10:
	.byte $80,$22,$85,$23,$3b,$3c,$85,$23,$37,$3a,$85,$23,$84,$3d,$43,$49
	.byte $4f,$55,$80,$52,$9d,$00,$9d
	.byte $ff,$34
	.word @ref5
	.byte $ff,$34
	.word @ref2
	.byte $ff,$15
	.word @ref7
	.byte $ff,$15
	.word @ref7
	.byte $ff,$15
	.word @ref7
	.byte $ff,$14
	.word @ref10
@ref17:
	.byte $32,$85,$36,$85,$3a,$85,$3c,$85,$42,$85,$44,$85,$48,$85,$48,$a5
	.byte $00,$9d
	.byte $fd
	.word @song0ch0loop

@song0ch1:
@song0ch1loop:
@ref18:
	.byte $f9,$85
@ref19:
	.byte $f9,$85
@ref20:
	.byte $f9,$85
@ref21:
	.byte $80,$30,$87,$00,$93,$30,$87,$00,$93,$30,$87,$00,$93,$30,$87,$00
	.byte $83,$84,$44,$4a,$44,$4a,$48,$42,$48,$42
@ref22:
	.byte $bf,$80,$50,$52,$8b,$4f,$84,$44,$42,$4a,$42,$3a,$a1
	.byte $ff,$18
	.word @ref21
	.byte $ff,$18
	.word @ref21
@ref25:
	.byte $80,$30,$85,$00,$c5
@ref26:
	.byte $30,$85,$00,$c5
@ref27:
	.byte $84,$22,$85,$23,$43,$44,$85,$23,$3d,$42,$85,$23,$3b,$3c,$85,$23
	.byte $37,$3b,$37,$33,$30,$81
@ref28:
	.byte $80,$30,$85,$84,$23,$43,$44,$85,$23,$3d,$42,$85,$23,$45,$49,$4f
	.byte $55,$5d,$80,$5a,$9d,$00,$9d
@ref29:
	.byte $30,$87,$00,$93,$30,$87,$00,$93,$30,$87,$00,$93,$30,$87,$00,$83
	.byte $84,$44,$4a,$44,$4a,$48,$42,$48,$42
	.byte $ff,$18
	.word @ref21
	.byte $ff,$04
	.word @ref25
@ref32:
	.byte $30,$85,$00,$c5
	.byte $ff,$15
	.word @ref27
	.byte $ff,$14
	.word @ref28
@ref35:
	.byte $3a,$85,$3c,$85,$42,$85,$44,$85,$48,$85,$4a,$85,$50,$85,$52,$a5
	.byte $00,$9d
	.byte $fd
	.word @song0ch1loop

@song0ch2:
@song0ch2loop:
@ref36:
	.byte $80,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22
	.byte $00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22
	.byte $00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22
	.byte $00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22
	.byte $00
@ref37:
	.byte $22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00
	.byte $22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00
	.byte $22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00
	.byte $22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00
	.byte $ff,$40
	.word @ref37
	.byte $ff,$40
	.word @ref37
	.byte $ff,$40
	.word @ref37
	.byte $ff,$40
	.word @ref37
	.byte $ff,$40
	.word @ref37
@ref43:
	.byte $22,$85,$3b,$31,$24,$85,$3b,$1f,$22,$85,$3b,$1b,$1e,$85,$3b,$31
	.byte $33,$31,$23,$22,$81
	.byte $ff,$15
	.word @ref43
	.byte $ff,$15
	.word @ref43
@ref46:
	.byte $22,$85,$3b,$31,$24,$85,$3b,$1f,$22,$85,$3b,$1b,$1e,$85,$3b,$31
	.byte $3a,$9d,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00,$22,$00
	.byte $22,$00
	.byte $ff,$40
	.word @ref37
	.byte $ff,$40
	.word @ref37
	.byte $ff,$15
	.word @ref43
	.byte $ff,$15
	.word @ref43
	.byte $ff,$15
	.word @ref43
	.byte $ff,$22
	.word @ref46
@ref53:
	.byte $3a,$85,$3a,$85,$22,$85,$22,$85,$3a,$85,$3a,$85,$22,$85,$22,$c5
	.byte $fd
	.word @song0ch2loop

@song0ch3:
@song0ch3loop:
@ref54:
	.byte $82,$21,$09,$20,$20,$09,$20,$20,$08,$21,$20,$09,$21,$09,$20,$20
	.byte $09,$20,$20,$08,$21,$20,$09,$21,$09,$20,$20,$09,$20,$20,$08,$21
	.byte $20,$09,$21,$09,$20,$20,$09,$20,$20,$08,$21,$08,$08,$08
@ref55:
	.byte $21,$09,$20,$20,$09,$20,$20,$08,$21,$20,$09,$21,$09,$20,$20,$09
	.byte $20,$20,$08,$21,$20,$09,$21,$09,$20,$20,$09,$20,$20,$08,$21,$20
	.byte $09,$21,$09,$20,$20,$09,$20,$20,$08,$21,$08,$08,$08
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
@ref61:
	.byte $21,$09,$20,$20,$09,$20,$20,$08,$21,$20,$09,$21,$09,$20,$20,$09
	.byte $20,$20,$08,$21,$20,$09,$09,$09,$08,$20,$08,$81
	.byte $ff,$1c
	.word @ref61
	.byte $ff,$1c
	.word @ref61
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$2d
	.word @ref55
	.byte $ff,$1c
	.word @ref61
	.byte $ff,$1c
	.word @ref61
	.byte $ff,$1c
	.word @ref61
@ref70:
	.byte $21,$09,$20,$20,$09,$20,$20,$08,$21,$20,$09,$21,$09,$20,$20,$09
	.byte $20,$20,$08,$21,$20,$09,$09,$09,$08,$20,$09,$20,$20,$08,$21,$20
	.byte $09,$21,$09,$20,$20,$09,$20,$20,$08,$21,$08,$08,$08
@ref71:
	.byte $09,$13,$09,$13,$07,$13,$07,$13,$05,$13,$05,$13,$21,$13,$21,$12
	.byte $a1,$21,$09,$20,$20,$09,$20,$20,$08,$21,$08,$08,$08
	.byte $fd
	.word @song0ch3loop

@song0ch4:
@song0ch4loop:
@ref72:
	.byte $f9,$85
@ref73:
	.byte $f9,$85
@ref74:
	.byte $f9,$85
@ref75:
	.byte $f9,$85
@ref76:
	.byte $f9,$85
@ref77:
	.byte $f9,$85
@ref78:
	.byte $f9,$85
@ref79:
	.byte $cf
@ref80:
	.byte $cf
@ref81:
	.byte $cf
@ref82:
	.byte $f9,$85
@ref83:
	.byte $f9,$85
@ref84:
	.byte $f9,$85
@ref85:
	.byte $cf
@ref86:
	.byte $cf
@ref87:
	.byte $cf
@ref88:
	.byte $f9,$85
@ref89:
	.byte $f9,$85
	.byte $fd
	.word @song0ch4loop
