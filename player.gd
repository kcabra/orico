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
	
#	if Input.is_action_pressed("game_jump"):
#		move_vec.y = -3
#	if move_vec.y < MAX_GRAV:
#		move_vec.y += GRAV
	move_and_collide(move_vec)

onready var sprite = $Sprite
onready var hitbox = $Area2D
var scary: bool
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		for node in hitbox.get_overlapping_bodies():
			if node.is_in_group("enemy"):
				node.scare()
		sprite.frame = 1
		yield(get_tree().create_timer(0.6), "timeout")
		sprite.frame = 0
