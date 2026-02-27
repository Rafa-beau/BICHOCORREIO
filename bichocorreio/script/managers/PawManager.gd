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
var Crocs: bool
var cur_frame

@onready var paws_water: Sprite2D = $WaterPaws
@onready var paws: Sprite2D = $Paws

func _ready() -> void:
	self.z_index = 100
	stamp.hide()
	paws_water.hide()
	paws.hide()
	
	# Check parent to see if there's already a card spawned
	if get_parent() and "current_card" in get_parent() and get_parent().current_card:
		change_sprite(get_parent().current_card.water)
		
	SignalManager.is_water.connect(change_sprite) 

func change_sprite(isw: bool):
	if isw == false:
		paws_water.hide()
		paws.show()
		cur_frame = randi_range(0, 4)
		paws.frame = cur_frame
		if cur_frame == 5:
			AntEat = true
			SignalManager.AntEat.emit()

	if isw == true:
		paws_water.show()
		paws.hide()
		cur_frame = randi_range(0, 4)
		paws_water.frame = cur_frame
		if cur_frame == 0:
			Crocs = true
			SignalManager.CrocsHead.emit()

func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not stamped and StampManager.can_stamp():
			if AntEat == true or Crocs == true:
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
				
				SignalManager.bad_stamp.emit()
