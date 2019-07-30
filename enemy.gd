extends KinematicBody2D

onready var player = $"../player"
onready var sprite = $Sprite
onready var timer = $Timer
enum states {sleep, chase, scare, kill}
var state = states.sleep
var SPEED = 100
var player_vec: Vector2
func _physics_process(delta):
	player_vec = player.position - self.position
	if state == states.sleep and player_vec.length() < 300:
		state = states.chase
	var speed_mod
	var dir
	match state:
		states.sleep:
			speed_mod = 0
			dir = Vector2.ZERO
		states.chase:
			speed_mod = 100
			dir = player_vec.normalized()
		states.kill:
			speed_mod = 300
			if player_vec.x > 0:
				dir = Vector2.LEFT
			else:
				dir = Vector2.RIGHT
		states.scare:
			speed_mod = 20000/player_vec.length()
			print(speed_mod)
			dir = -player_vec.normalized()
	
	var move_vec = speed_mod * dir
	move_and_collide(move_vec * delta)
	
	sprite.flip_h = true if player_vec.x > 0 else false
	if state == states.scare or state == states.kill:
		sprite.flip_h = !sprite.flip_h

func scare():
	if not timer.is_connected("timeout", self, "chill"):
		timer.connect("timeout", self, "chill")
	state = states.scare
	timer.start()
	sprite.flip_h = !sprite.flip_h

func chill():
	state = states.chase
	sprite.flip_h = !sprite.flip_h
	
func kill():
	timer.connect("timeout", self, "queue_free")
	timer.wait_time = 2
	timer.start()
	self.collision_mask = 0
	state = states.kill
	sprite.flip_h = !sprite.flip_h