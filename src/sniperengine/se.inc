SE_BASE_ADDRESS = $809000



SE_INIT =                   SE_BASE_ADDRESS

SE_WAIT_VSYNC =             SE_BASE_ADDRESS + $03

SE_PPU_DISABLE_NMI =        SE_BASE_ADDRESS + $06
SE_CPU_ENABLE_NMI =         SE_BASE_ADDRESS + $09

SE_PPU_DISABLE_RENDERING =  SE_BASE_ADDRESS + $0c
SE_PPU_ENABLE_RENDERING =   SE_BASE_ADDRESS + $0f

SE_PPU_SET_SCREEN_BRIGHTNESS =  SE_BASE_ADDRESS + $12
SE_PPU_FADE_SCREEN_BRIGHTNESS = SE_BASE_ADDRESS + $15

SE_PPU_SET_PALETTE_COLOR =      SE_BASE_ADDRESS + $18
SE_PPU_SET_PALETTE_SET =        SE_BASE_ADDRESS + $1b
SE_PPU_CLEAR_PALETTE =          SE_BASE_ADDRESS + $1e

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