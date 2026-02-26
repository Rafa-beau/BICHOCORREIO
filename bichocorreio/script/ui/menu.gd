extends Control
@export var buttons: Array[Control]
@export var buttons_text: Array[RichTextLabel]
@onready var background: Parallax2D =$Parallax2D
@onready var original_positions: Array[Vector2] = [Vector2(), Vector2(0, 192), Vector2(0, 384)]
var viewport_size
var can_click: bool = false
var i: int = 0
func _process(delta: float) -> void:
	parallax(get_viewport().get_mouse_position())
	if can_click == false and i == 0:
		get_viewport().warp_mouse(Vector2(568.2, 110))
		
	

func _ready() -> void:
	print(original_positions)
	Utils.set_cursor("res://assets/cursor.png")
	viewport_size = get_viewport().get_visible_rect().size
	Utils.disable_cursor()
	await Utils.timer(4.8)
	TransitionScene.play_out()
	await Utils.timer(0.4)
	Utils.enable_cursor()
	await Utils.timer(0.2)
	can_click = true
	i = 1
	
func _on_button_pressed() -> void:
	if can_click:
		TransitionScene.play_in()
		await Utils.timer(1.7)
		get_tree().change_scene_to_file("res://node/table.tscn")

func parallax(mouse):
	var relative = (mouse - (viewport_size/2)) / (viewport_size/2)
	var multiplier = 2
		
	background.scroll_offset =multiplier * relative
		
func move_up_button(b: int, move: Vector2):
	if can_click:
		var tween = create_tween()
		tween.tween_property(buttons[b], "position", buttons[b].position + move, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
func move_down_button(b: int, move: Vector2):
	if can_click:
		var tween = create_tween()
		tween.tween_property(buttons[b], "position", original_positions[b], 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		
func click_button(r):
	var tween_rot = get_tree().create_tween()
	var tween_scale = get_tree().create_tween()
	
	tween_scale.tween_property(buttons[r], "scale", Vector2(1.1, 1.1), 0.08).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween_scale.tween_property(buttons[r], "scale", Vector2(1.0, 1.0), 0.4).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
	var original_rotation = 0
	var shake_times = 1
	var shake_duration = 0.3
	
	tween_scale.play()
	for i in range(shake_times):
		var rot_offset = 1.0
		tween_rot.tween_property(buttons[r], "rotation_degrees", original_rotation + rot_offset, shake_duration).set_trans(Tween.TRANS_SINE)
		
		# Retorna à rotação original
		tween_rot.tween_property(buttons[r], "rotation_degrees", original_rotation - rot_offset, shake_duration).set_trans(Tween.TRANS_SINE)
		tween_rot.tween_property(buttons[r], "rotation_degrees", original_rotation, shake_duration).set_trans(Tween.TRANS_SINE)
		tween_rot.play()
func _on_mouse_entered(extra_arg_0: int) -> void:
	print("oi")
	move_up_button(extra_arg_0, Vector2(0, -10))
	buttons_text[extra_arg_0].add_theme_color_override("default_color", Color("#fff"))
	pass # Replace with function body.


func _on_mouse_exited(extra_arg_0: int) -> void:
	move_down_button(extra_arg_0, Vector2(0, 10))
	buttons_text[extra_arg_0].add_theme_color_override("default_color", Color("#390005"))
	
	pass # Replace with function body.


func _on_play_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_LEFT and event.pressed and can_click:
			can_click = false
			click_button(0)
			TransitionScene.play_in()
			await Utils.timer(1.7)
			get_tree().change_scene_to_file("res://node/table.tscn")
	pass # Replace with function body.
