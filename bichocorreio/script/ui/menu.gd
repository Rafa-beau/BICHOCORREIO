extends Control

func _ready() -> void:
	Utils.set_cursor("res://assets/cursor.png")
	TransitionScene.play_out()
func _on_button_pressed() -> void:
	TransitionScene.play_in()
	await Utils.timer(1.7)
	get_tree().change_scene_to_file("res://node/table.tscn")
