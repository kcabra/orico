extends KinematicBody2D


var move_vec:= Vector2()
var ACCEL = 0.5
var SPEED = 3
var GRAV = 0.2
var MAX_GRAV = 2
func _physics_process(delta):
	if Input.is_action_pressed("game_right"):
		move_vec.x = SPEED
	elif Input.is_action_pressed("game_left"):
		move_vec.x = -SPEED
	elif move_vec.x != 0:
		move_vec.x -= move_vec.normalized().x * ACCEL * 2
		if abs(move_vec.x) < (ACCEL*2):
			move_vec.x = 0
	
	if Input.is_action_pressed("game_jump"):
		move_vec.y = -3
	if move_vec.y < MAX_GRAV:
		move_vec.y += GRAV
	move_and_collide(move_vec)