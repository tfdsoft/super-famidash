.segment "INIT" ; you get 4kb in this section, make it count

    reset:
    ; switch to native mode
        sei 
        clc 
        xce

    ; disable decimal mode
        cld

    ; set the stack pointer
        setaxy16
        ldx #$1fff
        txs

    ; enable fastrom
        seta8
        lda #1
        sta ROMSPEED

    ; set data bank
        lda #$80
        pha
        plb

    ; clear RAM
        seta16
        setxy8
        ldx #DMA_LINEAR|DMA_CONST
        stx DMAMODE+$70
        ldx #.lobyte(WMDATA)
        stx DMAPPUREG+$70
        lda #.loword(zero)
        sta DMAADDR+$70
        ldx #^zero
        stx DMAADDRBANK+$70
        stz DMALEN+$70  ; 0 length = $10000

        ldx #%10000000      ; channel 0 (1 << n)
        stx COPYSTART   ; start the transfer
        stx COPYSTART   ; do it again!

        ;seta16
        stz VMADDL
        ;setxy8
        ;ldx #%10000000
        ;stx VMAIN

        ldx #DMA_01|DMA_CONST
        stx DMAMODE+$70
        ldx #.lobyte(VMDATAL)
        stx DMAPPUREG+$70
        ;lda #.loword(SE_IDENTITY_TABLE)
        ;sta DMAADDR+$70
        ;ldx #^SE_IDENTITY_TABLE
        ;stx DMAADDRBANK+$70
        ;lda #$0
        ;sta DMALEN+$70

        ldx #%10000000
        stx COPYSTART

    ; init everything
        ENGINECALL SE_INIT

    ;
    ;;  TODO: add more clear routines here
    ;

        ENGINECALL SE_CPU_ENABLE_NMI
    ; go to wherever main is
        setaxy8
        jsl main ; jsl to save the program bank



    zero:
        .byte $0
    
