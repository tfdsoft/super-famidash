.segment "VECTORS"

    .import nmi
    .import irq

    ; native mode whatnots
    .word $0000 ; unused
    .word $0000 ; unused
    .addr ignore_interrupt   ; cop instruction
    .addr ignore_interrupt   ; brk instruction
    .word $0000 ; abort (unused)
    .addr nmi   ; nmi
    .word $0000 ; unused
    .addr irq   ; irq

    ; emulation mode
    .word $0000 ; unused
    .word $0000 ; unused
    .addr ignore_interrupt   ; cop instruction
    .word $0000 ; unused
    .word $0000 ; abort (unused)
    .addr nmi   ; nmi
    .addr reset ; reset
    .addr irq   ; irq
