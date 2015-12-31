init_sprites:
	ldx #$00
	lda #$FE
  - sta sprite_y,x
	inx
	cpx #MAX_SPRITES
	bne -
	
	rts

update_sprites:
	ldx #$00
  - lda sprite_y,x
	cmp #$EF
	bne +
	jmp update_next_sprite
	
  +	lda sprite_moving,x
	bne move_sprite
	
	; sprite isn't moving, set tile to static frame based on direction
	ldy sprite_dir,x
	lda static_frame,y
	clc
	adc sprite_base_tile,x
	sta sprite_tile,x
	jmp update_next_sprite
	
move_sprite:
	lda sprite_x,x
	sta new_x
	lda sprite_y,x
	sta new_y
	
	ldy sprite_dir,x
	
	; horizontal position change
	lda sprite_id,x
	cmp #SPRITE_ID_BULLET
	bne +
	lda fast_move_x,y
	jmp add_x
  + lda slow_move_x,y
add_x:
	clc
	adc new_x
	sta new_x
	
	; vertical position change
	lda sprite_id,x
	cmp #SPRITE_ID_BULLET
	bne +
	lda fast_move_y,y
	jmp add_y
  +	lda slow_move_y,y
add_y:
	clc
	adc new_y
	sta new_y
	
	lda new_x
	clc
	adc hit_x_offset,y
	sta collide_x
	
	lda new_y
	clc
	adc hit_y_offset,y
	sta collide_y
	
	jsr check_bg_collision
	bne collision_occurred
	
	; no collision with bg
	lda new_x
	sta sprite_x,x
	lda new_y
	sta sprite_y,x
	
	; don't bother animating sprites that aren't animated
	lda sprite_animated,x
	bne cycle_animation
	jmp update_next_sprite
	
collision_occurred:
	lda sprite_id,x
	cmp #SPRITE_ID_BULLET
	bne cycle_animation
	
	lda #$FE
	sta sprite_y,x
	lda #$00
	sta sprite_moving,x
	
cycle_animation:			
  	lda sprite_delay,x
	cmp #$08
	beq delay_done
	inc sprite_delay,x
	jmp update_tile
	
delay_done:
	lda #$00
	sta sprite_delay,x
	
	; update frame
	lda sprite_frame,x
	cmp #$02
	beq reset_frame
	inc sprite_frame,x
	jmp update_tile
	
reset_frame:
	lda #$00
	sta sprite_frame,x
	
update_tile:
	ldy sprite_dir,x
	lda static_frame,y
	clc
	adc sprite_base_tile,x
	clc
	adc sprite_frame,x
	sta sprite_tile,x
	
update_next_sprite:
	inx
	cpx #MAX_SPRITES
	beq +
	jmp -
	
  +	rts

copy_sprite_data:
	ldx #$00
	ldy #$00
  - lda sprite_y,x
	cmp #$EF
	beq copy_next_sprite
	
	; transfer sprite data from variables to oam copy
	sta SPRITES,y
	iny
	lda sprite_tile,x
	sta SPRITES,y
	iny
	lda sprite_attrib,x
	sta SPRITES,y
	iny
	lda sprite_x,x
	sta SPRITES,y
	iny
	
copy_next_sprite:
	inx
	cpx #MAX_SPRITES
	bne -

	rts

add_sprite:
	ldx #$01
  - lda sprite_y,x
	cmp #$FE
	beq found_space
	inx
	cpx #MAX_SPRITES
	bne -
	jmp +
	
found_space:
	lda new_sprite_moving
	sta sprite_moving,x
	lda new_sprite_id
	sta sprite_id,x
	lda new_sprite_x
	sta sprite_x,x
	lda new_sprite_y
	sta sprite_y,x
	lda new_sprite_base_tile
	sta sprite_base_tile,x
	sta sprite_tile,x
	lda new_sprite_dir
	sta sprite_dir,x
	lda new_sprite_animated
	sta sprite_animated,x
	
  +	rts

; called with sprite number in x  
fire_bullet:
    lda #SPRITE_ID_BULLET
	sta new_sprite_id
	lda sprite_x,x
	sta new_sprite_x
	lda sprite_y,x
	sta new_sprite_y
	ldx sprite_dir
	stx new_sprite_dir
	lda bullet_tiles,x
	sta new_sprite_base_tile
	lda #$01
	sta new_sprite_moving
	lda #$00
	sta new_sprite_animated
	jsr add_sprite
	
	rts
