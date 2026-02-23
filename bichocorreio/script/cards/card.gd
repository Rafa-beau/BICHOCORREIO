extends Area2D

var dragging: bool
var stamped: bool
var approved: bool
var disapproved: bool
var water: bool
var water_stamp: bool
var coins: int = 1
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
	var blue_chance = 0.2
	
	if CardType(blue_chance):
		card_frame.frame = 1
		water = true
		coins = 2
	else:
		card_frame.frame = 0
		water = false
		coins = 1

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false
	
	
func stamp_wears():
	stamp.modulate.a = StampManager.get_next_opacity()
	return
	
func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not stamped and StampManager.can_stamp():
			if StampManager.current_color == Color.GREEN:
				if event.button_index == MOUSE_BUTTON_LEFT:
					stamp.modulate.a = StampManager.get_next_opacity()
					stamp.show()
					stamp.frame = 0
					approved = true
					stamped = true
					SignalManager.stamp.emit()
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					stamp.modulate.a = StampManager.get_next_opacity()
					stamp.show()
					stamp.frame = 2
					disapproved = true
					stamped = true
					SignalManager.stamp.emit()
				return
			if StampManager.current_color == Color.BLUE:
				if event.button_index == MOUSE_BUTTON_LEFT:
					stamp.modulate.a = StampManager.get_next_opacity()
					print ("Bad Stamb")
					stamp.show()
					stamp.frame = 1
					await get_tree().create_timer(0.10).timeout
					approved = true
					water_stamp = true
					stamped = true
					SignalManager.stamp.emit()
				elif event.button_index == MOUSE_BUTTON_RIGHT:
					stamp.modulate.a = StampManager.get_next_opacity()
					stamp.show()
					stamp.frame = 3
					disapproved = true
					water_stamp = true
					stamped = true
					SignalManager.stamp.emit()
		else:
			print ("Bad Stamb")
			
			SignalManager.bad_stamp.emit()
