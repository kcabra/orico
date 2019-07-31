extends KinematicBody2D

var HP = 5

var move_vec:= Vector2()
var ACCEL = 0.1
var SPEED = 1
var GRAV = 0.2
var MAX_GRAV = 0.8

func _physics_process(delta):
	if not being_hit:
		if Input.is_action_pressed("game_right"):
			move_vec.x = SPEED
			sprite.flip_h = false
		elif Input.is_action_pressed("game_left"):
			move_vec.x = -SPEED
			sprite.flip_h = true
		elif move_vec.x != 0:
			move_vec.x -= move_vec.normalized().x * ACCEL
			if abs(move_vec.x) < (ACCEL):
				move_vec.x = 0
	
		if Input.is_action_pressed("game_jump"):
			move_vec.y = -1.2
		elif move_vec.y < MAX_GRAV:
			move_vec.y += GRAV

	move_and_collide(move_vec)

onready var sprite = $Sprite
onready var hitbox = $ScareZone
onready var killzone = $KillZone
func _process(_delta):
	if Input.is_action_just_pressed("game_attack"):
		scare()

func scare(kill=true):
	for node in hitbox.get_overlapping_bodies():
		if node.is_in_group("enemy"):
			if kill:
				if killzone.overlaps_body(node):
					node.kill()
				else:
					node.scare()
			else:
				node.scare()
	sprite.frame = 1
	yield(get_tree().create_timer(0.6), "timeout")
	sprite.frame = 0

var being_hit = false
func hit(normal):
	if not being_hit:
		being_hit = true
		move_vec = -normal * (SPEED)
		scare(false)
		HP -= 1
		get_tree().call_group("ui", "hit")
		for i in range(3):
			modulate = Color(5, 0, 0) # red
			yield(get_tree().create_timer(0.1), "timeout")
			modulate = Color.white
			yield(get_tree().create_timer(0.1), "timeout")
		being_hit = false
	