read_joypad:
	lda joypad_1
	sta joypad_1_old
	
	lda #$01
	sta JOYPAD1
	sta joypad_1
	lsr a
	sta JOYPAD1
  - lda JOYPAD1
	lsr a
	rol joypad_1
	bcc -

	lda joypad_1_old
	eor #$FF
	and joypad_1
	sta joypad_1_pressed
	
	rts

check_player_input:
	lda joypad_1
	and #%00001111
	beq not_moved

	lda #$01
	sta sprite_moving
	
	lda joypad_1
	and #UP
	beq check_down
	lda #NORTH
	sta sprite_dir
	jmp check_a
	
check_down:
	lda joypad_1
	and #DOWN
	beq check_left
	lda #SOUTH
	sta sprite_dir
	jmp check_a
	
check_left:
	lda joypad_1
	and #LEFT
	beq check_right
	lda #WEST
	sta sprite_dir
	jmp check_a
	
check_right:
	lda joypad_1
	and #RIGHT
	bne +
	rts
  +	lda #EAST
	sta sprite_dir
	jmp check_a
	
not_moved:
	lda #$00
	sta sprite_moving
	
check_a:
	lda joypad_1_pressed
	and #A
	beq +
	ldx #SPRITE_ID_PLAYER
	jmp fire_bullet
  +	rts
