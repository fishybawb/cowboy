check_bg_collision:
	lda #$00
	sta index+1
	
	lda collide_y
	and #%11111000
	
	asl
	rol index+1
	asl
	rol index+1
	
	adc nt_low
	sta index
	lda index+1
	adc nt_high
	sta index+1
	
	lda collide_x
	lsr
	lsr
	lsr
	
	tay
	lda (index),y
	
	rts

