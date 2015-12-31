add_enemies:
	lda #SPRITE_ID_ENEMY
	sta new_sprite_id
	jsr get_random
	sta new_sprite_x
	lda #$90
	sta new_sprite_y
	lda #NORTH
	sta new_sprite_dir
	lda #$00
	sta new_sprite_animated
	sta new_sprite_moving
	sta new_sprite_base_tile
	jsr add_sprite

	rts

ai_routine:
	
	rts
