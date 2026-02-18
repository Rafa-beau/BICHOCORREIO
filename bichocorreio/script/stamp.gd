extends Area2D

@export var card: PackedScene

@onready var stamp_slot = get_parent()
@onready var color_rect = $ColorRect
var original_z_index: int = 0

var dragging = false
var offset
var ret_color
var ret_color_index: int 

func _ready():
	if stamp_slot and "glob_color" in stamp_slot:
		ret_color = stamp_slot.glob_color
		ret_color_index = stamp_slot.glob_color_index
		apply_color(ret_color)

func apply_color(new_color: Color):
	if color_rect:
		color_rect.color = new_color

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			if not dragging:
				original_z_index = z_index
				z_index = 1000
		dragging = event.pressed
		if event.pressed:
			offset = global_position - get_global_mouse_position()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and dragging:
			var areas = get_overlapping_areas()
			for area in areas:
				if area.has_method("receive_stamp"):
					area.receive_stamp(ret_color, ret_color_index)

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
			z_index = original_z_index
			dragging = false

func _process(delta):
	if dragging == true:
		var target_pos = get_global_mouse_position() + offset
		global_position = target_pos
