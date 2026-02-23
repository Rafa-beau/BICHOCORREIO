extends Area2D

var dragging = false
var stamped = false
var approved = false
var disapproved = false
var water = false
var water_stamp = false
var start_pos: Vector2
var offset
var rng = RandomNumberGenerator.new()

var original_position: Vector2

@onready var stamp_sprite: Sprite2D = $Sprite2D


func CardType(probability: float):
	var random_value = rng.randf()
	return random_value < probability

func _ready():
	$Card.frame = 0
	var blue_chance = 0.2
	
	if CardType(blue_chance):
		$Card.frame = 1
		water = true
	else:
		$Card.frame = 0
		water = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false

func stamp_receive(stamp_path = null):
	if stamp_path:
		if not StampManager.can_stamp():
			SignalManager.bad_stamp.emit()
			print("Bad Stamb")
			return
		if not stamped:
			
			stamp_sprite.modulate.a = StampManager.get_next_opacity()
			stamp_sprite.texture = load(stamp_path)
			
			
			SignalManager.stamp.emit()
			
			stamped = true
			return
			
		SignalManager.bad_stamp.emit()
		print("Bad Stamb")
		return
	SignalManager.bad_stamp.emit()
	print("Bad Stamb")

func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if StampManager.current_color == Color.GREEN:
			if event.button_index == MOUSE_BUTTON_LEFT:
				stamp_receive("res://assets/carimbos/carimboAPROVADO.png")
				await get_tree().create_timer(0.10).timeout
				approved = true
				water_stamp = false
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				stamp_receive("res://assets/carimbos/carimboREPROVADO.png")
				disapproved = true
				water_stamp = false
			return
		if StampManager.current_color == Color.BLUE:
			if event.button_index == MOUSE_BUTTON_LEFT:
				stamp_receive("res://assets/carimbos/carimboAPROVADOagua.png")
				await get_tree().create_timer(0.10).timeout
				approved = true
				water_stamp = true
			elif event.button_index == MOUSE_BUTTON_RIGHT:
				stamp_receive("res://assets/carimbos/carimboREPROVADOagua.png")
				disapproved = true
				water_stamp = true
			return
