extends Control

@onready var text = $cur_combo
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var combo_count: int = 0
var combo_timer: float = 0.0
const combo_time: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 1000
	hide()
	pass # Replace with function body.

func _process(delta: float):
	if combo_timer > 0:
		combo_timer -= delta
		if combo_timer <= 0:
			reset_combo()

func show_combo():
	show()
	if combo_count > 1:
		return
	animation_player.play("oi")
	

func add_combo():
	combo_count += 1
	combo_timer = combo_time
	show_combo()
	ui_update()

func reset_combo():
	animation_player.play("tchau")
	await Utils.timer(0.5)
	combo_count = 0
	hide()

func ui_update():
	text.text = "x[shake]" + str(combo_count)
