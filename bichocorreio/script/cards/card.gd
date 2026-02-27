extends Area2D

var dragging: bool
var stamped: bool
var approved: bool
var disapproved: bool
var ball: bool
var water: bool
var water_stamp: bool
var dirty: bool
var coins: int = 1
var start_pos: Vector2
var offset
var rng = RandomNumberGenerator.new()
var is_anteat: bool
var original_position: Vector2
var coin_scene
var dirt_scene
var min_c = 2
var max_c = 6
var bribe: bool
var max_x = 300
var max_y = 400
var pos_x
var pos_y
var cur_c

var parent = self
@onready var dirt: Node2D = $Dirt
@onready var stamp: Sprite2D = $Stamp
@onready var card_frame: Sprite2D = $Card
@onready var paw: Area2D = $Paws
@onready var ball_text = $Ball

@export var coin: PackedScene
@export var dirt_sc: PackedScene


func CardType(probability: float):
	var random_value = rng.randf()
	return random_value < probability

func _ready():
	cur_c = randi_range(min_c, max_c)

	SignalManager.AntEat.connect(is_ant)
	dirt.hide()
	stamp.hide()
	ball_text.hide()

	card_frame.frame = 0
	var blue_chance = 0.2
	var dirty_chance = 0.2
	var stamp_chance = 0.1
	var bribe_chance = 0.05
	var balls_chance = 0.05


	if CardType(balls_chance):
		blue_chance = 0
		dirty_chance = 0
		stamp_chance = 0
		bribe_chance = 0
		ball = true
		card_frame.hide()
		ball_text.show()
	else:
		ball = false
		card_frame.show()
		ball_text.hide()

	if CardType(bribe_chance):
		bribe = true
		for i in range(cur_c):
			create_rand()
			print("teste")

	if CardType(dirty_chance):
		dirty = true
		for i in range(cur_c):
			create_rand()
			print("teste")

	if CardType(blue_chance):
		card_frame.frame = 1
		water = true
		coins = 2
		SignalManager.is_water.emit(true)
	else:
		card_frame.frame = 0
		water = false
		coins = 1
		SignalManager.is_water.emit(false)

	if CardType(stamp_chance):
		if water == false:
			stamp.frame = 0
			stamp.show()
		if water == true:
			stamp.frame = 1
			stamp.show()

func create_rand():
	pos_x = randi_range(0, max_x)
	pos_y = randi_range(0, max_y)
	
	if bribe == true:
		coin_scene = Utils.spawn_scene(coin, parent, Vector2(pos_x, pos_y))
	if dirty == true:
		dirt_scene = Utils.spawn_scene(dirt_sc, parent, Vector2(pos_x, pos_y))

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true

func _unhandled_input(event):
	if dragging:
		if event is InputEventMouseButton and not event.pressed:
			dragging = false

func is_ant():
	is_anteat = true

func stamp_wears():
	stamp.modulate.a = StampManager.get_next_opacity()
	return

func _on_stamp_place_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not ball:
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
				
				SignalManager.bad_stamp.emit()
