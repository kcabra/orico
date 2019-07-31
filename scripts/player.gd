extends KinematicBody2D

onready var sprite = $Sprite
onready var hitbox = $ScareZone
onready var killzone = $KillZone
onready var cooldown = $Cooldown

var HP = 3

var SPEED = 100
var GRAV = 10
var JUMP = 80
var MAX_GRAV = 80

var move_vec:= Vector2()
var facing_left: bool
func _physics_process(delta):
	#<movement logic>
	if not being_hit:
		if Input.is_action_pressed("game_right"):
			move_vec.x = SPEED
			facing_left = false
		elif Input.is_action_pressed("game_left"):
			move_vec.x = -SPEED
			facing_left = true
		elif move_vec.x != 0:
			move_vec.x = 0
		
		if Input.is_action_pressed("game_jump"):
			move_vec.y = -JUMP
	
	if move_vec.y < MAX_GRAV:
		move_vec.y += GRAV
	
	sprite.flip_h = facing_left
	#</movement logic>
	
	#<attack logic>
	if Input.is_action_just_pressed("game_attack") and cooldown.time_left == 0:
		scare()
	#</attack logic>
	
	#<actual movement>
	var collision = move_and_collide(move_vec * delta)
	if collision:
		move_and_collide(move_vec.slide(collision.normal))
	#</actual movement>

func scare(kill=true):
	get_tree().call_group("ui", "attack")
	cooldown.start()
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
		for _i in range(3):
			modulate = Color(5, 0, 0) # red
			yield(get_tree().create_timer(0.1), "timeout")
			modulate = Color.white
			yield(get_tree().create_timer(0.1), "timeout")
		being_hit = false
	