extends Node

func spawn_card(card_scene: PackedScene, pos: Vector2, parent: Node):
	var card_instance = card_scene.instantiate()
	parent.add_child(card_instance)
	card_instance.global_position = pos
