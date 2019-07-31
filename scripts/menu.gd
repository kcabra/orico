extends CanvasItem

onready var play = $"title/play"
onready var credits = $"title/credits"
onready var exit = $"title/exit"

var state
var game_scene

func _ready():
	state = game.game_state
	game_scene = preload("res://aquarium.tscn")

func _process(_delta):
	for node in get_children():
		if node.name == state:
			node.visible = true
		else:
			node.visible = false
		pass
	match state:
		"title":
			if Input.is_action_just_pressed("ui_click"):
				var mouse = get_local_mouse_position()
				if play.get_rect().has_point(mouse):
					state = "tutorial"
				elif credits.get_rect().has_point(mouse):
					state = "credits"
				elif exit.get_rect().has_point(mouse):
					get_tree().quit()
		"tutorial":
			if Input.is_action_just_pressed("ui_click"):
				get_tree().change_scene_to(game_scene)
		"credits", "win", "game_over":
			if Input.is_action_just_pressed("ui_click"):
				state = "title"
				game.game_state = "title"
