; vectorman rom, decompiled/dissassembled with ghidra (version 11 without claude slop)
; w.i.p by ccb357
; going to use sonic 1 as an example 
; disclaimer no ai was used AT ALL. i used an old version with ghidra without the claude stuff 
; and an old genesis loader for ghidra. and if you contribute with claude or any ai, then fuck you.
StartOfRom:
Vectors:
           dc.l SSP
           dc.l Reset
           dc.l BusErr
           dc.l AdrErr
           dc.l InvOpCode
           dc.l DivBy0
           dc.l Check
           dc.l TrapV
           dc.l GPF                                  
           dc.l Trace                                
           dc.l Reserv0                              
           dc.l Reserv1
           dc.l Reserv2                              
           dc.l Reserv3
           dc.l Reserv4
           dc.l BadInt
           dc.l Reserv10
           dc.l Reserv11
           dc.l Reserv12
           dc.l Reserv13
           dc.l Reserv14
           dc.l Reserv15
           dc.l Reserv16
           dc.l Reserv17
           dc.l BadIRQ
           dc.l IRQ1
           dc.l EXT
           dc.l IRQ3
           dc.l HBLANK        ; doesnt exist for some reason
           dc.l IRQ5
           dc.l VBLANK
           dc.l IRQ7
           dc.l Trap0
           dc.l Trap1
           dc.l Trap2
           dc.l Trap3
           dc.l Trap4
           dc.l Trap5
           dc.l Trap6
           dc.l Trap7
           dc.l Trap8
           dc.l Trap9
           dc.l Trap10
           dc.l Trap11
           dc.l Trap12
           dc.l Trap13
           dc.l Trap14
           dc.l Trap15
           dc.l Reserv30
           dc.l Reserv31
           dc.l Reserv32
           dc.l Reserv33
           dc.l Reserv34
           dc.l Reserv35
           dc.l Reserv36
           dc.l Reserv37
           dc.l Reserv38
           dc.l Reserv39
           dc.l Reserv3A
           dc.l Reserv3B
           dc.l Reserv3C
           dc.l Reserv3D
           dc.l Reserv3E
           dc.l Reserv3F



        dc.b "SEGA GENESIS "	; ConsoleName
		dc.b "(C)SEGA 1995.AUG"	; ReleaseDate
		dc.b "VECTORMAN                "		; DomesticName
		dc.b "VECTORMAN                "		; InternationalName
		dc.b "GM MK-1577 -00"	; Version    

Checksum:
		dc.w $E039				; checksum
		dc.b "J               "	; I/O support
		dc.l StartOfRom			; start of the rom 00000000
RomEndLoc:
        dc.l EndOfRom		; 001FFFFF
        dc.l $FF0000		; the start and end of the ram for sega genesis game is ALWAYS 0000-FFFF
		dc.l $FFFFFF
        dc.b "                                                    " ; sram code but its empty for some reason
        dc.l $20202020      ; unused idk why but its also unused for sonic 1
        dc.l $20202020		; SRAM start 
		dc.l $20202020		; SRAM end 	
        dc.b "                                                    " ; Notes
        ;... what the hell is region F?
        dc.b "F            " ; region
EndOfHeader:
;----HERE WE GO!----;
Reset:
; in sonic 1, this is called EntryPoint
       tst.l   (IO_CT1_CTRL).l
       bne.s	PortA_Ok ; named it the same as sonic 1
       tst.w   (IO_EXT_CTRL).l                              

 

PortA_Ok: ; copied from sonic 1 shrug.. ok so the rest is just copied from sonic 1 (i checked the disassembled code in ghidra, so..)
		bne.s	SkipSetup ; Skip the VDP and Z80 setup code if port A, B or C is ok...?
		lea		SetupValues(pc),a5	; Load setup values array address.
		movem.w	(a5)+,d5-d7
		movem.l	(a5)+,a0-a4
		move.b	-$10FF(a1),d0	; get hardware version (from $A10001)
		andi.b	#$F,d0
		beq.s	SkipSecurity	; If the console has no TMSS, skip the security stuff.
		move.l	#'SEGA',$2F00(a1) ; move "SEGA" to TMSS register ($A14000)

        ; eof, uncompilable




