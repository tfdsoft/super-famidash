.pushseg

;;  ============================================================
;;  The Almighty Assets File:tm:
;;  if your game needs it, put it in here.
;;  ============================================================
;;  Valid bank numbers are as follows:
;;  - 3E-3F (32kb, slow)
;;  - 40-7D (64kb, slow)
;;  - C1-FF (64kb, fast)
;;  ============================================================


; BANK_3E and BANK_3F are 32kb wide; put unimportant stuff in 'em
.segment "BANK_3E" : far
    chr_title_screen:
        .incbin "chr/title_screen.chr"
        chr_title_screen_end:
    
.segment "BANK_3F" : far
    chr_level_bg01:
        .incbin "chr/level_bg01_tileset.chr"


.segment "BANK_40" : far
    chr_icon00:
        .incbin "chr/icon00.chr"





.segment "BANK_70" : far
    sfx_SoundTable:

    sfx_boot = 0
        .byte 6
        .byte 8
        .byte 15
        .word (sfx_boot_end-sfx_boot_start)/9
        .word .loword(sfx_boot_start)
        .byte ^sfx_boot_start
    sfx_endStart_02 = 1
        .byte 2
        .byte 8
        .byte 15
        .word (sfx_endStart_02_end-sfx_endStart_02_start)/9
        .word .loword(sfx_endStart_02_start)
        .byte ^sfx_endStart_02_start
    sfx_playSound_01 = 2
        .byte 6
        .byte 8
        .byte 15
        .word (sfx_playSound_01_end-sfx_playSound_01_start)/9
        .word .loword(sfx_playSound_01_start)
        .byte ^sfx_playSound_01_start
    sfx_quitSound_01 = 3
        .byte 6
        .byte 8
        .byte 15
        .word (sfx_quitSound_01_end-sfx_quitSound_01_start)/9
        .word .loword(sfx_quitSound_01_start)
        .byte ^sfx_quitSound_01_start

    sfx_boot_start:
        .incbin "music/sfx/boot.brr"
        sfx_boot_end:
    sfx_endStart_02_start:
        .incbin "music/sfx/endStart_02.brr"
        sfx_endStart_02_end:
    sfx_playSound_01_start:
        .incbin "music/sfx/playSound_01.brr"
        sfx_playSound_01_end:
    sfx_quitSound_01_start:
        .incbin "music/sfx/quitSound_01.brr"
        sfx_quitSound_01_end:






.segment "BANK_71" : far
    song_menu_theme:
        .incbin "music/exports/test.bank"
.segment "BANK_72" : far
    song_stereo_madness:
        .incbin "music/exports/stereomadness.bank"
    


;.segment "BANK_C0"
;   this is simply CODE/RODATA. make an alias if you want it

.segment "BANK_C1" : far
    .include "metatiles.s"
    pal_super_cool_palette:
        .word RGB(0,0,31), RGB(0,0,$1f), RGB(0,0,$1a), RGB(0,0,$15)
        .word RGB(0,0,$10), RGB(0,0,$0b), RGB(0,0,$06), RGB(0,0,0)
        .word RGB($8,$8,$1f),RGB($10,$10,$1f),RGB($18,$18,$1f),RGB($1f,$1f,$1f)
        pal_super_cool_palette_end:

    pal_title_screen:
        .byte $B0, $7D, $00, $00, $0D, $10, $D8, $27, $CC, $16, $A7, $09, $EA, $73, $A0, $56
        .byte $A1, $35, $A0, $03, $E0, $7F, $FF, $7F, $FF, $13, $DF, $02, $1F, $7C, $DF, $7D
        pal_title_screen_end:

    pal_player:
        .byte $AD, $35, $00, $00, $C0, $00, $80, $01, $60, $02, $20, $03, $E0, $03, $E0, $2F
        .byte $E0, $4F, $E0, $7F, $20, $67, $60, $4E, $80, $31, $C0, $18, $FF, $7F, $1F, $00
        pal_player_end:
        
    map_title_screen:
        .incbin "tilemaps/titlescreen.map"
        map_title_screen_end:





.popseg