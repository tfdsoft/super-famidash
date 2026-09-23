

.define Metatile(name, tl, tr, bl, br, collision) .word tl, tr, bl, br



.define TILE(id, PALBANK, hflip, vflip) ((id&1023)+((PALBANK&7)<<10)+((hflip&1)<<14)+((vflip&1)<<15))

.define H 1
.define V 1

.define LBG_PAL 2
.define COL1_PAL 3
.define COL2_PAL 4
.define COL3_PAL 5
.define COL4_PAL 6
.define PLAYER_PAL 7