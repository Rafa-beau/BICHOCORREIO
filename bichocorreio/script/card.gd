extends Area2D

var dragging = false
var stamped = false
var offset
var type = "card"

@export var color: CardColor

enum CardColor {
	RED,
	YELLOW,
	ORANGE,
	GREEN,
	BLUE,
	PURPLE,
	PINK,
	BROWN,
	BLACK,
	WHITE
}

const Color_Values = {
	CardColor.RED: Color.RED,
	CardColor.YELLOW: Color.YELLOW,
	CardColor.ORANGE: Color.ORANGE,
	CardColor.GREEN: Color.GREEN,
	CardColor.BLUE: Color.BLUE,
	CardColor.PURPLE: Color.PURPLE,
	CardColor.PINK: Color.DEEP_PINK,
	CardColor.BROWN: Color.SADDLE_BROWN,
	CardColor.BLACK: Color.BLACK,
	CardColor.WHITE: Color.WHITE
	}

# Cor aleatoria

func _ready():
	color = CardColor.values().pick_random()
	$ColorRect.modulate = Color_Values[color]

# nome da cor

func assing_color():
	var match_color = type + CardColor


# arrastar

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		dragging = event.pressed
		if event.pressed:
			offset = global_position - get_global_mouse_position()

# Saber se mouse ta segurando

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false

func _process(delta):
	if dragging == true:
		global_position = get_global_mouse_position() + offset
		var target_pos = get_global_mouse_position() + offset
		global_position = target_pos
 
# arrastar melhor, gaveta

func start_drag():
	dragging = true
	offset = Vector2(-150, -40)
