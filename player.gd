extends KinematicBody2D

var move_vec:= Vector2()
var ACCEL = 0.1
var SPEED = 1
var GRAV = 0.2
var MAX_GRAV = 0.8

func _physics_process(delta):
	cooldown(delta)
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
	
#<<<<<<< HEAD
##	if Input.is_action_pressed("game_jump"):
##		move_vec.y = -3
##	if move_vec.y < MAX_GRAV:
##		move_vec.y += GRAV
#	move_and_collide(move_vec)
#=======
	if Input.is_action_pressed("game_jump") and tempo_restante > 0:
		move_vec.y = -1.2
		gasta_tempo = true

	elif Input.is_action_just_released("game_jump"):
		gasta_tempo = false

	elif move_vec.y < MAX_GRAV:
		move_vec.y += GRAV
	move_and_collide(move_vec)

var gasta_tempo = false
var tempo_restante = 5
var consumo = 5
func cooldown(delta):
	tempo_restante = 5 - consumo
	if gasta_tempo:
		consumo += delta*1.5

	elif !gasta_tempo and tempo_restante < 5:
		consumo -= delta
#<<<<<<< master

onready var sprite = $Sprite
onready var hitbox = $ScareZone
onready var killzone = $KillZone
func _process(_delta):
	if Input.is_action_just_pressed("game_attack"):
		for node in hitbox.get_overlapping_bodies():
			if node.is_in_group("enemy"):
				if killzone.overlaps_body(node):
					node.kill()
				else:
					node.scare()
		sprite.frame = 1
		yield(get_tree().create_timer(0.6), "timeout")
		sprite.frame = 0