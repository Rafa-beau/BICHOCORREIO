extends Sprite2D

var can_follow = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 10
	visible = true
	

	SignalManager.stamp.connect(stamp)
	SignalManager.bad_stamp.connect(stamp)
	SignalManager.stamp_pick.connect(stamp)
# Called every frame. 'delta' is the elapsed time since the previous frame.
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

func stamp(f = ""):
	texture = load("res://assets/formiga_hit.png")
	await get_tree().create_timer(0.13).timeout
	texture = load("res://assets/formiga.png")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				texture = load("res://assets/formiga_grab.png")
			else:
				await get_tree().create_timer(0.13).timeout
				texture = load("res://assets/formiga.png")
