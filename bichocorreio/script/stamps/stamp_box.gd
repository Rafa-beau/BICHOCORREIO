extends Node2D

@export var color: StampColor
var on_drag = false

func _ready():
	
	var all_children = get_children()
	var slots = []
	for child in all_children:
		if child.name.begins_with("stampslot"): #Filtrinho hype
			slots.append(child)

	var color_palette_array = Color_Values.values()

	for i in range(slots.size()):
		var current_stampslot = slots[i]
		var stamp_color = color_palette_array[i]
		current_stampslot.apply_color(stamp_color, i)

enum StampColor {
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	BLUE,
	PURPLE,
	PINK,
	BROWN,
	WHITE
}

const Color_Values = {
	StampColor.RED: Color.RED,
	StampColor.ORANGE: Color.ORANGE,
	StampColor.YELLOW: Color.YELLOW,
	StampColor.GREEN: Color.GREEN,
	StampColor.BLUE: Color.BLUE,
	StampColor.PURPLE: Color.PURPLE,
	StampColor.PINK: Color.DEEP_PINK,
	StampColor.BROWN: Color.SADDLE_BROWN,
	StampColor.WHITE: Color.WHITE
	}
