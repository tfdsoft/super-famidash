.segment "SNESHEADER"
    ; name of the rom, must be 21 characters long
    .byte "Super Famidash       "

    ; mapping mode
    .byte  %00110101
    ;          |++++- Map mode (5=ExHiROM)
    ;          +----- Speed: 0=slow, 1=fast
    
    ; hardware in the cart
    .byte  $02  ; $02 - ROM + RAM + battery

    ; rom size (2^N)kb
    .byte   12  ; 2^12 = 4096kb = 4mb

    ; ram size (2^N)kb
    .byte   3   ; 2^3 = 8kb

    ; region
    .byte   $0e ; $0e = worldwide (common)

    ; publisher id
    .byte   $fd ; fd for famidash. get it?

    ; checksum (doesn't matter lmao)
    .word $0000

    ; $FFFF - checksum (also doesn't matter)
    .word $0000
