extends Node2D

@onready var card = ("res://node/card")
var current_card = null

func snap_card(card: Area2D) -> void:
	card.snap_to_table(self)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Card"):
		current_card = area
		
