.segment "VECTORTABLE"
    .import nmi
    .import irq

    nmi_jml:
        jml nmi
    reset_jml:
        jml reset
    irq_jml:
        jml irq



.segment "VECTORS"

    ; native mode whatnots
    .word $0000     ; unused
    .word $0000     ; unused
    .addr ignore_interrupt   ; cop instruction
    .addr ignore_interrupt   ; brk instruction
    .word $0000     ; abort (unused)
    .addr nmi_jml   ; nmi
    .word $0000     ; unused
    .addr irq_jml   ; irq

    ; emulation mode
    .word $0000     ; unused
    .word $0000     ; unused
    .addr ignore_interrupt   ; cop instruction
    .word $0000     ; unused
    .word $0000     ; abort (unused)
    .addr nmi_jml   ; nmi
    .addr reset_jml ; reset
    .addr irq_jml   ; irq
