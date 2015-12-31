static_frame:
	.db $00,$03,$06,$09

; move by one pixel per frame	
slow_move_x:
	.db $00,$00,$FF,$01
slow_move_y:
	.db $FF,$01,$00,$00

; move by two pixels per frame
fast_move_x:
	.db $00,$00,$FE,$02
fast_move_y:
	.db $FE,$02,$00,$00
	
hit_x_offset:
	.db $04,$04,$00,$06
hit_y_offset:
	.db $01,$08,$08,$08

bullet_tiles:
	.db $10,$11,$12,$13

level_bg_pointer:
	.dw title_bg,game_bg

init_pointer:
	.dw init_title_screen,init_game_screen
	
level_pointer:
	.dw title_loop,game_loop
