.segment "CODE"
    state_titlescreen:
        setaxy8 ; set registers to a known size

        wdm #0
        ENGINECALL SE_PPU_DISABLE_RENDERING

        DMA_VRAM (chr_title_screen_end-chr_title_screen), chr_title_screen, $1000
        DMA_VRAM $800, map_title_screen, $7000
        DMA_VRAM $100, chr_icon00, $4000
        DMA_VRAM $100, (chr_icon00+256), $4100

        ENGINECALL SE_PPU_SET_PALETTE_SET, #.loword(pal_super_cool_palette), #^pal_super_cool_palette, #0
        ENGINECALL SE_PPU_SET_PALETTE_SET, #.loword(pal_title_screen), #^pal_title_screen, #1
        ENGINECALL SE_PPU_SET_PALETTE_SET, #.loword(pal_player), #^pal_player, #8

        ; turn on the screen; all the changes done to vram/cgram
        ; will be updated in nmi
        ENGINECALL SE_PPU_ENABLE_LAYER_MAIN, #%10011 ; bg1, bg2, sprites
        ENGINECALL SE_PPU_ENABLE_RENDERING

        ENGINECALL SE_PPU_FADE_SCREEN_BRIGHTNESS, #0, #15

        @loop:
            ENGINECALL SE_WAIT_VSYNC
            ENGINECALL SE_OAM_CLEAR

            seta8
            setxy16
            jsl SPC_PROCESS

            seta16
            lda #$800
            @1:
                dec
                bne @1

            
            inc funny_scroll_value
            ;ENGINECALL SE_PPU_SET_SCROLL, #0, funny_scroll_value, #$e0

            ENGINECALL SE_OAM_DRAW_SPRITE, funny_scroll_value, #$60, #$00, #%00100000, 1
            ENGINECALL SE_OAM_DRAW_SPRITE, funny_scroll_value, #$70, #$04, #%00100000, 1
            seta16
            lda funny_scroll_value
            clc
            adc #$10
            sta funny_scroll_value
            ENGINECALL SE_OAM_DRAW_SPRITE, funny_scroll_value, #$60, #$02, #%00100000, 1
            ENGINECALL SE_OAM_DRAW_SPRITE, funny_scroll_value, #$70, #$06, #%00100000, 1
            seta16
            lda funny_scroll_value
            sec
            sbc #$10
            sta funny_scroll_value

            ENGINECALL SE_GRAY_LINE
            brl @loop
        
        @return:
        rtl
