# SniperEngine-SFC
## about
in-house library for tfdsoft's sfc/snes projects.

## how to use
ok so basically, what you wanna do is compile `sniperengine.s` separately.
then you wanna `.include "se.inc"` and use the `ENGINECALL` macro in your asm files.

## register key
```
A: A
A8: A is 8-bits wide
A16: A is 16-bits wide
D: Direct Page 
DB: Data Bank 
K: bank byte of the program counter 
P: Processor status 
PC: Program Counter 
SP: Stack Pointer 
X: X 
Y: Y
X8/Y8: X/Y is 8-bits wide
X16/Y16: X/Y is 16-bits wide

__rcX: additional cpu registers at $000000-$00001F.
	__rc0-__rc1 is the secondary stack pointer.
	__rc2-__rc19 are call-clobbered (used to pass parameters and scratch)
	__rc20-__rc31 are call-preserved (saved and restored if used by a function)

if a register is in the arguments list, assume it is clobbered.
if P is clobbered, assume the register size isn't preserved.
```
## functions at a glance

|Function Name|Type|Description|Arguments|Clobbers|Returns|
|--|--|--|--|--|--|
|SE_INIT|Misc.|Init CPU/PPU registers|none|A X D|none|
|SE_WAIT_VSYNC|CPU|Put the CPU in low power mode until V-Blank starts|none|A|none|
|SE_CPU_DISABLE_NMI|CPU|Disable the CPU's NMI signal|none|A P|none|
|SE_CPU_ENABLE_NMI|CPU|Enable the CPU's NMI signal|none|A P|none|
|SE_PPU_DISABLE_RENDERING|Video|Disable PPU output at the next V-Blank|none|A P|none|
|SE_PPU_ENABLE_RENDERING|Video|Enable PPU output at the next V-Blank|none|A P|none|
|SE_PPU_SET_SCREEN_BRIGHTNESS|Video|Set the brightness of the screen|A8(brightness)|P __rc2|none|
|SE_PPU_FADE_SCREEN_BRIGHTNESS|Video|Fade the screen from one brightness level to another|A8(from) X8(to)|Y P __rc2 __rc3|none|
|SE_PPU_SET_PALETTE_COLOR|Color|Set one palette index to an rgb555 color|A16(rgb555 color) X8(index)|none|none|
|SE_PPU_SET_PALETTE_SET|Color|Set a palette of 16 colors|A8(palette set) __rc2(24)(palette data addr)|X Y P __rc6 __rc7 __rc8 __rc9|none|
|SE_PPU_CLEAR_PALETTE|Color|Set all 256 colors to black|none|A X P|none|
|SE_PPU_ENABLE_LAYER_MAIN|Video|Enable PPU layers on the main screen|A8(layers)|none|none|
|SE_PPU_ENABLE_LAYER_SUB|Video|Enable PPU layers on the sub screen|A8(layers)|none|none|
|SE_PPU_DISABLE_LAYER_MAIN|Video|Disable PPU layers on the main screen|A8(layers)|none|none|
|SE_PPU_DISABLE_LAYER_SUB|Video|Disable PPU layers on the sub screen|A8(layers)|none|none|
|SE_PPU_SET_REGISTER|Video|Set a value in the PPU register buffer. See [Register Buffer](#register-buffer) for details|A8/A16(value) X8(register)|P|none|
|SE_PPU_SET_SCROLL|Video|Set a background's scroll offset|A8(layer) __rc2(16)(Xscroll) __rc4(16)(Yscroll)|X P|none|
|SE_OAM_CLEAR|Sprites|Reset objects|none|none|none|
|SE_OAM_DRAW_SPRITE|Sprites|Add one object to the screen|A16(Xpos.0-8,Size.9) X8(Ypos) __rc2(16)(Tile/Attributes)|Y P __rc4 __rc5|none|
|SE_OAM_DRAW_METASPRITE|Sprites|Draw a metasprite to the screen|A8(Xpos(lo)) X8(Xpos(hi)) __rc2(24)(Metatile data addr) __rc5(8)(Ypos)|Y P __rc6 __rc7 __rc8 __rc9 __rc10 __rc11 __rc12 __rc13|none|
|SE_GRAY_LINE|Debug|Draw a gray line to the screen|none|A P|none|
|SE_VRAM_BUFFER_ADD|Video|Add a variety of stuff to the VRAM buffer. See [VRAM buffer](#vram-buffer) for details|A8(VMAIN) X8/__rc2 __rc3(16) __rc5(24)|Y P __rc8 __rc9 __rc10|none|



### register buffer
(TODO)
<!--
# function guide
### 0 - init
```
arguments:	none
returns:	none
clobbers:	A, X, DP
```
Initializes the registers of the CPU, PPU, and DMA.
#### example:
```
ENGINECALL se_init
```

---
### 1 - cpu_disable_nmi
```
arguments:	none
returns:	none
clobbers: 	A, P
```
Disables the Non-Maskable Interrupt.
#### example:
```
ENGINECALL se_cpu_disable_nmi
```

---

### 2 - cpu_enable_nmi
```
arguments:	none
returns:	none
clobbers: 	A, P
```
Enables the Non-Maskable Interrupt.
#### example:
```
ENGINECALL se_cpu_enable_nmi
```

---
-->
