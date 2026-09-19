.include "snes.inc"
.include "sniperengine/se.inc"

.include "header.s"
.include "vectors.s"
.include "registers.s"

.include "reset.s"


.segment "RAM"
    test: .res 1
    
.segment "HIRAM1"   : far
.segment "HIRAM2"   : far




.segment "CODE"
    main:
        jsl SE_PPU_ENABLE_NMI
        jsl SE_PPU_ENABLE_RENDERING

        seta8
        lda #15
        jsl SE_PPU_SET_SCREEN_BRIGHTNESS

        seta16
        setxy8
        lda #$0000
        tax


    @loop:
        jsl SE_PPU_SET_PALETTE_COLOR
        ina
        pha
        jsl SE_WAIT_VSYNC
        jsl SE_WAIT_VSYNC
        jsl SE_WAIT_VSYNC
        jsl SE_WAIT_VSYNC
        pla
        bra @loop










ignore_interrupt:
    rti
