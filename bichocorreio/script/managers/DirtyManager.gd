extends Node

@export var current_card: Node

func _on_dirt_area_mouse_entered() -> void:
	$Dirt_par.hide()
	
