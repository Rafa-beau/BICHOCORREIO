extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var inicio: RichTextLabel = $Inicio

func _ready() -> void:
	Utils.disable_cursor()
	Utils.load_options()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://node/menu/menu.tscn")


func _on_inicio_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			animation_player.stop()
			inicio.queue_free()
			await Utils.timer(0.2)
			get_tree().change_scene_to_file("res://node/menu/menu.tscn")
