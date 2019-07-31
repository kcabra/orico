extends Node

func _ready():
	for child in get_children():
		if not child is Polygon2D:
			remove_child(child)
			child.queue_free()
	
	for child in get_children():
		child.color = Color("ee9e40")
		var collision_geometry = CollisionPolygon2D.new()
		collision_geometry.name = "Collision"+child.name
		collision_geometry.polygon = child.polygon
		collision_geometry.visible = false
		add_child(collision_geometry, true)
