init_title_screen:
	lda level_num
	jsr draw_nametable
	
	bit $2002
	lda #%10001000
	sta $2000
	lda #%00011110
	sta $2001
	
	jsr init_sprites
	jmp do_level_loop

title_loop:
  	jsr read_joypad
	lda joypad_1_pressed
	cmp #START
	bne title_loop
	
	lda #$01
	sta level_num
	jmp do_level_init
	
init_game_screen:
	jsr wait_for_vblank
	lda #$00
	sta $2001

	lda level_num
	jsr draw_nametable
	
	jsr wait_for_vblank
	lda #%10001000
	sta $2000
	lda #%00011110
	sta $2001

	jsr init_player
	jsr add_enemies
	jmp do_level_loop

game_loop:
	lda #$00
	sta joypad_1_pressed

	jsr wait_for_vblank

	jsr read_joypad
	jsr copy_sprite_data
	jsr ai_routine
	jsr update_sprites 
	
	jsr check_player_input
	jmp game_loop
