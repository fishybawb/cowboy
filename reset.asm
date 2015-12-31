reset:
	sei
	cld
	ldx #$40
	stx $4017
	ldx #$FF
	txs
	inx

	stx $2000
	stx $2001
	stx $4010

  - bit $2002
	bpl -

  - lda #$00
	sta $0000,x
	sta $0100,x
	sta $0300,x
	sta $0400,x
	sta $0500,x
	sta $0600,x
	sta $0700,x
	lda #$FE
	sta $0200, x
	inx
	bne -

  - bit $2002
	bpl -
