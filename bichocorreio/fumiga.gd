extends Sprite2D

var can_follow = true

var current_color: String
func _ready() -> void:
	z_index = 10
	visible = false

	
	
	SignalManager.call_card.connect(enable_stamp)
	SignalManager.call_card.connect(disable_cursor)
	SignalManager.stamp.connect(disable_stamp)
	
	
func _process(delta: float) -> void:
	if can_follow == true:
		global_position = get_global_mouse_position()



func disable_cursor():
	await get_tree().create_timer(0.1).timeout
	Utils.disable_cursor()

func enable_stamp():
	can_follow = true
	await get_tree().create_timer(0.1).timeout
	modulate.a = 1
	visible = true
	
func disable_stamp():
	can_follow = false
	create_tween().tween_property(self, "modulate:a", 0.0, 0.3)
	await get_tree().create_timer(0.30).timeout
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				texture = load("res://assets/formiga_hit.png")
			else:
				await get_tree().create_timer(0.13).timeout
				texture = load("res://assets/formiga.png")
