.include "snes.inc"
.include "sniperengine/se.inc"

.include "header.s"
.include "vectors.s"
.include "registers.s"

.include "reset.s"


.segment "RAM"      : absolute
.segment "HIRAM1"   : far
    test: .res 1
.segment "HIRAM2"   : far




.segment "CODE"
    main:
        lda test
        jsl SE_PPU_ENABLE_NMI
        wai
        bra main









ignore_interrupt:
    rti
