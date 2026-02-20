extends Node

@onready var table = ("res://node/table.tscn")
var card_scene := preload("res://node/card.tscn")
var parent = self
var card_instance

func spawn_card(card_scene: PackedScene, pos: Vector2, parent: Node):
	var card_instance = card_scene.instantiate()
	parent.add_child(card_instance)
	card_instance.global_position = pos
	return card_instance

#func remove_card():
	#for card_instance in get_children(card_instance):
			#card_instance.queue_free()
#
#func start_turn():
	#print("comecando turno")
	##remover table.current_card antiga se ja tiver
	#
	#if table.current_card:
		#table.current_card.queue_free()
	##colocar uma nova
	#table.current_card = spawn_card(card_scene, Vector2(198, 85), parent) 
	#return table.current_card
