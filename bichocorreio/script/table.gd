extends Node2D

@onready var card = ("res://node/card")
var card_scene := preload("res://node/card.tscn")
var parent = self

var current_card = null

func _ready() -> void:
	Utils.spawn_card(card_scene, Vector2(198, 85), parent)

func snap_card() -> void:
	card.snap_to_table(self)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Card"):
		current_card = area
		
