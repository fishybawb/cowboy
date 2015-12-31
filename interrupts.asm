; nmi routine
nmi:
	pha
    txa
    pha
    tya
    pha

	lda in_nmi
	bne +
	
	jsr get_random

	; oam transfer from copy ($0200)
	lda #$00
	sta $2003
	lda #$02
	sta $4014

	lda #$00
	sta $2005
	sta $2005

  +	lda #$00
    sta nmis

	pla
    tay
    pla
    tax
    pla

	rti

; irq unused
irq:
	rti
