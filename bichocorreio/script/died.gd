extends Control

@onready var stats1 = $stats1

func _ready():
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	updt_text()

func updt_text():
	var text: String
	text += "[wave][color=green]Acertos[/color][/wave] " + str(PlayerManager.accept_q) + "\n"
	text += "[shake][color=red]Erros:[/color][/shake] " + str(PlayerManager.reject_q) + "\n"
	text += "[wave freq=2][color=yellow]Moedas:[/color][/wave] " + str(PlayerManager.total_coins) + "\n"
	text += "Tempo: " + PlayerManager.get_time_played()
	stats1.text = text

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://node/menu/menu.tscn")

func _on_menu_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			TransitionScene.play_in()
			await Utils.timer(1.6)
			get_tree().change_scene_to_file("res://node/menu/menu.tscn")


func _on_menu_button_mouse_entered() -> void:
	
	$Hover.play()
	$MenuButton/RichTextLabel.add_theme_color_override("default_color", Color("#ffffff"))
	pass # Replace with function body.


func _on_menu_button_mouse_exited() -> void:
	$MenuButton/RichTextLabel.add_theme_color_override("default_color", Color("#390005"))
