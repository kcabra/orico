extends Control

onready var hbox = $"MarginContainer/HBoxContainer"
onready var tprogress = $"MarginContainer2/TextureProgress"
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var vp = get_viewport()

var active_hearts = Array()

func _process(delta):
	if tprogress.value < tprogress.max_value:
		tprogress.value += delta

func _ready():
	tprogress.max_value = player.get_node("Cooldown").wait_time
	tprogress.value = tprogress.max_value
	var heart_sprite = load("res://assets/heart.png")
	for i in range(player.HP):
		var heart = TextureRect.new()
		heart.texture = heart_sprite
		hbox.add_child(heart)
		active_hearts.append(heart)

func attack():
	tprogress.value = 0

func hit():
	var heart = active_hearts.pop_back()
	if heart:
		heart.queue_free()