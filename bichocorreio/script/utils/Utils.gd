extends Node

@onready var table = ("res://node/table.tscn")
var card_scene := preload("res://node/card.tscn")
var parent = self
var card_instance

func spawn_card(card_scene: PackedScene, pos: Vector2, parent: Node):
	var card_instance = card_scene.instantiate()
	parent.add_child(card_instance)
	card_instance.global_position = pos
	print("criou")
	
	return card_instance

func set_cursor(img_path:String):
	Input.set_custom_mouse_cursor(load(img_path))

func disable_cursor():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
func enable_cursor():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func timer(sec: float):
	await get_tree().create_timer(sec).timeout
