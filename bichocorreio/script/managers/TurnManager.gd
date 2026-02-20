extends Node

var card_scene := preload("res://node/card.tscn")
var parent = self
var carta

func _ready() -> void:
	start_turn()
	loop()
	
func loop():
	while true:
		await get_tree().create_timer(2).timeout
		start_turn()
	
func start_turn():
	print("comecando turno")
	#remover carta antiga se ja tiver
	
	if carta:
		carta.queue_free()
	#colocar uma nova
	carta = Utils.spawn_card(
card_scene, Vector2(198, 85), parent)
	
	
