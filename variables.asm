; constants
SPRITES				= $0200
MAX_SPRITES			= 10

; joypads
JOYPAD1 			= $4016
JOYPAD2 			= $4017

; joypad buttons
A					= %10000000
B					= %01000000
SELECT				= %00100000
START				= %00010000
UP					= %00001000
DOWN				= %00000100
LEFT				= %00000010
RIGHT				= %00000001

NORTH				= $00
SOUTH				= $01 
WEST				= $02
EAST				= $03

SPRITE_ID_PLAYER	= $00
SPRITE_ID_BULLET	= $01
SPRITE_ID_ENEMY		= $02

; zero page variables
.enum $0000
	nmis					.dsb 1
	in_nmi					.dsb 1
	
	random_1				.dsb 1
	random_2				.dsb 1
	
	level_num				.dsb 1
	nt_low					.dsb 1
	nt_high					.dsb 1
	
	low_addr				.dsb 1
	high_addr				.dsb 1
	
	joypad_1				.dsb 1
	joypad_1_old			.dsb 1
	joypad_1_pressed		.dsb 1
	
	sprite_id				.dsb 10
	sprite_x				.dsb 10
	sprite_y				.dsb 10
	sprite_base_tile		.dsb 10
	sprite_tile				.dsb 10
	sprite_attrib			.dsb 10
	sprite_moving			.dsb 10
	sprite_animated			.dsb 10
	
	sprite_dir				.dsb 10
	sprite_frame			.dsb 10
	sprite_delay			.dsb 10
	
	new_x					.dsb 1
	new_y					.dsb 1
	
	collide_x				.dsb 1
	collide_y				.dsb 1
	index					.dsw 1
	
	new_sprite_id			.dsb 1
	new_sprite_x			.dsb 1
	new_sprite_y			.dsb 1
	new_sprite_dir			.dsb 1
	new_sprite_base_tile	.dsb 1
	new_sprite_moving		.dsb 1
	new_sprite_animated		.dsb 1
.ende
