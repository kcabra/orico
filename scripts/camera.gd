extends Camera2D

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var viewport = get_viewport()

func _process(_delta):
	var off = viewport.size.x * -0.2 # offset
	if player.facing_left:
		off = -off
		self.position.x = player.position.x + off - viewport.size.x
	else:
		self.position.x = player.position.x + off