extends Node

var menu
var game_state = "title"

func _ready():
	menu = preload("res://scenes/menu.tscn")

func game_over():
	game_state = "game_over"
	get_tree().change_scene_to(menu)

func win():
	game_state = "win"
	get_tree().change_scene_to(menu)