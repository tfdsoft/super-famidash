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

        ENGINECALL SE_PPU_CLEAR_PALETTE
        ENGINECALL SE_PPU_SET_SCREEN_BRIGHTNESS, #0

        ENGINECALL SE_PPU_SET_PALETTE_SET, #.loword(d_super_cool_palette), #^d_super_cool_palette, #0

        ENGINECALL SE_PPU_SET_PALETTE_COLOR, #RGB(31,0,0), #0


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

        ldx #$3f
        jsl SPC_SET_MODULE_VOLUME

        jsl SPC_PROCESS

        lda #1
        jsl SPC_PLAY_SOUND

        ENGINECALL SE_PPU_SET_PALETTE_COLOR, d_super_cool_palette, #0
        
        ; turn on the screen; all the changes done to vram/cgram
        ; will be updated in nmi
        ENGINECALL SE_PPU_ENABLE_LAYER_MAIN, #%10001
        ENGINECALL SE_PPU_ENABLE_RENDERING

        ENGINECALL SE_PPU_FADE_SCREEN_BRIGHTNESS, #0, #15


        wdm #0

        ;; single entry tests
        ; VMAIN/properties, tile(8/16), vram addr
        ENGINECALL SE_VRAM_BUFFER_ADD, #%11000000, #$2020, #$8080 ; word
        ENGINECALL SE_VRAM_BUFFER_ADD, #%10000000, #$50, #$8083 ; byte

        ;; multi entry tests
        ; VMAIN/properties, length, vram addr, tile data addr
        ENGINECALL SE_VRAM_BUFFER_ADD, #10010000, #$10, #$9000, #d_super_cool_palette ; multi-byte, direct


    @loop:
        ENGINECALL SE_WAIT_VSYNC
        ;jsl SE_OAM_CLEAR

        seta8
        setxy16
        jsl SPC_PROCESS

        jsl SE_TEST
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




