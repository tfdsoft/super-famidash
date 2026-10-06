;;
;; CONFIG
;;
.define SE_ZEROPAGE_SEGMENT ZEROPAGE
.define SE_BSS_SEGMENT      BSS
.define SE_BSS_ADDR_TYPE    
.define SE_ENGINE_SEGMENT   SNIPERENGINE











;; 
;; you shouldn't have to touch anything below this.
;;

.importzp __rc0,  __rc1,  __rc2,  __rc3,  __rc4,  __rc5,  __rc6,  __rc7
.importzp __rc8,  __rc9,  __rc10, __rc11, __rc12, __rc13, __rc14, __rc15
.importzp __rc16, __rc17, __rc18, __rc19, __rc20, __rc21, __rc22, __rc23
.importzp __rc24, __rc25, __rc26, __rc27, __rc28, __rc29, __rc30, __rc31

.include "snes.inc"

.segment .string(SE_ZEROPAGE_SEGMENT)
    se_v_frame_count:       .res 1
    se_v_vram_update:       .res 1
    se_v_palette_update:    .res 1

.segment .string(SE_BSS_SEGMENT) ;: SE_BSS_ADDR_TYPE

    se_v_palette_buffer:    .res 512

    se_v_ppu_inidisp_var:   .res 1
    se_v_ppu_objsel_var:    .res 1
    se_v_ppu_bgmode_var:    .res 1
    se_v_ppu_bgXsc_var:     .res 4
    se_v_ppu_bg12nba_var:   .res 1
    se_v_ppu_bg34nba_var:   .res 1

    se_v_cpu_nmitimen_var:  .res 1


.segment .string(SE_ENGINE_SEGMENT)
    ; every sniperengine instance starts with a jump table lmao

    ;; INIT
    jmp se_init

    ;; PPU ROUTINES
    jmp se_wait_vsync

    jmp se_ppu_disable_nmi
    jmp SE_CPU_ENABLE_NMI

    jmp se_ppu_disable_rendering
    jmp se_ppu_enable_rendering

    jmp se_ppu_set_screen_brightness
    jmp se_ppu_fade_screen_brightness

    jmp se_ppu_set_palette_color
    jmp se_ppu_set_palette_set
    jmp se_ppu_clear_palette




    .align 128  ; SNESMOD STUFF

    jmp spcBoot
	
	jmp spcSetBank
	jmp spcLoad
	jmp spcTest
	jmp spcPlay
	jmp spcStop
	jmp spcReadStatus
	jmp spcReadPosition
	jmp spcGetCues

	jmp spcSetModuleVolume
	jmp spcFadeModuleVolume
	jmp spcLoadEffect
	jmp spcEffect

	jmp spcFlush
	jmp spcProcess

	jmp spcSetSoundTable
	jmp spcAllocateSoundRegion
	jmp spcPlaySound
	jmp spcPlaySoundV
	jmp spcPlaySoundEx


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_identity_table
    ;;  description: every hex digit, from 0-255, in a table.
    ;;      starts at (SE_BASE_ADDRESS + $100)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .align 256
    .export se_identity_table
    se_identity_table:
        .byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
        .byte $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f
        .byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f
        .byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f
        .byte $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f
        .byte $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5a,$5b,$5c,$5d,$5e,$5f
        .byte $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f
        .byte $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$7b,$7c,$7d,$7e,$7f
        .byte $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$8f
        .byte $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9a,$9b,$9c,$9d,$9e,$9f
        .byte $a0,$a1,$a2,$a3,$a4,$a5,$a6,$a7,$a8,$a9,$aa,$ab,$ac,$ad,$ae,$af
        .byte $b0,$b1,$b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9,$ba,$bb,$bc,$bd,$be,$bf
        .byte $c0,$c1,$c2,$c3,$c4,$c5,$c6,$c7,$c8,$c9,$ca,$cb,$cc,$cd,$ce,$cf
        .byte $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$db,$dc,$dd,$de,$df
        .byte $e0,$e1,$e2,$e3,$e4,$e5,$e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef
        .byte $f0,$f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$fc,$fd,$fe,$ff

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_sine_table
    ;;  description: a sine wave represented by 256 hex digits.
    ;;      starts at (SE_BASE_ADDRESS + $200)
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .align 256
    .export se_sine_table
    se_sine_table:
        .byte $80,$83,$86,$89,$8c,$8f,$92,$95,$98,$9b,$9e,$a2,$a5,$a7,$aa,$ad
        .byte $b0,$b3,$b6,$b9,$bc,$be,$c1,$c4,$c6,$c9,$cb,$ce,$d0,$d3,$d5,$d7
        .byte $da,$dc,$de,$e0,$e2,$e4,$e6,$e8,$ea,$eb,$ed,$ee,$f0,$f1,$f3,$f4
        .byte $f5,$f6,$f8,$f9,$fa,$fa,$fb,$fc,$fd,$fd,$fe,$fe,$fe,$ff,$ff,$ff
        .byte $ff,$ff,$ff,$ff,$fe,$fe,$fe,$fd,$fd,$fc,$fb,$fa,$fa,$f9,$f8,$f6
        .byte $f5,$f4,$f3,$f1,$f0,$ee,$ed,$eb,$ea,$e8,$e6,$e4,$e2,$e0,$de,$dc
        .byte $da,$d7,$d5,$d3,$d0,$ce,$cb,$c9,$c6,$c4,$c1,$be,$bc,$b9,$b6,$b3
        .byte $b0,$ad,$aa,$a7,$a5,$a2,$9e,$9b,$98,$95,$92,$8f,$8c,$89,$86,$83
        .byte $80,$7c,$79,$76,$73,$70,$6d,$6a,$67,$64,$61,$5d,$5a,$58,$55,$52
        .byte $4f,$4c,$49,$46,$43,$41,$3e,$3b,$39,$36,$34,$31,$2f,$2c,$2a,$28
        .byte $25,$23,$21,$1f,$1d,$1b,$19,$17,$15,$14,$12,$11,$0f,$0e,$0c,$0b
        .byte $0a,$09,$07,$06,$05,$05,$04,$03,$02,$02,$01,$01,$01,$00,$00,$00
        .byte $00,$00,$00,$00,$01,$01,$01,$02,$02,$03,$04,$05,$05,$06,$07,$09
        .byte $0a,$0b,$0c,$0e,$0f,$11,$12,$14,$15,$17,$19,$1b,$1d,$1f,$21,$23
        .byte $25,$28,$2a,$2c,$2f,$31,$34,$36,$39,$3b,$3e,$41,$43,$46,$49,$4c
        .byte $4f,$52,$55,$58,$5a,$5d,$61,$64,$67,$6a,$6d,$70,$73,$76,$79,$7c

    .align 256
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_init
    ;;  description: initializes cpu regs, ppu regs,
    ;;      engine memory
    ;;  arguments:  none
    ;;  clobbers:   A,X,DP
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_init
        php

        ;; INIT CPU REGISTERS ;;
        seta16
        lda #$4200
        tcd ; move direct page to S-CPU I/O area
        lda #$FF00
        sta NMITIMEN    ; and WRIO
        stz NMITIMEN    ; and WRIO
        stz WRMPYA  ; and WRMPYB
        stz WRDIVL  ; and WRDIVH
        stz WRDIVB  ; and HTIMEL
        stz HTIMEH  ; and VTIMEL
        stz VTIMEH  ; and MDMAEN
        sta HDMAEN  ; and MEMSEL. enables FastROM

        ;; INIT PPU REGISTERS ;;
        lda #$2100
        tcd ; move direct page to PPU I/O area
        lda #$0080
        sta INIDISP ; and OBJSEL. turns on forced blank
        stz OAMADDL ; and OAMADDH
        stz BGMODE  ; and MOSAIC
        stz BG1SC   ; and BG2SC
        stz BG3SC   ; and BG4SC
        stz BG12NBA ; and BG34NBA
        stz VMADDL  ; and VMADDH
        stz W34SEL  ; and WOBJSEL
        stz WH0     ; and WH1
        stz WH2     ; and WH3
        stz WBGLOG  ; and WOBJLOG
        stz TM      ; and TS
        stz TMW     ; and TSW
        ; these registers need 8-bit writes
        seta8
        sta VMAIN
        stz M7SEL
        stz CGADD
        stz W12SEL ; window
        ; scroll registers need double 8-bit writes
        .repeat 8, I
            stz BG1HOFS+I
            stz BG1HOFS+I
        .endrepeat
        ; as do the mode 7 registers, which should be
        ; set to the indentity matrix:
        ; [ $0100   $0000 ]
	    ; [ $0000   $0100 ]
        lda #$01
        stz M7A
        sta M7A
        stz M7B
        stz M7B
        stz M7C
        stz M7C
        stz M7D
        sta M7D
        stz M7X
        stz M7X
        stz M7Y
        stz M7Y

        ; reset direct page back to zeropage
        setaxy16
        lda #$0000
        tcd

        ; return with register sizes intact
        plp
        rtl
    .endproc
    


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_wait_vsync
    ;;  description: halts the cpu until the next nmi finishes
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   A
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_wait_vsync
        php
        seta8
        lda #1
        sta se_v_vram_update
        lda se_v_frame_count
        @wait:
            wai
            cmp se_v_frame_count
            beq @wait
        plp
        rtl
    .endproc
    


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_disable_nmi
    ;;  description: disables the nmi signal.
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   A,P
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_disable_nmi
        seta8
        lda se_v_cpu_nmitimen_var
        and #%01111111
        bra __se_ppu_nmitimen_common
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  SE_CPU_ENABLE_NMI
    ;;  description: enables the nmi signal.
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   A,P
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc SE_CPU_ENABLE_NMI
        seta8
        lda se_v_cpu_nmitimen_var
        ora #%10000000
        ; fall through
    .endproc

    __se_ppu_nmitimen_common:
        sta se_v_cpu_nmitimen_var
        sta NMITIMEN

        rtl



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_disable_rendering
    ;;  description: disables the screen
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   A,P
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_disable_rendering
        seta8
        lda #%10000000
        trb se_v_ppu_inidisp_var
        rtl
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_enable_rendering
    ;;  description: enables the screen
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   A,P
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_enable_rendering
        seta8
        lda #%01111111
        tsb se_v_ppu_inidisp_var
        rtl
    .endproc

    __se_ppu_inidisp_common:
        sta se_v_ppu_inidisp_var

        rtl



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_set_screen_brightness
    ;;  description: set the brightness of the screen.
    ;;  arguments:  A8 (brightness value, 0-15)
    ;;  returns:    none
    ;;  clobbers:   P,__rc2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_set_screen_brightness
        .a8
        ; mask off the higher bits
        and #%00001111
        sta __rc2 ; store to ORA later

        lda se_v_ppu_inidisp_var
        and #%10000000
        ora __rc2
        sta se_v_ppu_inidisp_var
        ;sta INIDISP

        rtl
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_fade_screen_brightness
    ;;  description: fade from one brightness level to another
    ;;  arguments:  A8 (start value), X8 (end value)
    ;;  returns:    none
    ;;  clobbers:   Y,P
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_fade_screen_brightness
        .a8
        .i8
        phy
        ldy __rc20
        phy
        ldy __rc21
        phy 
        stx __rc20 ;to
        sta __rc21 ;from
        jsl se_ppu_set_screen_brightness

        bra @check_equal

        @fade_loop:
            jsl se_wait_vsync

            lda __rc21
            cmp __rc20
            bcs @more

        @less:
            clc
            adc #1
            sta __rc21
            jsl se_ppu_set_screen_brightness
            bra @check_equal

        @more:
            sec
            sbc #1
            sta __rc21
            jsl se_ppu_set_screen_brightness

        @check_equal:
            lda __rc21
            cmp __rc20
            bne @fade_loop

        @done:

        ply
        sty __rc21
        ply
        sty __rc20
        ply

        rtl
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_set_palette_color
    ;;  description: set one palette index to an rgb color
    ;;  arguments:  A16 (rgb color)
    ;;              X8 (palette index)
    ;;  returns:    none
    ;;  clobbers:   X
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_set_palette_color
        .a16
        .i8
        php
        pha
        txa
        asl
        setxy16
        tax
        pla

        sta se_v_palette_buffer, x

        seta8
        inc se_v_palette_update

        plp
        rtl
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_set_palette_set
    ;;  description: set a palette set (16 colors)
    ;;  arguments:  A8 (palette set, 0-15)
    ;;              __rc2-__rc4 (pointer to data, 24-bit)
    ;;  returns:    none
    ;;  clobbers:   X,Y,__rc6-__rc9
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_set_palette_set
        .a8
        setaxy8
        tax ; save set index in X for later

        lda #$7e
        cmp __rc4
        beq @use_block_copy
        ina
        cmp __rc4
        beq @use_block_copy

        ; set up dma channel 7 for transfer
        seta16
        lda quad_asl_lookup_table, x
        and #$00ff
        asl

        clc
        adc #.loword(se_v_palette_buffer)
        sta WMADDL
        ldx #^se_v_palette_buffer
        stx WMADDH

        ldx #DMA_LINEAR|DMA_FORWARD
        stx DMAMODE+$70
        ldx #.lobyte(WMDATA)
        stx DMAPPUREG+$70
        lda __rc2
        sta DMAADDR+$70
        ldx __rc4
        stx DMAADDRBANK+$70
        lda #32
        sta DMALEN+$70

        ldx #%10000000
        stx COPYSTART
        bra @exit


        @use_block_copy:
        ; set up registers for transfer
        lda #$54    ; MVP
        sta __rc6
        lda #^se_v_palette_buffer   ; destination bank
        sta __rc7
        lda __rc4   ; source bank
        sta __rc8
        lda #$60    ; RTS
        sta __rc9


        lda quad_asl_lookup_table, x
        setaxy16
        and #$00ff
        asl

        clc
        adc #.loword(se_v_palette_buffer)
        tay

        ldx __rc2

        lda #$001f

        phb
        jsr __rc6
        plb
        
        @exit:
        seta8
        inc se_v_palette_update

        rtl
    .endproc



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_clear_palette
    ;;  description: set whole palette to black
    ;;  arguments:  none
    ;;  returns:    none
    ;;  clobbers:   
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_clear_palette
        ; set up dma channel 7 for transfer
        seta16
        setxy8

        lda #.loword(se_v_palette_buffer)
        sta WMADDL
        ldx #^se_v_palette_buffer
        stx WMADDH

        ldx #DMA_LINEAR|DMA_CONST
        stx DMAMODE+$70
        ldx #.lobyte(WMDATA)
        stx DMAPPUREG+$70
        lda #.loword(se_identity_table)
        sta DMAADDR+$70
        ldx #^se_identity_table
        stx DMAADDRBANK+$70
        lda #512
        sta DMALEN+$70

        ldx #%10000000
        stx COPYSTART

        rtl
    .endproc














	__se_get_controllers:
		




    .export nmi
    .proc nmi
        phb
		; not needed anymore due to exhirom
        ; jml @goto_fastrom
        ; @goto_fastrom:
        pha
        phx
        phy
        php
        setaxy8
        bit NMISTATUS

        ; disable rendering on the ppu side
        stz INIDISP

        ; is rendering enabled on the engine side?
        lda se_v_ppu_inidisp_var
        bmi @skip_all_updates   ; if not, skip everything

            ;; START OF VRAM UPDATES
            lda se_v_palette_update
            beq @skip_palette_update

                ;; ok so we need to DMA the updated
                ;; palette using channel 7
                stz CGADD
                seta16
                setxy8
                ldx #DMA_00|DMA_FORWARD
                stx DMAMODE+$70
                ldx #.lobyte(CGDATA)
                stx DMAPPUREG+$70
                lda #.loword(se_v_palette_buffer)
                sta DMAADDR+$70
                ldx #^se_v_palette_buffer
                stx DMAADDRBANK+$70
                lda #512
                sta DMALEN+$70

                ldx #%10000000
                stx COPYSTART

                stz se_v_palette_update

            @skip_palette_update:

            

        @skip_all_updates:

        lda se_v_ppu_inidisp_var
        sta INIDISP
        
        inc se_v_frame_count

        plp
        ply
        plx
        pla
        plb
        rti
    .endproc


    .export irq
    .proc irq
        bit $4211
        rti
    .endproc




    quad_asl_lookup_table:
        .byte $00, $10, $20, $30, $40, $50, $60, $70
        .byte $80, $90, $a0, $b0, $c0, $d0, $e0, $f0
















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  SNESMOD



;*
;* Copyright 2009 Mukunda Johnson (mukunda.com)
;* 
;* This file is part of SNESMOD - gh.mukunda.com/snesmod
;*
;* See LICENSING.txt
;*

;.include "snes.inc"

.export spcBoot
.export spcSetBank
.export spcLoad
.export spcTest
.export spcPlay
.export spcStop
.export spcReadStatus
.export spcReadPosition
.export spcGetCues

.export spcSetModuleVolume
.export spcFadeModuleVolume
.export spcLoadEffect
.export spcEffect

.export spcFlush
.export spcProcess

.export spcSetSoundTable
.export spcAllocateSoundRegion
.export spcPlaySound
.export spcPlaySoundV
.export spcPlaySoundEx

;.import CART_HEADER

;----------------------------------------------------------------------
; soundbank defs
;----------------------------------------------------------------------

;.ifdef HIROM
SB_SAMPCOUNT	=0000h
SB_MODCOUNT	=0002h
SB_MODTABLE	=0004h
SB_SRCTABLE	=0184h
;.else
;SB_SAMPCOUNT	=8000h
;SB_MODCOUNT	=8002h
;SB_MODTABLE	=8004h
;SB_SRCTABLE	=8184h
;.endif

;----------------------------------------------------------------------
; spc commands
;----------------------------------------------------------------------

CMD_LOAD	=00h
CMD_LOADE	=01h
CMD_VOL		=02h
CMD_PLAY	=03h
CMD_STOP	=04h
CMD_MVOL	=05h
CMD_FADE	=06h
CMD_RES		=07h
CMD_FX		=08h
CMD_TEST	=09h
CMD_SSIZE	=0Ah

;----------------------------------------------------------------------

; process for 5 scanlines
PROCESS_TIME = 5
INIT_DATACOPY =13

;======================================================================
.zeropage
;======================================================================

spc_ptr:	.res 3
spc_v:		.res 1
spc_bank:	.res 1

spc1:		.res 2
spc2:		.res 2

spc_fread:	.res 1
spc_fwrite:	.res 1

; port record [for interruption]
spc_pr:		.res 4

digi_src:	.res 3
digi_src2:	.res 3

SoundTable:	.res 3

;======================================================================
.bss
;======================================================================

spc_fifo:	.res 256	; 128-byte command fifo
spc_sfx_next:	.res 1
spc_q:		.res 1

digi_init:	.res 1
digi_pitch:	.res 1
digi_vp:	.res 1
digi_remain:	.res 2
digi_active:	.res 1
digi_copyrate:	.res 1
;spc_fread:	.res 1		;
;spc_fwrite:	.res 1		;

;======================================================================
.segment .string(SE_ENGINE_SEGMENT)
;======================================================================

SNESMOD_SPC:
.incbin "spcdriver.bin"
SNESMOD_SPC_end:

SPC_BOOT = 0400h ; spc entry/load address

;======================================================================
;.code
;======================================================================

.i16
.a8

;**********************************************************************
;* upload driver
;*
;* disable time consuing interrupts during this function
;**********************************************************************
spcBoot:		
;----------------------------------------------------------------------
:	ldx	APUIO0	; wait for 'ready signal from SPC
	cpx	#0BBAAh		;
	bne	:-		;--------------------------------------
	stx	APUIO1	; start transfer:
	ldx	#SPC_BOOT	; port1 = !0
	stx	APUIO2	; port2,3 = transfer address
	lda	#0CCh		; port0 = 0CCh
	sta	APUIO0	;--------------------------------------
:	cmp	APUIO0	; wait for SPC
	bne	:-		;
;----------------------------------------------------------------------
; ready to transfer
;----------------------------------------------------------------------
	lda	f:SNESMOD_SPC	; read first byte
	xba			;
	lda	#0		;
	ldx	#1		;
	bra	sb_start	;
;----------------------------------------------------------------------
; transfer data
;----------------------------------------------------------------------
sb_send:
;----------------------------------------------------------------------
	xba			; swap DATA into A
	lda	f:SNESMOD_SPC, x; read next byte
	inx			; swap DATA into B
	xba			;--------------------------------------
:	cmp	APUIO0	; wait for SPC
	bne	:-		;--------------------------------------
	ina			; increment counter (port0 data)
;----------------------------------------------------------------------
sb_start:
;----------------------------------------------------------------------
	rep	#20h		; write port0+port1 data
	sta	APUIO0	;
	sep	#20h		;--------------------------------------
	cpx	#SNESMOD_SPC_end-SNESMOD_SPC	; loop until all bytes transferred
	bcc	sb_send				;
;----------------------------------------------------------------------
; all bytes transferred
;----------------------------------------------------------------------
:	cmp	APUIO0	; wait for SPC
	bne	:-		;--------------------------------------
	ina			; add 2 or so...
	ina			;--------------------------------------
				; mask data so invalid 80h message wont get sent
	stz	APUIO1	; port1=0
	ldx	#SPC_BOOT	; port2,3 = entry point
	stx	APUIO2	;
	sta	APUIO0	; write P0 data
				;--------------------------------------
:	cmp	APUIO0	; final sync
	bne	:-		;--------------------------------------
	stz	APUIO0
	
	stz	spc_v		; reset V
	stz	spc_q		; reset Q
	stz	spc_fwrite	; reset command fifo
	stz	spc_fread	;
	stz	spc_sfx_next	;
	
	stz	spc_pr+0
	stz	spc_pr+1
	stz	spc_pr+2
	stz	spc_pr+3
;----------------------------------------------------------------------
; driver installation successful
;----------------------------------------------------------------------
	rtl			; return
;----------------------------------------------------------------------


;**********************************************************************
; set soundbank bank number (important...)
;
;**********************************************************************
spcSetBank:
	sta	spc_bank
	rtl
	
; increment memory pointer by 2
.macro incptr
.scope
	iny
	iny
	
;.ifndef HIROM
;	bmi	_catch_overflow
;	inc	spc_ptr+2
;	ldy	#8000h
;.else
	bne	_catch_overflow
	inc	spc_ptr+2
;.endif

_catch_overflow:
.endscope
.endmacro

;**********************************************************************
; upload module to spc
;
; x = module_id
; modifies, a,b,x,y
;
; this function takes a while to execute
;**********************************************************************
spcLoad:
;----------------------------------------------------------------------

	phx				; flush fifo!
	jsl	spcFlush		;
	plx				;
	
	phx
	ldy	#SB_MODTABLE
	sty	spc2
	jsr	get_address
	rep	#20h
	lda	[spc_ptr], y	; X = MODULE SIZE
	tax
	
	incptr
	
	lda	[spc_ptr], y	; read SOURCE LIST SIZE
	
	incptr
	
	sty	spc1		; pointer += listsize*2
	asl			;
	adc	spc1		;
;.ifndef HIROM
;	bmi	:+		;
;	ora	#8000h		;
;.else
	bcc	:+
;.endif
	inc	spc_ptr+2	;
:	tay			;
	
	sep	#20h		;
	lda	spc_v		; wait for spc
	pha			;
:	cmp	APUIO1	;
	bne	:-		;------------------------------
	lda	#CMD_LOAD	; send LOAD message
	sta	APUIO0	;
	pla			;
	eor	#80h		;
	ora	#01h		;
	sta	spc_v		;
	sta	APUIO1	;------------------------------
:	cmp	APUIO1	; wait for spc
	bne	:-		;------------------------------
	jsr	do_transfer
	
	;------------------------------------------------------
	; transfer sources
	;------------------------------------------------------
	
	plx
	ldy	#SB_MODTABLE
	sty	spc2
	jsr	get_address
	incptr
	
	rep	#20h		; x = number of sources
	lda	[spc_ptr], y	;
	tax			;
	
	incptr
	
transfer_sources:
	
	lda	[spc_ptr], y	; read source index
	sta	spc1		;
	
	incptr
	
	phy			; push memory pointer
	sep	#20h		; and counter
	lda	spc_ptr+2	;
	pha			;
	phx			;
	
	jsr	transfer_source
	
	plx			; pull memory pointer
	pla			; and counter
	sta	spc_ptr+2	;
	ply			;
	
	dex
	bne	transfer_sources
@no_more_sources:

	stz	APUIO0	; end transfers
	lda	spc_v		;
	eor	#80h		;
	sta	spc_v		;
	sta	APUIO1	;-----------------
:	cmp	APUIO1	; wait for spc
	bne	:-		;-----------------
	sta	spc_pr+1
	stz	spc_sfx_next	; reset sfx counter
	
	
	rtl
	
;--------------------------------------------------------------
; spc1 = source index
;--------------------------------------------------------------
transfer_source:
;--------------------------------------------------------------
	
	ldx	spc1
	ldy	#SB_SRCTABLE
	sty	spc2
	jsr	get_address
	
	lda	#01h		; port0=01h
	sta	APUIO0	;
	rep	#20h		; x = length (bytes->words)
	lda	[spc_ptr], y	;
	incptr			;
	ina			;
	lsr			;
	tax			;
	lda	[spc_ptr], y	; port2,3 = loop point
	sta	APUIO2
	incptr
	sep	#20h
	
	lda	spc_v		; send message
	eor	#80h		;	
	ora	#01h		;
	sta	spc_v		;
	sta	APUIO1	;-----------------------
:	cmp	APUIO1	; wait for spc
	bne	:-		;-----------------------
	cpx	#0
	beq	end_transfer	; if datalen != 0
	bra	do_transfer	; transfer source data
	
;--------------------------------------------------------------
; spc_ptr+y: source address
; x = length of transfer (WORDS)
;--------------------------------------------------------------
transfer_again:
	eor	#80h		;
	sta	APUIO1	;
	sta	spc_v		;
	incptr			;
:	cmp	APUIO1	;
	bne	:-		;
;--------------------------------------------------------------
do_transfer:
;--------------------------------------------------------------

	rep	#20h		; transfer 1 word
	lda	[spc_ptr], y	;
	sta	APUIO2	;
	sep	#20h		;
	lda	spc_v		;
	dex			;
	bne	transfer_again	;
	
	incptr

end_transfer:
	lda	#0		; final word was transferred
	sta	APUIO1	; write p1=0 to terminate
	sta	spc_v		;
:	cmp	APUIO1	;
	bne	:-		;
	sta	spc_pr+1
	rts

;--------------------------------------------------------------
; spc2 = table offset
; x = index
;
; returns: spc_ptr = 0,0,bank, Y = address
get_address:
;--------------------------------------------------------------

	lda	spc_bank	; spc_ptr = bank:SB_MODTABLE+module_id*3
	sta	spc_ptr+2	;
	rep	#20h		;
	stx	spc1		;
	txa			;
	asl			;
	adc	spc1		;
	adc	spc2		;
	sta	spc_ptr		;
	
	lda	[spc_ptr]	; read address
	pha			;
	sep	#20h		;
	ldy	#2		;
	lda	[spc_ptr],y	; read bank#
	
	clc			; spc_ptr = long address to module
	adc	spc_bank	;
	sta	spc_ptr+2	;
	ply			;
	stz	spc_ptr
	stz	spc_ptr+1
	rts			;

	
;**********************************************************************
;* x = id
;*
;* load effect into memory
;**********************************************************************
spcLoadEffect:
;----------------------------------------------------------------------
	ldy	#SB_SRCTABLE	; get address of source
	sty	spc2		;
	jsr	get_address	;--------------------------------------
	lda	spc_v		; sync with SPC
:	cmp	APUIO1	;
	bne	:-		;--------------------------------------
	lda	#CMD_LOADE	; write message
	sta	APUIO0	;--------------------------------------
	lda	spc_v		; dispatch message and wait
	eor	#80h		;
	ora	#01h		;
	sta	spc_v		;
	sta	APUIO1	;
:	cmp	APUIO1	;
	bne	:-		;--------------------------------------
	rep	#20h		; x = length (bytes->words)
	lda	[spc_ptr], y	;
	ina			;
	lsr			;
	incptr			;
	tax			;--------------------------------------
	incptr			; skip loop
	sep	#20h		;--------------------------------------
	jsr	do_transfer	; transfer data
				;--------------------------------------
	lda	spc_sfx_next	; return sfx index
	inc	spc_sfx_next	;
	rts			;
	
;**********************************************************************
; a = id
; spc1 = params
;**********************************************************************
QueueMessage:
	sei				; disable IRQ in case user 
					; has spcProcess in irq handler
			
	sep	#10h			; queue data in fifo
	ldx	spc_fwrite		;
	sta	spc_fifo, x		;
	inx				;
	lda	spc1			;
	sta	spc_fifo, x		;
	inx				;
	lda	spc1+1			;
	sta	spc_fifo, x		;
	inx				;
	stx	spc_fwrite		;
	rep	#10h			;
	cli				;
	rtl				;

;**********************************************************************
; flush fifo (force sync)
;**********************************************************************
spcFlush:
;----------------------------------------------------------------------
	lda	spc_fread		; call spcProcess until
	cmp	spc_fwrite		; fifo becomes empty
	beq	@exit			;
	jsr	spcProcessMessages	;
	bra	spcFlush		;
@exit:	rtl				;
	
	
;**********************************************************************
; process spc messages for x time
;**********************************************************************
spcProcess:
;----------------------------------------------------------------------

	lda	digi_active
	beq	:+
	jsr	spcProcessStream
:

spcProcessMessages:

	sep	#10h			; 8-bit index during this function
	lda	spc_fwrite		; exit if fifo is empty
	cmp	spc_fread		;
	beq	@exit			;------------------------------
	ldy	#PROCESS_TIME		; y = process time
;----------------------------------------------------------------------
@process_again:
;----------------------------------------------------------------------
	lda	spc_v			; test if spc is ready
	cmp	APUIO1		;
	bne	@next			; no: decrement time
					;------------------------------
	ldx	spc_fread		; copy message arguments
	lda	spc_fifo, x		; and update fifo read pos
	sta	APUIO0		;
	sta	spc_pr+0
	inx				;
	lda	spc_fifo, x		;
	sta	APUIO2		;
	sta	spc_pr+2
	inx				;
	lda	spc_fifo, x		;
	sta	APUIO3		;
	sta	spc_pr+3
	inx				;
	stx	spc_fread		;------------------------------
	lda	spc_v			; dispatch message
	eor	#80h			;
	sta	spc_v			;
	sta	APUIO1		;------------------------------
	sta	spc_pr+1
	lda	spc_fread		; exit if fifo has become empty
	cmp	spc_fwrite		;
	beq	@exit			;
;----------------------------------------------------------------------
@next:
;----------------------------------------------------------------------
	lda	SLHV		; latch H/V and test for change
	lda	OPVCT		;------------------------------
	cmp	spc1			; we will loop until the VCOUNT
	beq	@process_again		; changes Y times
	sta	spc1			;
	dey				;
	bne	@process_again		;
;----------------------------------------------------------------------
@exit:
;----------------------------------------------------------------------
	rep	#10h			; restore 16-bit index
	rtl				;
	
;**********************************************************************
; x = starting position
;**********************************************************************
spcPlay:
;----------------------------------------------------------------------
	txa				; queue message: 
	sta	spc1+1			; id -- xx
	lda	#CMD_PLAY		;
	jmp	QueueMessage		;
	
spcStop:
	lda	#CMD_STOP
	jmp	QueueMessage

;-------test function-----------;
spcTest:			;#
	lda	spc_v		;#
:	cmp	APUIO1	;#
	bne	:-		;#
	xba			;#
	lda	#CMD_TEST	;#
	sta	APUIO0	;#
	xba			;#
	eor	#80h		;#
	sta	spc_v		;#
	sta	APUIO1	;#
	rts			;#
;--------------------------------#
; ################################

;**********************************************************************
; read status register
;**********************************************************************
spcReadStatus:
	ldx	#5			; read PORT2 with stability checks
	lda	APUIO2		; 
@loop:					;
	cmp	APUIO2		;
	bne	spcReadStatus		;
	dex				;
	bne	@loop			;
	rts				;
	
;**********************************************************************
; read position register
;**********************************************************************
spcReadPosition:
	ldx	#5			; read PORT3 with stability checks
	lda	APUIO2		;
@loop:					;
	cmp	APUIO2		;
	bne	spcReadPosition		;
	dex				;
	bne	@loop			;
	rts				;

;**********************************************************************
spcGetCues:
;**********************************************************************
	lda	spc_q
	sta	spc1
	jsr	spcReadStatus
	and	#0Fh
	sta	spc_q
	sec
	sbc	spc1
	bcs	:+
	adc	#16
:	rts

;**********************************************************************
; x = volume
;**********************************************************************
spcSetModuleVolume:
;**********************************************************************
	;mukunda why would you ever put an
	;8-bit value in 16-bit X
	txa					;queue:
	sta	spc1+1			; id -- vv
	lda	#CMD_MVOL		;
	jmp	QueueMessage		;

;**********************************************************************
; x = target volume
; y = speed
;**********************************************************************
spcFadeModuleVolume:
;**********************************************************************
	txa				;queue:
	sta	spc1+1			; id xx yy
	tya				;
	sta	spc1			;
	lda	#CMD_FADE
	jmp	QueueMessage

;**********************************************************************
;* a = v*16 + p
;* x = id
;* y = pitch (0-15, 8=32khz)
;**********************************************************************
spcEffect:
;----------------------------------------------------------------------
	sta	spc1			; spc1.l = "vp"
	sty	spc2			; spc1.h = "sh"
	txa				;
	asl				;
	asl				;
	asl				;
	asl				;
	ora	spc2			;
	sta	spc1+1			;------------------------------
	lda	#CMD_FX			; queue FX message
	jmp	QueueMessage		;
;----------------------------------------------------------------------

;======================================================================
;
; STREAMING
;
;======================================================================

;======================================================================
spcSetSoundTable:
;======================================================================
	sty	SoundTable
	sta	SoundTable+2
	rtl

;======================================================================
spcAllocateSoundRegion:
;======================================================================
; a = size of buffer
;----------------------------------------------------------------------
	pha				; flush command queue
	jsl	spcFlush		;
					;
	lda	spc_v			; wait for spc
:	cmp	APUIO1		;
	bne	:-			;
;----------------------------------------------------------------------
	pla				; set parameter
	sta	APUIO3		;
;----------------------------------------------------------------------
	lda	#CMD_SSIZE		; set command
	sta	APUIO0		;
	sta	spc_pr+0		;
;----------------------------------------------------------------------
	lda	spc_v			; send message
	eor	#128			;
	sta	APUIO1		;
	sta	spc_v			;
	sta	spc_pr+1		;
;----------------------------------------------------------------------
	rtl

;----------------------------------------------------------------------
; a = index of sound
;======================================================================
spcPlaySound:
;======================================================================
	xba
	lda	#128
	xba
	ldx	#255
	ldy	#255
	jmp	spcPlaySoundEx
	
;======================================================================
spcPlaySoundV:
;======================================================================
	xba
	lda	#128
	xba
	ldx	#255
	jmp	spcPlaySoundEx
	
;----------------------------------------------------------------------
; a = index
; b = pitch
; y = vol
; x = pan
;======================================================================
spcPlaySoundEx:
;======================================================================
	sep	#10h			; push 8bit vol,pan on stack
	phy				;
	phx				;
;----------------------------------------------------------------------------
	rep	#30h			; um
	pha				; 
;----------------------------------------------------------------------------
	and	#0FFh			; y = sound table index 
	asl				;
	asl				;
	asl				;
	tay				;
;----------------------------------------------------------------------------
	pla				; a = rate
	xba				;
	and	#255			; clear B
	sep	#20h			;
;----------------------------------------------------------------------------
	cmp	#0			; if a < 0 then use default
	bmi	@use_default_pitch	; otherwise use direct	
	sta	digi_pitch		;
	bra	@direct_pitch		;
@use_default_pitch:			;
	lda	[SoundTable], y		;
	sta	digi_pitch		;
@direct_pitch:				;
;----------------------------------------------------------------------------
	tax				; set transfer rate
	lda	digi_rates, x		;
	sta	digi_copyrate		;
;----------------------------------------------------------------------------
	iny				; [point to PAN]
	pla				; if pan <0 then use default
	bmi	@use_default_pan	; otherwise use direct
	sta	spc1
	bra	@direct_pan
@use_default_pan:
	lda	[SoundTable], y
	sta	spc1
@direct_pan:
;----------------------------------------------------------------------------
	iny				; [point to VOL]
	pla				; if vol < 0 then use default
	bmi	@use_default_vol	; otherwise use direct
	bra	@direct_vol
@use_default_vol:
	lda	[SoundTable], y
@direct_vol:
;----------------------------------------------------------------------------
	asl				; vp = (vol << 4) | pan
	asl				;
	asl				;		
	asl				;
	ora	spc1			;
	sta	digi_vp			;
;----------------------------------------------------------------------------
	iny				; [point to LENGTH]
	rep	#20h			; copy length
	lda	[SoundTable], y		;
	sta	digi_remain		;
;----------------------------------------------------------------------------
	iny				; [point to SOURCE]
	iny				;
	lda	[SoundTable], y		; copy SOURCE also make +2 copy
	iny				;
	iny				;
	sta	digi_src		;
	ina				;
	ina				;
	sta	digi_src2		;
	sep	#20h			;
	lda	[SoundTable], y		;
	sta	digi_src+2		;
	sta	digi_src2+2		;
;----------------------------------------------------------------------------
	lda	#1			; set flags
	sta	digi_init		;
	sta	digi_active		; 
;----------------------------------------------------------------------------
	rtl
	
;============================================================================
spcProcessStream:
;============================================================================
	rep	#20h			; test if there is data to copy
	lda	digi_remain		;
	bne	:+			;
	sep	#20h			;
	stz	digi_active		;
	rts				;
:	sep	#20h			;
;-----------------------------------------------------------------------
	lda	spc_pr+0		; send STREAM signal
	ora	#128			;
	sta	APUIO0		;
;-----------------------------------------------------------------------
:	bit	APUIO0		; wait for SPC
	bpl	:-			;
;-----------------------------------------------------------------------
	stz	APUIO1		; if digi_init then:
	lda	digi_init		;   clear digi_init
	beq	@no_init		;   set newnote flag
	stz	digi_init		;   copy vp
	lda	digi_vp			;   copy pan
	sta	APUIO2		;   copy pitch
	lda	digi_pitch		;
	sta	APUIO3		;
	lda	#1			;
	sta	APUIO1		;
	lda	digi_copyrate		; copy additional data
	clc				;
	adc	#INIT_DATACOPY		;
	bra	@newnote		;
@no_init:				;
;-----------------------------------------------------------------------
	lda	digi_copyrate		; get copy rate
@newnote:
	rep	#20h			; saturate against remaining length
	and	#0FFh			; 
	cmp	digi_remain		;
	bcc	@nsatcopy		;
	lda	digi_remain		;
	stz	digi_remain		;
	bra	@copysat		;
@nsatcopy:				;
;-----------------------------------------------------------------------
	pha				; subtract amount from remaining
	sec				;
	sbc	digi_remain		;
	eor	#0FFFFH			;
	ina				;
	sta	digi_remain		;
	pla				;
@copysat:				;
;-----------------------------------------------------------------------
	sep	#20h			; send copy amount
	sta	APUIO0		;
;-----------------------------------------------------------------------
	sep	#10h			; spc1 = nn*3 (amount of tribytes to copy)
	tax				; x = vbyte
	sta	spc1			;
	asl				;
	clc				;
	adc	spc1			;
	sta	spc1			;
	ldy	#0			;
;-----------------------------------------------------------------------


@next_block:
		
	lda	[digi_src2], y
	sta	spc2
	rep	#20h			; read 2 bytes
	lda	[digi_src], y		;
:	cpx	APUIO0		;-sync with spc
	bne	:-			;
	inx				; increment v
	sta	APUIO2		; write 2 bytes
	sep	#20h			;
	lda	spc2			; copy third byte
	sta	APUIO1		;
	stx	APUIO0		; send data
	iny				; increment pointer
	iny				;
	iny				;
	dec	spc1			; decrement block counter
	bne	@next_block		;
;-----------------------------------------------------------------------
:	cpx	APUIO0		; wait for spc
	bne	:-			;
;-----------------------------------------------------------------------	
	lda	spc_pr+0		; restore port data
	sta	APUIO0		;
	lda	spc_pr+1		;
	sta	APUIO1		;
	lda	spc_pr+2		;
	sta	APUIO2		;
	lda	spc_pr+3		;
	sta	APUIO3		;
;-----------------------------------------------------------------------
	tya				; add offset to source
	rep	#31h			;
	and	#255			;
	adc	digi_src		;
	sta	digi_src		;
	ina				;
	ina				;
	sta	digi_src2		;
	sep	#20h			;
;-----------------------------------------------------------------------
	rts
	
digi_rates:
	.byte	0, 3, 5, 7, 9, 11, 13

;;----------------------------------------------------------------------
;spcProcessDigital:
;;----------------------------------------------------------------------
;	lda	spc_pr+0		; send STREAM signal
;	ora	#128			;
;	sta	APUIO0		;
;;----------------------------------------------------------------------
;:	cmp	APUIO0		; wait for SPC
;	bne	:-			;
;;----------------------------------------------------------------------
;	lda	APUIO1		; get chunk counter
;	bne	:+			; if 0 then ragequit
;	lda	spc_pr+0		; [restore p0]
;	sta	APUIO0		;
;	rts				;
;:					;
;;----------------------------------------------------------------------
;	sep	#30h			;
;	stz	MEMSEL		; switch to SlowROM
;	tax				;
;	ldy	#0			;
;;----------------------------------------------------------------------
;; critical routine following
;;
;; some instructions: bytes,cyc (estimate) microseconds
;; stz io       : 3,4 (8*3+6,		30) 1.397us
;; sep/rep IMM8 : 2,3 (8*2+6,		22) 1.024us
;; sta8 io      : 3,4 (8*3+6,		30) 1.397us
;; iny          : 1,2 (8+6,		14) 0.651us
;; lda8 []+y    : 2,7 (8*2+8*3+8,	40) 2.235us
;; sta16 io     : 3,5 (8*3+6+6,		36) 1.676us
;; nop          : 1,2 (8+6,		14) 0.651us
;;----------------------------------------------------------------------
;	sei				;
;	stz	MEMSEL		; switch to SlowROM
;	stz	APUIO0		; send start signal
;	
;	;--------------------------------------------------------------
;	; ~13us until start
;	;--------------------------------------------------------------
;	
;			;	bne	_sr_wait_for_snes	0#		+2
;			;	nop				1.953125	+2
;			;	cmp	x, #0			3.90625		+2
;			;	beq	_sr_skip		5.859375	+2
;			;	mov	y, stream_write		7.8125		+3
;			;	clrc				10.7421875	+2
;			;SPC:					12.6953125
;	
;	
;	; (TWEAK)
;	nop			; 0#
;	nop			; 0.65186012944079713181543046049262
;	nop			; 1.3037202588815942636308609209846
;	nop			; 1.9555803883223913954462913814766
;	nop			; 2.6074405177631885272617218419686
;	nop			; 3.2593006472039856590771523024606
;	nop			; 3.9111607766447827908925827629526
;	nop			; 4.5630209060855799227080132234446
;	nop			; 5.2148810355263770545234436839366
;	nop			; 5.8667411649671741863388741444286
;	nop			; 6.5186012944079713181543046049206
;	nop			; 7.1704614238487684499697350654126
;	nop			; 7.8223215532895655817851655259046
;	nop			; 8.4741816827303627136005959863966
;				; 9.126041812171159845416026446888
;				
;			;SPC:
;			;	byte1 mov a, dp	; 0#
;			;	write		; 2.9296875
;			;	byte2		; 8.7790626 (PER BYTE)
;			; 17.5581252	b2
;			; 26.3371878	b3
;			; 35.1162504	b4
;			; 43.895313	b5
;			; 52.6743756	b6
;			; 61.4534382	b7
;			; 70.2325008	b8
;			; 79.0115634	b9
;			; 87.790626	b10
;			; 96.5696886	b11
;			; 105.3487512	b12
;			; 114.1278138	b13
;			; 122.9068764	b14
;			; 131.685939	b15
;			; 140.4650016	b16
;			; 149.2440642	b17
;			
;.macro dm_copy_byte target, trail ;84 +14*trail cycles
;	lda	[digital_src], y
;	iny
;	sta	APUIO0
;	.repeat trail-1
;		nop
;	.endrep
;.endmacro
;	
;@cpy_next_chunk:
;	dm_copy_byte APUIO0, 8 ;8.7790626 : 9.12604181217116
;	dm_copy_byte APUIO1, 7 ;17.5581252 : 17.6002234949015
;	dm_copy_byte APUIO2, 8 ;26.3371878 : 26.7262653070727
;	dm_copy_byte APUIO3, 7 ;35.1162504 : 35.2004469898031
;	dm_copy_byte APUIO0, 8 ;43.895313 : 44.3264888019742
;	dm_copy_byte APUIO1, 7 ;52.6743756 : 52.8006704847046
;	dm_copy_byte APUIO2, 8 ;61.4534382 : 61.9267122968758
;	dm_copy_byte APUIO3, 7 ;70.2325008 : 70.4008939796061
;	dm_copy_byte APUIO0, 8 ;79.0115634 : 79.5269357917772
;	dm_copy_byte APUIO1, 7 ;87.790626 : 88.0011174745075
;	dm_copy_byte APUIO2, 8 ;96.5696886 : 97.1271592866786
;	dm_copy_byte APUIO3, 7 ;105.3487512 : 105.601340969409
;	dm_copy_byte APUIO0, 8 ;114.1278138 : 114.72738278158
;	dm_copy_byte APUIO1, 7 ;122.9068764 : 123.20156446431
;	dm_copy_byte APUIO2, 8 ;131.685939 : 132.327606276482
;	dm_copy_byte APUIO3, 7 ;140.4650016 : 140.801787959212
;	dm_copy_byte APUIO0, 7 ;149.2440642 : 149.275969641942
;	dm_copy_byte APUIO1, 8 ;158.0231268 : 158.402011454113
;	
;:	cpx	APUIO0 	; sync point
;	bne	:-		;
;	
;	dex
;	beq	@cpy_complete
;	jmp	@cpy_next_chunk
;@cpy_complete:
;
;	lda	spc_pr+0
;	sta	APUIO0
;	lda	spc_pr+1
;	sta	APUIO1
;	lda	spc_pr+2
;	sta	APUIO2
;	lda	spc_pr+3
;	sta	APUIO3
;
;	rep	#10h
;	
;----------------------------------------------------------------------
;	lda	CART_HEADER + 0D5h - 0B0h	; restore rom speed
;	and	#1				;
;	sta	MEMSEL			;
;---------------------------------CART_HEADER-------------------------------------
;	
;	cli
;	rts

;**********************************************************************
; stop
;
; this is a blocking function
;**********************************************************************
;spcDisableDigital:
;;----------------------------------------------------------------------
;	jsr	spcFlush		; flush existing messages
;;----------------------------------------------------------------------
;	lda	spc_v			; wait for spc
;:	cmp	APUIO1		;
;	bne	:-			;
;;----------------------------------------------------------------------
;	lda	#CMD_DDS		; send DDS message
;	sta	APUIO0		;
;	lda	spc_v			;
;	eor	#128			;
;	sta	spc_v			;
;	sta	APUIO1		;
;;----------------------------------------------------------------------
;:	cmp	APUIO1		; wait for spc
;	bne	:-			;
;;----------------------------------------------------------------------
;	sta	spc_pr+1
;	rts

;**********************************************************************
; start streaming
;
; this is a blocking function
;**********************************************************************
;spcEnableDigital:
;----------------------------------------------------------------------
	;jsr	spcFlush		; flush existing messages
;----------------------------------------------------------------------
;	lda	spc_v			; wait for spc
;:	cmp	APUIO1		;
;	bne	:-			;
;----------------------------------------------------------------------
;	lda	#CMD_EDS		; send EDS message
;	sta	APUIO0		;	
;	lda	spc_v			;
;	eor	#128			;
;	sta	spc_v			;
;	sta	APUIO1		;
;----------------------------------------------------------------------	
;:	cmp	APUIO1		; wait for spc
;	bne	:-			;
;----------------------------------------------------------------------
;	sta	spc_pr+1
;	stz	digital_len
;	stz	digital_len+1
;	rts				;
