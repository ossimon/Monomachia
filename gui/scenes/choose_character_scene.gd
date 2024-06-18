extends Control


var characters = ["res://scenes/characters/Golem/golem.tscn", "res://scenes/characters/Lich/lich.tscn", "res://scenes/characters/Paladin/paladin.tscn"]
var characters_textures = ["res://sprites/characters/golem/golem_res.png", "res://sprites/characters/lich/lich_res.png", "res://sprites/characters/paladin/paladin_res.png"]

var player1_index = 0
var player2_index = 0
var player1_current_character = null
var player2_current_character = null

func _ready():
	set_player1_character(player1_index)
	set_player2_character(player2_index)

func set_player1_character(index):
	$CanvasLayer/Player1.set_texture(load(characters_textures[index]))

func set_player2_character(index):
	$CanvasLayer/Player2.set_texture(load(characters_textures[index]))

func _on_prev_character_1_pressed():
	player1_index = (player1_index - 1) % len(characters)
	set_player1_character(player1_index)

func _on_next_character_1_pressed():
	player1_index = (player1_index + 1) % len(characters)
	set_player1_character(player1_index)

func _on_prev_character_2_pressed():
	player2_index = (player2_index - 1) % len(characters)
	set_player2_character(player2_index)

func _on_next_character_2_pressed():
	player2_index = (player2_index + 1) % len(characters)
	set_player2_character(player2_index)


func _on_confirm_button_1_pressed():
	player1_current_character = characters[player1_index]

func _on_confirm_button_2_pressed():
	player2_current_character = characters[player2_index]

func _on_start_button_pressed():
	if player1_current_character != null and player2_current_character != null:
		SceneSwitcher.switch_scene_and_add_players(
			"res://scenes/levels/default_level/default_level.tscn",
			player1_current_character,
			player2_current_character
		)
