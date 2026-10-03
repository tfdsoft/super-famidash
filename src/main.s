.include "snes.inc"
.include "sniperengine/se.inc"
;.include "snesmod_dev.s" ; sound driver

.include "header.s"
.include "vectors.s"
.include "registers.s"

.include "reset.s"


;; pretty much everything you want your game to use
;; goes in assets.s
.include "assets.s"



.segment "BSS"
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
        lda #0
        jsl SE_PPU_SET_PALETTE_SET


        seta16
        setxy8
        lda #RGB(31,0,0)
        ldx #0
        jsl SE_PPU_SET_PALETTE_COLOR

        ; load music lmao
        seta8
        setxy16
        wdm #0

        jsl SE_PPU_DISABLE_NMI
        jsl SPC_BOOT
        jsl SE_PPU_ENABLE_NMI

        lda #^song_yourmom
        jsl SPC_SET_BANK

        ldx #0
        jsl SPC_LOAD

        jsl SPC_PROCESS

        ldx #0
        jsl SPC_PLAY

        ldx #$00ff
        jsl SPC_SET_MODULE_VOLUME

        jsl SPC_PROCESS

        seta16
        setxy8
        lda #RGB(31,31,31)
        ldx #0
        jsl SE_PPU_SET_PALETTE_COLOR
        

    @loop:
        jsl SE_WAIT_VSYNC

        ;seta8
        ;setxy16
        jsl SPC_PROCESS

        ;seta8
        ;setxy8

        ;lda #15
        ;ldx #0

        ;jsl SE_PPU_FADE_SCREEN_BRIGHTNESS
        ;lda #RGB(27,0,14)
        ;ldx #0
        ;jsl SE_PPU_SET_PALETTE_COLOR


        bra @loop



ignore_interrupt:
    rti




