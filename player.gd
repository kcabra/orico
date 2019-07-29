extends KinematicBody2D

var move_vec:= Vector2()
var ACCEL = 0.1
var SPEED = 1
var GRAV = 0.2
var MAX_GRAV = 0.8
var gasta_tempo = false
var tempo_restante = 5
var consumo = 5


func cooldown(delta):
	tempo_restante = 5 - consumo
	if gasta_tempo:
		consumo += delta*1.5
		
	elif !gasta_tempo and tempo_restante < 5:
		consumo -= delta


func _physics_process(delta):
	cooldown(delta)
	if Input.is_action_pressed("game_right"):
		move_vec.x = SPEED
	elif Input.is_action_pressed("game_left"):
		move_vec.x = -SPEED
	elif move_vec.x != 0:
		move_vec.x -= move_vec.normalized().x * ACCEL
		if abs(move_vec.x) < (ACCEL):
			move_vec.x = 0
	
	if Input.is_action_pressed("game_jump") and tempo_restante > 0:
		move_vec.y = -1.2
		gasta_tempo = true

	elif Input.is_action_just_released("game_jump"):
		gasta_tempo = false

	elif move_vec.y < MAX_GRAV:
		move_vec.y += GRAV
	move_and_collide(move_vec)