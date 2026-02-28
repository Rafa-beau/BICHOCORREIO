extends Control

@onready var text = $cur_combo

var combo_count: int = 0
var combo_timer: float = 0.0
const combo_time: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1000
	self.hide()
	pass # Replace with function body.

func _process(delta: float):
	if combo_timer > 0:
		combo_timer -= delta
		if combo_timer <= 0:
			reset_combo()

func add_combo():
	combo_count += 1
	combo_timer = combo_time
	self.show()
	ui_update()

func reset_combo():
	combo_count = 0
	self.hide()

func ui_update():
	text.text = "x" + str(combo_count)
