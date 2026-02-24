extends Area2D


@onready var paw = $Sprite2D
@onready var stamp: Sprite2D = $Stamp

var current_paw

var water: bool
var stamped: bool
var approved: bool
var disapproved: bool
var water_stamp: bool
var AntEat: bool

var paws_water = ["Frog1", "Frog2"]
var paws = ["Cat", "AntEater"]

func _ready() -> void:
	stamp.hide()
	SignalManager.is_water.connect(change_sprite) 

func change_sprite(isw: bool):
	if isw == true:
		var choice = paws_water.pick_random()
		print (choice)
		match choice:
			"Frog1":
				paw.frame = 1
			"Frog2":
				paw.frame = 2
	if isw == false:
		var choice = paws.pick_random()
		print (choice)
		match choice:
			"Cat":
				paw.frame = 0
			"AntEater":
				paw.frame = 3
				SignalManager.AntEat.emit()

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
					stamp.show()
					stamp.frame = 1
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
