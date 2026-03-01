extends Control

@onready var stats1 = $stats1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	updt_text()

func updt_text():
	var text = "[center]"
	text += "Acertos: " + str(PlayerManager.accept_q) + "\n"
	text += "Erros: " + str(PlayerManager.reject_q) + "\n"
	text += "Moedas totais: " + str(PlayerManager.total_coins) + "\n"
	text += "Tempo de jogo: " + PlayerManager.get_time_played()
	text += "[/center]"
	stats1.text = text

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://node/menu/menu.tscn")

func _on_menu_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			get_tree().change_scene_to_file("res://node/menu/menu.tscn")
