extends Node2D 

@export var stamp: PackedScene
@onready var stamp_box = get_parent()
@onready var color_rect = $ColorRect
var glob_color: Color
var stamp_created = false

func apply_color(new_color: Color):

	if color_rect:
		color_rect.color = new_color
		glob_color = new_color

	if stamp and not stamp_created:
		stamp_created = true
		var stamp_instance = stamp.instantiate()
		add_child(stamp_instance)
