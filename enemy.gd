extends KinematicBody2D

onready var player = $"../player"
onready var sprite = $Sprite
var SPEED = 100
var scared = false
var player_vec: Vector2
var state: float = 1.0
func _physics_process(delta):
	player_vec = player.position - self.position
	print(player_vec.length())
	var move_vec = player_vec.normalized() * state * SPEED
	if not scared:
		if move_vec.x > 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	move_and_collide(move_vec * delta)

func scare():
	var timer = $Timer
	if not timer.is_connected("timeout", self, "chill"):
		timer.connect("timeout", self, "chill")
	scared = true
	timer.start()
	sprite.flip_h = !sprite.flip_h
	state = -150 / player_vec.length()
	

func chill():
	scared = false
	sprite.flip_h = !sprite.flip_h
	state = 1