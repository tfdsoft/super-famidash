SE_BASE_ADDRESS = $809000



SE_INIT =                   0

SE_WAIT_VSYNC =             1

SE_CPU_DISABLE_NMI =        2
SE_CPU_ENABLE_NMI =         3

SE_PPU_DISABLE_RENDERING =  4
SE_PPU_ENABLE_RENDERING =   5

SE_PPU_SET_SCREEN_BRIGHTNESS =  6
SE_PPU_FADE_SCREEN_BRIGHTNESS = 7 ; NO MEMES OR I KILL YOU. -usersniper

SE_PPU_SET_PALETTE_COLOR =      8
SE_PPU_SET_PALETTE_SET =        9
SE_PPU_CLEAR_PALETTE =          10

SE_PPU_ENABLE_LAYER_MAIN =		11
SE_PPU_ENABLE_LAYER_SUB =		12
SE_PPU_DISABLE_LAYER_MAIN =		13
SE_PPU_DISABLE_LAYER_SUB =		14

;
;; (fututre ppu functions will go here)
;

SE_OAM_CLEAR = 				SE_BASE_ADDRESS + $30
SE_OAM_DRAW_SPRITE = 		SE_BASE_ADDRESS + $33



SPC_BOOT =                  SE_BASE_ADDRESS + $80
SPC_SET_BANK =              SE_BASE_ADDRESS + $83
SPC_LOAD =                  SE_BASE_ADDRESS + $86
SPC_TEST =                  SE_BASE_ADDRESS + $89
SPC_PLAY =                  SE_BASE_ADDRESS + $8c
SPC_STOP =                  SE_BASE_ADDRESS + $8f
SPC_READ_STATUS =           SE_BASE_ADDRESS + $92
SPC_READ_POSITION =         SE_BASE_ADDRESS + $95
SPC_GET_CUES =              SE_BASE_ADDRESS + $98

SPC_SET_MODULE_VOLUME =     SE_BASE_ADDRESS + $9b
SPC_FADE_MODULE_VOLUME =    SE_BASE_ADDRESS + $9e
SPC_LOAD_EFFECT =           SE_BASE_ADDRESS + $a1
SPC_EFFECT =                SE_BASE_ADDRESS + $a4

SPC_FLUSH =                 SE_BASE_ADDRESS + $a7
SPC_PROCESS =               SE_BASE_ADDRESS + $aa

SPC_SET_SOUND_TABLE =       SE_BASE_ADDRESS + $ad
SPC_ALLOCATE_SOUND_REGION = SE_BASE_ADDRESS + $b0
SPC_PLAY_SOUND =            SE_BASE_ADDRESS + $b3
SPC_PLAY_SOUND_V =          SE_BASE_ADDRESS + $b6
SPC_PLAY_SOUND_EX =         SE_BASE_ADDRESS + $b9


SE_IDENTITY_TABLE =     SE_BASE_ADDRESS + $100

SE_SINE_TABLE = 		SE_BASE_ADDRESS + $200

SE_TEST =				SE_BASE_ADDRESS + $300
SE_TEST_2 =				SE_BASE_ADDRESS + $303




; this is the shittest macro in the history of history
.macro ENGINECALL n, arg1, arg2, arg3, arg4, arg5
	.if n = SE_PPU_SET_SCREEN_BRIGHTNESS
		seta8
		lda arg1
	.endif

	.if n = SE_PPU_FADE_SCREEN_BRIGHTNESS
		setaxy8
		lda arg1
		ldx arg2
	.endif

	.if n = SE_PPU_SET_PALETTE_COLOR
		seta16
		setxy8
		lda arg1
		ldx arg2
	.endif

	.if n = SE_PPU_SET_PALETTE_SET
		seta16
        lda arg1
        sta __rc2
        seta8
        lda arg2
        sta __rc4
        lda arg3
	.endif

	jsl SE_BASE_ADDRESS + (n*3)
.endmacro



;; block move macro (credit to nesdoug)
; memcpy, block move
;for WRAM to WRAM data transfers (can't be done with DMA)
.macro BLOCK_MOVE  length, src_addr, dst_addr
;mnv changes the data bank register, need to preserve it
	phb
    .if .asize = 8
        rep #$30
    .elseif .isize = 8
        rep #$30
    .endif
	lda #(length-1)
	ldx #.loword(src_addr)
	ldy #.loword(dst_addr)	
;	mvn src_bank, dst_bank
	.byte $54, ^dst_addr, ^src_addr
	plb
.endmacro
.define memcpy(to,from,count) BLOCK_MOVE count, from, to


;; dma macro (credit to nesdoug)
.macro DMA_VRAM  length, src_addr, dst_addr
;dst is address in the VRAM
;a should be 8 bit, xy should be 16 bit
    .if .asize = 16
        sep #$20
    .endif
    .if .isize = 8
        rep #$10
    .endif
	ldx #dst_addr
	stx $2116 ; vram address
	
	lda #1
	sta $4370 ; transfer mode, 2 registers 1 write
			  ; $2118 and $2119 are a pair Low/High
	lda #$18  ; $2118
	sta $4371 ; destination, vram data
	ldx #.loword(src_addr)
	stx $4372 ; source
	lda #^src_addr
	sta $4374 ; bank
	ldx #length
	stx $4375 ; length
	lda #%10000000
	sta $420b ; start dma, channel 7
.endmacro
.define memcpy_to_vram(to,from,count) DMA_VRAM count, from, to