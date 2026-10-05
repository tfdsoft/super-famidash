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
    

.segment "BANK_3F" : far
    chr_level_bg01:
        .incbin "chr/level_bg01_tileset.chr"



.segment "BANK_40" : far
    song_menu_theme:
        .incbin "music/exports/test.bank"


;.segment "BANK_C0"
;   this is simply CODE/RODATA. make an alias if you want it

.segment "BANK_C1" : far
    .include "metatiles.s"
    d_super_cool_palette:
        .word RGB(31,31,31), RGB(30,30,30), RGB(29,29,29), RGB(28,28,28)
        .word RGB(27,27,27), RGB(26,26,26), RGB(25,25,25), RGB(24,24,24)







.popseg