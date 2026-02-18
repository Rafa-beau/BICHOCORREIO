extends Area2D

var dragging = false
var stamped = false
var stuck = false
var offset

@export var cur_color: CardColor
@export var stamp_mark: PackedScene

enum CardColor {
	RED,
	ORANGE,
	YELLOW,
	GREEN,
	BLUE,
	PURPLE,
	PINK,
	BROWN,
	WHITE,
	BLACK
}

const Color_Values = {
	CardColor.RED: Color.RED,
	CardColor.ORANGE: Color.ORANGE,
	CardColor.YELLOW: Color.YELLOW,
	CardColor.GREEN: Color.GREEN,
	CardColor.BLUE: Color.BLUE,
	CardColor.PURPLE: Color.PURPLE,
	CardColor.PINK: Color.DEEP_PINK,
	CardColor.BROWN: Color.SADDLE_BROWN,
	CardColor.WHITE: Color.WHITE,
	CardColor.BLACK: Color.BLACK
	}

# Cor aleatoria

func _ready():
	cur_color = CardColor.values().pick_random()
	$ColorRect.modulate = Color_Values[cur_color]

# arrastar

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and not stuck and MOUSE_BUTTON_LEFT:
		dragging = event.pressed
		if event.pressed:
			offset = global_position - get_global_mouse_position()

# Saber se mouse ta segurando

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false
			if not stamped:
				stuck = true
			else:
				stuck = false

func _process(delta):
	if dragging == true:
		global_position = get_global_mouse_position() + offset
		var target_pos = get_global_mouse_position() + offset
		global_position = target_pos
 
# arrastar melhor, gaveta

func start_drag():
	dragging = true
	offset = Vector2(-150, -40)

# sera?

# carimbador maluco

func receive_stamp(stamp_color: Color, stamp_index: int) -> void:
	if not stamped:
		if Color_Values[cur_color] == stamp_color:
			var mark = stamp_mark.instantiate()
			mark.get_node("Sprite2D").frame = stamp_index
			add_child(mark)
			stamped = true
			stuck = false
		else:
			print("No, bad stamp")
