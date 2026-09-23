.include "snes.inc"
.include "sniperengine/se.inc"

.include "header.s"
.include "vectors.s"
.include "registers.s"


.include "metatiles.s"

.include "reset.s"



.segment "RAM"
    test: .res 1
    
.segment "HIRAM1"   : far
.segment "HIRAM2"   : far




.segment "CODE"
    main:
        jsl SE_PPU_ENABLE_RENDERING

        jsl SE_PPU_CLEAR_PALETTE
        seta8
        lda #15
        jsl SE_PPU_SET_SCREEN_BRIGHTNESS

        seta16
        lda #.loword(d_super_cool_palette)
        sta __rc2
        seta8
        lda #^d_super_cool_palette
        sta __rc4
        wdm #0
        lda #0
        jsl SE_PPU_SET_PALETTE_SET

        

    @loop:
        jsl SE_WAIT_VSYNC

        seta8
        setxy8

        lda #15
        ldx #0

        jsl SE_PPU_FADE_SCREEN_BRIGHTNESS
        ;lda #RGB(27,0,14)
        ;ldx #0
        ;jsl SE_PPU_SET_PALETTE_COLOR


        bra @loop



ignore_interrupt:
    rti


.segment "BANK_C1"
d_super_cool_palette:
    .word RGB(31,31,31), RGB(30,30,30), RGB(29,29,29), RGB(28,28,28)
    .word RGB(27,27,27), RGB(26,26,26), RGB(25,25,25), RGB(24,24,24)



