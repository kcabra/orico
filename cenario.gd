extends Node

func _ready():
	pass
	
func _process(delta):
	$"./tempo".text = str($"./player".tempo_restante)
