.segment "INIT" ; you get 4kb in this section, make it count

    reset:
        jml @goto_fastrom ; this also sets the program bank

    @goto_fastrom:
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
        lda #1
        sta ROMSPEED

    ; set data bank
        lda #$80
        pha
        plb

    ; init everything
        jsl SE_INIT

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

        ldx #128      ; channel 0 (1 << n)
        stx COPYSTART   ; start the transfer
        stx COPYSTART   ; do it again!

    ;
    ;;  TODO: add more clear routines here
    ;

        jsl SE_PPU_ENABLE_NMI
    ; go to wherever main is
        setaxy8
        jsl main ; jsl to save the program bank



    zero:
        .byte $0
    
