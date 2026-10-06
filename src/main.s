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
        DMA_VRAM 32768, chr_title_screen, $0000

        jsl SE_PPU_CLEAR_PALETTE
        seta8
        lda #0
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
        jsl SE_PPU_DISABLE_NMI
        jsl SPC_BOOT
        jsl SE_CPU_ENABLE_NMI

        lda #^song_menu_theme
        jsl SPC_SET_BANK

        ldx #0
        jsl SPC_LOAD

        lda #32
        jsl SPC_ALLOCATE_SOUND_REGION

        lda #^sfx_SoundTable
        ldy #.LOWORD(sfx_SoundTable)
        jsl SPC_SET_SOUND_TABLE

        ;ldx #0
        ;jsl SPC_PLAY

        ldx #$3f
        jsl SPC_SET_MODULE_VOLUME

        jsl SPC_PROCESS

        lda #0
        jsl SPC_PLAY_SOUND

        seta16
        setxy8
        lda d_super_cool_palette
        ldx #0
        jsl SE_PPU_SET_PALETTE_COLOR
        
        seta8
        ; turn on the screen; all the changes done to vram/cgram
        ; will be updated in nmi
        jsl SE_PPU_ENABLE_RENDERING

        lda #0
        ldx #15
        jsl SE_PPU_FADE_SCREEN_BRIGHTNESS


    @loop:
        jsl SE_WAIT_VSYNC

        seta8
        setxy16
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




