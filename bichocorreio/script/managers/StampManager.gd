extends Node

var opacities = [1.0, 0.7, 0.4]
var current_color = Color.WHITE
var opacity_index = 0 # contralador da opacidade
var chance = 0.45

func _ready() -> void:
	SignalManager.stamp_pick.connect(set_color)

func set_chance(chance_float: float):
	chance = chance_float	

# seta nova cor e reseta index
func set_color(color: Color):
	current_color = color
	opacity_index = 0
	
func can_stamp() -> bool:
	return opacity_index < opacities.size()

func get_next_opacity() -> float:
	
	if not can_stamp():
		return -1.0
	if randf() > chance:
		return opacities[opacity_index]
	var value = opacities[opacity_index]
	opacity_index += 1
	return value
