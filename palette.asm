load_palettes:
	lda $2002
	lda #$3f
	sta $2006
	ldx #$00
	stx $2006
	
  - lda palette,x
	sta $2007
	inx
	cpx #$20
	bne -
	
	rts
	
; bg/sprite palette data
palette:
	.db $37,$27,$17,$0F,$37,$1A,$29,$0F,$37,$10,$07,$20,$16,$00,$10,$20
	.db $37,$18,$26,$0F,$37,$1C,$37,$0F,$37,$15,$27,$0F,$37,$18,$27,$20
