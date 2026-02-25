extends SubViewportContainer

@export var p: Control

var mouse_animate = true #click, hover, dishover
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	SignalManager.upgrade_clicked.connect(cancel_animations)

func cancel_animations(i:=1):
	mouse_animate = false

func animate_up_upgrade(r):
	if mouse_animate == true:
		var tween = get_tree().create_tween()
		tween.tween_property(r, "scale", Vector2(1.1, 1.1), 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.play()
		SignalManager.upgrade_hovered.emit(p.upgrade_name, p.upgrade_desc)
		
func animate_down_upgrade(r):
	if mouse_animate == true:
		var tween = get_tree().create_tween()
		tween.tween_property(r, "scale", Vector2(1.0, 1.0), 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.play()
		SignalManager.upgrade_dishovered.emit()
func animate_click_upgrade(r):
	if mouse_animate :
		var tween_rot = get_tree().create_tween()
		var tween_scale = get_tree().create_tween()
		
		tween_scale.tween_property(r, "scale", Vector2(0.8, 0.8), 0.08).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween_scale.tween_property(r, "scale", Vector2(1.1, 1.1), 0.4).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
		var original_rotation = 0
		var shake_times = 1
		var shake_duration = 0.3
		
		tween_scale.play()
		for i in range(shake_times):
			var rot_offset = 1.0
			tween_rot.tween_property(r, "rotation_degrees", original_rotation + rot_offset, shake_duration).set_trans(Tween.TRANS_SINE)
		
		# Retorna à rotação original
			tween_rot.tween_property(r, "rotation_degrees", original_rotation - rot_offset, shake_duration).set_trans(Tween.TRANS_SINE)
			tween_rot.tween_property(r, "rotation_degrees", original_rotation, shake_duration).set_trans(Tween.TRANS_SINE)
			tween_rot.play()

###			Hover Tween Signals

func _on_hover() -> void:
	animate_up_upgrade(self)

###			Dishover Tween Signals
func _on_dishover() -> void:
	animate_down_upgrade(self)

###			Click Tween Signals 
func _on_click(event: InputEvent) -> void:
	if mouse_animate == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				animate_click_upgrade(self)
				SignalManager.upgrade_clicked.emit(p.upgrade_index)

			
			
