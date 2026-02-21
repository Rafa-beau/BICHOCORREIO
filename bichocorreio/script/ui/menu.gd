extends Control

func _ready() -> void:
	Utils.set_cursor("res://assets/cursor.png")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://node/table.tscn")
