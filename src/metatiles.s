.include "metatiles_macro.inc"



.segment "BANK_C1"
metatiles:
    Metatile("AIR",            TILE($00, 0, 0, 0), TILE($00, 0, 0, 0), TILE($00, 0, 0, 0), TILE($00, 0, 0, 0), COL_NONE)
    Metatile("SPIKE_UP",       TILE($53, 0, 0, 0), TILE($54, 0, 0, 0), TILE($55, 0, 0, 0), TILE($56, 0, 0, 0), COL_SPIKE_TOP)
    Metatile("BASIC_BLOCK",    TILE($0e, 0, 0, 0), TILE($0f, 0, 0, 0), TILE($10, 0, 0, 0), TILE($11, 0, 0, 0), COL_FULL)
    
    Metatile("CHK_FULL",       TILE($01, 0, 0, 0), TILE($01, 0, H, 0), TILE($01, 0, 0, V), TILE($01, 0, H, V), COL_FULL)
    Metatile("CHK_SIDE_UP",    TILE($02, 0, 0, 0), TILE($02, 0, H, 0), TILE($03, 0, 0, 0), TILE($03, 0, H, 0), COL_FULL)
    Metatile("CHK_SIDE_DOWN",  TILE($03, 0, 0, V), TILE($03, 0, H, V), TILE($02, 0, 0, V), TILE($02, 0, H, V), COL_FULL)
    Metatile("CHK_SIDE_LEFT",  TILE($04, 0, 0, 0), TILE($05, 0, 0, 0), TILE($04, 0, 0, V), TILE($05, 0, 0, V), COL_FULL)
    Metatile("CHK_SIDE_RIGHT", TILE($05, 0, H, 0), TILE($04, 0, H, 0), TILE($05, 0, H, V), TILE($04, 0, H, V), COL_FULL)
    Metatile("CHK_CORNER_TL",  TILE($06, 0, 0, 0), TILE($02, 0, H, 0), TILE($04, 0, 0, V), TILE($07, 0, 0, 0), COL_FULL)
    Metatile("CHK_CORNER_TR",  TILE($02, 0, 0, 0), TILE($06, 0, H, 0), TILE($07, 0, H, 0), TILE($04, 0, H, V), COL_FULL)
    Metatile("CHK_CORNER_BL",  TILE($04, 0, 0, 0), TILE($07, 0, 0, V), TILE($06, 0, 0, V), TILE($02, 0, H, V), COL_FULL)
    Metatile("CHK_CORNER_BR",  TILE($07, 0, H, V), TILE($04, 0, H, 0), TILE($02, 0, 0, V), TILE($06, 0, H, V), COL_FULL)
    Metatile("CHK_CRN_INS_TL", TILE($08, 0, 0, 0), TILE($05, 0, 0, 0), TILE($03, 0, 0, 0), TILE($09, 0, 0, 0), COL_FULL)
    Metatile("CHK_CRN_INS_TR", TILE($05, 0, H, 0), TILE($08, 0, H, 0), TILE($09, 0, H, 0), TILE($03, 0, H, 0), COL_FULL)
    Metatile("CHK_CRN_INS_BL", TILE($03, 0, 0, V), TILE($09, 0, 0, V), TILE($08, 0, 0, V), TILE($05, 0, 0, V), COL_FULL)
    Metatile("CHK_CRN_INS_BR", TILE($09, 0, H, V), TILE($03, 0, H, V), TILE($05, 0, H, V), TILE($08, 0, H, V), COL_FULL)
    Metatile("CHK_DB_CRN_TOP", TILE($06, 0, 0, 0), TILE($06, 0, H, 0), TILE($04, 0, 0, V), TILE($04, 0, H, V), COL_FULL)
    Metatile("CHK_DB_CRN_BOT", TILE($04, 0, 0, 0), TILE($04, 0, H, 0), TILE($06, 0, 0, V), TILE($06, 0, H, V), COL_FULL)
    Metatile("CHK_DB_CRN_LFT", TILE($06, 0, 0, 0), TILE($02, 0, H, 0), TILE($06, 0, 0, V), TILE($02, 0, H, V), COL_FULL)
    Metatile("CHK_DB_CRN_RGT", TILE($02, 0, 0, 0), TILE($06, 0, H, 0), TILE($02, 0, 0, V), TILE($06, 0, H, V), COL_FULL)
    Metatile("CHK_DB_SIDE_V",  TILE($04, 0, 0, 0), TILE($04, 0, H, 0), TILE($04, 0, 0, V), TILE($04, 0, H, V), COL_FULL)
    Metatile("CHK_DB_SIDE_H",  TILE($02, 0, 0, 0), TILE($02, 0, H, 0), TILE($02, 0, 0, V), TILE($02, 0, H, V), COL_FULL)
    Metatile("CHK_FILLER",     TILE($0a, 0, 0, 0), TILE($0a, 0, H, 0), TILE($0a, 0, 0, V), TILE($0a, 0, H, V), COL_NONE)