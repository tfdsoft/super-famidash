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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  GAMESTATES GO HERE!!!!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.include "titlescreen.s"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.segment "BSS"
    test: .res 1
    funny_scroll_value: .res 2
    
.segment "HIRAM1"   : far
.segment "HIRAM2"   : far




.segment "CODE"
    main:
        ENGINECALL SE_PPU_CLEAR_PALETTE
        ENGINECALL SE_PPU_SET_SCREEN_BRIGHTNESS, #0

        ; load music lmao
        seta8
        setxy16
        ENGINECALL SE_CPU_DISABLE_NMI
        jsl SPC_BOOT
        ENGINECALL SE_CPU_ENABLE_NMI

        lda #^song_menu_theme
        jsl SPC_SET_BANK

        ldx #0
        jsl SPC_LOAD

        lda #26
        jsl SPC_ALLOCATE_SOUND_REGION

        lda #^sfx_SoundTable
        ldy #.LOWORD(sfx_SoundTable)
        jsl SPC_SET_SOUND_TABLE

        ldx #0
        jsl SPC_PLAY

        ldx #$7f
        jsl SPC_SET_MODULE_VOLUME

        jsl SPC_PROCESS

        lda #2
        jsl SPC_PLAY_SOUND


        ; SET UP MODE 1
        seta8 ;TODO: replace register numbers with labels
        ENGINECALL SE_PPU_SET_REGISTER, #2, #1 ; mode 1
        ENGINECALL SE_PPU_SET_REGISTER, #4, #$71 ; $7000, 64x32
        ENGINECALL SE_PPU_SET_REGISTER, #5, #$79 ; $7800, 64x32
        ENGINECALL SE_PPU_SET_REGISTER, #6, #$68 ; $6800, 32x32 dual
        seta16
        ENGINECALL SE_PPU_SET_REGISTER, #8, #$0400 ; bg chr: $0000, $0000, $4000, (unused)


        ;wdm #0
        ;; single entry tests
        ; VMAIN/properties, tile(8/16), vram addr
        ;ENGINECALL SE_VRAM_BUFFER_ADD, #%11000000, #$2020, #$8080 ; word
        ;ENGINECALL SE_VRAM_BUFFER_ADD, #%00000000, #$50, #$8083 ; byte

        ;; multi entry tests
        ; VMAIN/properties, length, vram addr, tile data addr
        ;wdm #0
        ;ENGINECALL SE_VRAM_BUFFER_ADD, #%10010000, #$10, #$9000, pal_super_cool_palette ; multi-byte, direct


        @loop:
            ENGINECALL SE_WAIT_VSYNC
            ENGINECALL SE_OAM_CLEAR

            jsl state_titlescreen

            brl @loop
            

