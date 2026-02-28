extends Area2D


@onready var paw: Sprite2D = $Sprite2D
@onready var stamp: Sprite2D = $Stamp


var paw_stamped: bool
var paw_approved: bool
var paw_disapproved: bool
var paw_water_stamp: bool

var Crocs: bool
var AntEat: bool


var cur_frame

@onready var paws_water: Sprite2D = $WaterPaws
@onready var paws: Sprite2D = $Paws

func _ready() -> void:
	self.z_index = 100
	stamp.hide()
	paws_water.hide()
	paws.hide()
	
	if get_parent() and "current_card" in get_parent() and get_parent().current_card:
		change_sprite(get_parent().current_card.water)
		
	SignalManager.is_water.connect(change_sprite) 

func change_sprite(isw: bool):
	if isw == false:
		paws_water.hide()
		paws.show()
		cur_frame = randi_range(0, 4)
		paws.frame = cur_frame
		if cur_frame == 4:
			AntEat = true

	if isw == true:
		paws_water.show()
		paws.hide()
		cur_frame = randi_range(0, 4)
		paws_water.frame = cur_frame
		if cur_frame == 4:
			Crocs = true
			SignalManager.CrocsHead.emit()

func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not paw_stamped and StampManager.can_stamp():
			if AntEat == true or Crocs == true:
				if StampManager.current_color == Color.GREEN:
					if event.button_index == MOUSE_BUTTON_LEFT:
						stamp.modulate.a = StampManager.get_next_opacity()
						stamp.show()
						stamp.frame = 0
						paw_approved = true
						paw_stamped = true
						SignalManager.stamp.emit()
					elif event.button_index == MOUSE_BUTTON_RIGHT:
						stamp.modulate.a = StampManager.get_next_opacity()
						stamp.show()
						stamp.frame = 2
						paw_disapproved = true
						paw_stamped = true
						SignalManager.stamp.emit()
					return
				if StampManager.current_color == Color.BLUE:
					if event.button_index == MOUSE_BUTTON_LEFT:
						stamp.modulate.a = StampManager.get_next_opacity()
						stamp.show()
						stamp.frame = 1
						paw_approved = true
						paw_water_stamp = true
						paw_stamped = true
						SignalManager.stamp.emit()
					elif event.button_index == MOUSE_BUTTON_RIGHT:
						stamp.modulate.a = StampManager.get_next_opacity()
						stamp.show()
						stamp.frame = 3
						paw_disapproved = true
						paw_water_stamp = true
						paw_stamped = true
						SignalManager.stamp.emit()
			else:
				
				SignalManager.bad_stamp.emit()
