.pushseg


.segment "BANK_C1"

    .include "metatiles.s"
    
    d_super_cool_palette:
        .word RGB(31,31,31), RGB(30,30,30), RGB(29,29,29), RGB(28,28,28)
        .word RGB(27,27,27), RGB(26,26,26), RGB(25,25,25), RGB(24,24,24)

.segment "BANK_C2"
    song_yourmom:
        .incbin "music/exports/test.bank"

.popseg