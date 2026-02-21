extends Area2D

var dragging = false
var stamped = false
var remove = false
var approved = false
var disapproved = false
var start_pos: Vector2
var min_drag = 10.0
var offset

var original_position: Vector2

@onready var sprite: Sprite2D = $Sprite2D

@export var cur_color: CardColor

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
	sprite.texture = null

# arrastar

	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true

# Saber se mouse ta segurando

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false
			

func _process(delta):
		
	# input pra teste
	if remove == true:
		if Input.is_action_pressed("sumir-carta"):
			remove_card()


# carimbador thur
func stamb_receive(stamp_path: String):
	if not stamped:
		
		sprite.texture = load(stamp_path)
		
		SignalManager.stamp.emit()
		
		Utils.enable_cursor()
		
		stamped = true



### logica de passar ou consfiscar ###

# fazer a carta sumir
func remove_card():
	queue_free()

func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			stamb_receive("res://assets/carimbos/carimboAPROVADO.png")
			approved = true
			await get_tree().create_timer(0.10).timeout
		if event.button_index == MOUSE_BUTTON_RIGHT:
			stamb_receive("res://assets/carimbos/carimboREPROVADO.png")
			disapproved = true
