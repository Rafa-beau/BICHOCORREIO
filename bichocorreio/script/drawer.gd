extends Area2D
class_name drawer
@export var card_scene: PackedScene

var card_instance


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		card_instance = card_scene.instantiate()
		add_child(card_instance)
	
		card_instance.global_position = global_position + Vector2(40,0)
		card_instance.start_drag()
