;;
;; CONFIG
;;
SE_ZEROPAGE_SEGMENT = "ZEROPAGE"
SE_BSS_SEGMENT      = "HIRAM1"
SE_ENGINE_SEGMENT   = "SNIPERENGINE"




;; 
;; you shouldn't have to touch anything below this.
;;
.segment SE_ZEROPAGE_SEGMENT


.segment SE_BSS_SEGMENT



.segment SE_ENGINE_SEGMENT
    ; every sniperengine instance starts with a jump table lmao
    ; jmp your_moms_house




















    ; $8100: sine table
    .align 256

    