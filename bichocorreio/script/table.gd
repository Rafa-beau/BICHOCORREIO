extends Node2D

@onready var card = ("res://node/card")
var card_scene := preload("res://node/card.tscn")
var parent = self
var vel = 15
var current_card = null
var pull

func _ready() -> void:
	current_card = Utils.spawn_card(card_scene, Vector2(198, 85), parent)

func snap_card() -> void:
	card.snap_to_table(self)
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Card"):
		current_card = area

func _on_accept_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var des_accept = Vector2(1500, 85)
	if pull == true:
		if event.is_action_released("click"):
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_accept, 0.25)

func _on_accept_mouse_entered() -> void:
	if current_card.dragging == true:
		pull = true

func _on_confiscate_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var des_confisc = Vector2(198, 1000)
	if pull == true:
		if event.is_action_released("click"):
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_confisc, 0.45)

func _on_confiscate_mouse_entered() -> void:
	if current_card.dragging == true:
		pull = true
