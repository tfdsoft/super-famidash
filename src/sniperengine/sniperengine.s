;;
;; CONFIG
;;
.define SE_ZEROPAGE_SEGMENT ZEROPAGE
.define SE_BSS_SEGMENT      HIRAM1
.define SE_BSS_ADDR_TYPE    far
.define SE_ENGINE_SEGMENT   SNIPERENGINE











;; 
;; you shouldn't have to touch anything below this.
;;

.import __rc0,  __rc1,  __rc2,  __rc3,  __rc4,  __rc5,  __rc6,  __rc7
.import __rc8,  __rc9,  __rc10, __rc11, __rc12, __rc13, __rc14, __rc15
.import __rc16, __rc17, __rc18, __rc19, __rc20, __rc21, __rc22, __rc23
.import __rc24, __rc25, __rc26, __rc27, __rc28, __rc29, __rc30, __rc31

.include "snes.inc"

.segment .string(SE_ZEROPAGE_SEGMENT)
    

.segment .string(SE_BSS_SEGMENT) : SE_BSS_ADDR_TYPE
    se_v_ppu_inidisp_var:   .res 1


    se_v_cpu_nmitimen_var:  .res 1


.segment .string(SE_ENGINE_SEGMENT)
    ; every sniperengine instance starts with a jump table lmao

    ;; INIT
    jmp se_init

    ;; PPU ROUTINES
    jmp se_ppu_disable_nmi
    jmp se_ppu_enable_nmi
















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
    ;;  se_ppu_disable_nmi
    ;;  description: disables the nmi signal.
    ;;  args:   none
    ;;  return: none
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_disable_nmi
        php
        seta8
        lda se_v_cpu_nmitimen_var
        and #%01111111
        bra __se_ppu_nmitimen_common
    .endproc

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_enable_nmi
    ;;  description: enables the nmi signal.
    ;;  args:   none
    ;;  return: none
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_enable_nmi
        php
        seta8
        lda se_v_cpu_nmitimen_var
        ora #%10000000
        ; fall through
    .endproc

    __se_ppu_nmitimen_common:
        sta se_v_cpu_nmitimen_var
        sta NMITIMEN

        plp
        rtl



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;  se_ppu_set_screen_brightness
    ;;  description: set the brightness of the full palette.
    ;;  arguments:  A8 (brightness value, 0-15)
    ;;  returns:    none
    ;;  clobbers:   A,P,__rc2
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    .proc se_ppu_set_screen_brightness
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




    .export nmi
    .proc nmi
        bit $4210
        rti
    .endproc


    .export irq
    .proc irq
        bit $4211
        rti
    .endproc