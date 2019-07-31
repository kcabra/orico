extends Control

onready var hbox = $"MarginContainer/HBoxContainer"
onready var player = get_tree().get_nodes_in_group("player")[0]

var active_hearts = Array()

func _ready():
	var heart_sprite = load("res://assets/heart.png")
	for i in range(player.HP):
		var heart = TextureRect.new()
		heart.texture = heart_sprite
		hbox.add_child(heart)
		active_hearts.append(heart)

func hit():
	var heart = active_hearts.pop_back()
	if heart:
		heart.queue_free()