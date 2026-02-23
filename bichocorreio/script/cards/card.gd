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


@onready var stamp: Sprite2D = $Stamp
@onready var card_frame: Sprite2D = $Card


func CardType(probability: float):
	var random_value = rng.randf()
	return random_value < probability

func _ready():
	stamp.hide()
	card_frame.frame = 0
	var blue_chance = 1
	
	if CardType(blue_chance):
		card_frame.frame = 1
		water = true
	else:
		card_frame.frame = 0
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
			
			stamp.modulate.a = StampManager.get_next_opacity()
			stamp.texture = load(stamp_path)
			
			
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
			if not stamped:
				if event.button_index == MOUSE_BUTTON_LEFT:
					stamp.show()
					stamp.frame = 0
					await get_tree().create_timer(0.10).timeout
					approved = true
					water_stamp = false
					stamped = true
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					stamp.show()
					stamp.frame = 2
					await get_tree().create_timer(0.10).timeout
					disapproved = true
					water_stamp = false
					stamped = true
				return
			if StampManager.current_color == Color.BLUE:
				print ("Bad Stamb")
				if event.button_index == MOUSE_BUTTON_LEFT:
					print ("Bad Stamb")
					stamp.show()
					stamp.frame = 1
					await get_tree().create_timer(0.10).timeout
					approved = true
					water_stamp = true
					stamped = true
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					print ("Bad Stamb")
					stamp.show()
					stamp.frame = 3
					disapproved = true
					water_stamp = true
					stamped = true
				return
