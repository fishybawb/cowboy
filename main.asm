.include "variables.asm"

.include "ines_header.asm"

	.include "reset.asm"
	jsr load_palettes

	jsr seed_rng
	lda #$00
	sta level_num

do_level_init:
	lda level_num
	asl
	tax
	lda init_pointer+0,x
	sta low_addr
	lda init_pointer+1,x
	sta high_addr
	jmp (low_addr)
	
do_level_loop:
	lda level_num
	asl
	tax
	lda level_pointer+0,x
	sta low_addr
	lda level_pointer+1,x
	sta high_addr
	jmp (low_addr)

wait_for_vblank:
	inc nmis
  - lda nmis
	bne -
	rts

; initialise player variables
init_player:
	lda #$00
	sta sprite_base_tile
	lda #$70
	sta sprite_x
	sta sprite_y
	lda #NORTH
	sta sprite_dir
	lda #SPRITE_ID_PLAYER
	sta sprite_id
	lda #$01
	sta sprite_animated
	rts
	
seed_rng:
	lda #42
	sta random_1
	eor #$FF
	sta random_2
	rts
	
get_random:
	lda random_1
	lsr
	rol random_2
	bcc +
	eor #$B4
  + sta random_1
	eor random_2
	rts

.include "interrupts.asm"
.include "palette.asm"
.include "joypad.asm"
.include "sprite.asm"
.include "collision.asm"
.include "enemy.asm"

.include "screens.asm"
.include "data_tables.asm"	
.include "nametables.asm"

; interrupt vectors
.org $fffa
.dw nmi
.dw reset
.dw irq

; chr-rom
.incbin "new_tiles.chr"
