extends Node

var max_life = 3
var current_life = 3
var moeda = 0

signal life_changed(current_life)
signal died

# tomar dano
func take_damage(amount):
	current_life -= amount
	current_life = max(current_life, 0)
	
	emit_signal("life_changed", current_life)
	
	if current_life == 0:
		die()
		
#morrer
func die():
	emit_signal("died")

func _input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		take_damage(1)
