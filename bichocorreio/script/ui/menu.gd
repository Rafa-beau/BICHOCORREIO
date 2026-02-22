extends Control
@export var transition : Node
@export var animation : Node

@export var duration : float = 1.0

func _ready() -> void:
	Utils.set_cursor("res://assets/cursor.png")
	animation.play("transition_out")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://node/table.tscn")
