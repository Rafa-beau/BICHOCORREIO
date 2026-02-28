extends Control
@export var buttons: Array[Control]
@export var buttons_text: Array[RichTextLabel]
@onready var background: Parallax2D =$Parallax2D
var original_positions: Array[Vector2] = []
var viewport_size
var can_click: bool = false
var i: int = 0
func _process(delta: float) -> void:
	parallax(get_viewport().get_mouse_position())
	if can_click == false and i == 0:
		get_viewport().warp_mouse(Vector2(568.2, 110))
		
func _ready() -> void:
	viewport_size = get_viewport().get_visible_rect().size
	await get_tree().process_frame
	for b in buttons:
		original_positions.append(b.position)
	print(original_positions)
	Utils.set_cursor("res://assets/cursor.png")
	TransitionScene.play_out()
	await Utils.timer(0.4)
	Utils.enable_cursor()
	$Background.playing = true
	await Utils.timer(0.2)
	can_click = true
	i = 1
	


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
	$Click_play.play()
	
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
func _on_mouse_entered(extra_arg_0 : int) -> void:
	$Hover.play()
	if extra_arg_0 != -1:
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
			var tween = create_tween()
			tween.tween_property($Background, "volume_db", -45.0, 1.0)
			await Utils.timer(1.7)
			get_tree().change_scene_to_file("res://node/table.tscn")
	pass # Replace with function body.


func _on_credits_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MASK_LEFT and event.pressed and can_click:
			can_click = false
			click_button(3)
			TransitionScene.play_in()
			var tween = create_tween()
			tween.tween_property($Background, "volume_db", -45.0, 1.0)
			await Utils.timer(1.7)
			get_tree().change_scene_to_file("res://node/menu/credits.tscn")
	pass # Replace with function body.


func _on_click(event: InputEvent, extra_arg_0:= -1) -> void:
	if event is InputEventMouseButton and can_click:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$Click.play()
			if extra_arg_0 == 0:
				$Options.visible = true
			if extra_arg_0 == 1:
				$CanvasLayer.visible = true
			if extra_arg_0 == 2:
				$CanvasLayer.visible = false
	
			if extra_arg_0 == 3:
				Utils.disable_cursor()
				TransitionScene.play_in()
				await Utils.timer(2)
				get_tree().quit()
