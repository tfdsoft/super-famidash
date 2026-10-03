;************************************************
; snesmod soundbank data                        *
; total size:      25360 bytes                  *
;************************************************

	.global __SOUNDBANK__
	.segment "SOUNDBANK" ; need dedicated bank(s)

__SOUNDBANK__:
	.incbin "test.bank"
