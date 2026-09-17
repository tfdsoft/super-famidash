.segment "SNESHEADER"
    ; name of the rom, must be 21 characters long
    .byte "Super Famidash       "

    ; mapping mode
    .byte  %00110001
    ;          |++++- Map mode (1=HiROM)
    ;          +----- Speed: 0=slow, 1=fast
    
    ; hardware in the cart
    .byte  $00  ; $00 - ROM only

    ; rom size (2^N)kb
    .byte   8   ; 2^8 = 256kb

    ; ram size (2^N)kb
    .byte   0   ; 2^0 = 1kb

    ; region
    .byte   $0e ; $0e = worldwide (common)

    ; publisher id
    .byte   $fd ; fd for famidash. get it?

    ; checksum (doesn't matter lmao)
    .word $0000

    ; $FFFF - checksum (also doesn't matter)
    .word $0000
