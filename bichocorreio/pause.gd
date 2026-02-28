extends Control

var can_esc: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused
		$Control2.visible = false
		$Control.visible = false
		Utils.enable_cursor()
		if visible == false:
			SignalManager.dispause.emit()
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_options_pressed() -> void:
	$Control/Click.play()
	$Control2.visible = true
	

func _on_resume_pressed() -> void:
	$Control/Click.play()
	SignalManager.dispause.emit()
	visible = false
	get_tree().paused = false



func _on_leave_pressed() -> void:
	$Control/Click.play()
	$Control.visible = true
	
	
	

func _on_pressed(extra_arg_0: int) -> void:
	$Control/Click.play()
	match extra_arg_0:
		0:
			$Control.visible = false
			visible = false
			get_tree().paused = false
		1:
			if TransitionScene.a == false:
				TransitionScene.play_in()
				await Utils.timer(3)
			hide()
			get_tree().paused = false
			get_tree().change_scene_to_file("res://node/menu/menu.tscn")


func _on_mouse_entered() -> void:
	$Control/Hover.play()
