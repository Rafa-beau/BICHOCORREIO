extends Node2D

@onready var card = ("res://node/card")
@onready var player = get_node("Life/Player")

var card_scene := preload("res://node/card.tscn")
var parent = self
var vel = 15
var current_card
var pull = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	call_card()
	SignalManager.accept.connect(accept)
	SignalManager.reject.connect(reject)

func call_card():
	var des_summon = Vector2(98, 85)
	
	current_card = Utils.spawn_card(card_scene, Vector2(198, -2000), parent)
	
	CardManager.current_card = current_card
	
	var tween = create_tween()
	tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	SignalManager.call_card.emit()

func reject():
	player.take_damage(1)
	current_card.queue_free()
	call_card()
	print("rejeitou")

func accept():
	SignalManager.coinup.emit()
	current_card.queue_free()
	call_card()
	print("ceitou")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name.begins_with("Card"):
		current_card = area
		

func _on_accept_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var des_accept = Vector2(1500, 85)
	if pull == true and current_card:
		if event.is_action_released("click"):
			pull = false
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_accept, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
			await get_tree().create_timer(0.60).timeout
			if current_card.water == true:
				if current_card.water_stamp == true:
					accept()
				else:
					reject()
			if current_card.water == true:
				if current_card.water_stamp == false:
					accept()
				else:
					reject()

func _on_accept_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
		else:
			return

func _on_confiscate_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var des_confis = Vector2(198, 1000)
	if pull == true and current_card :
		if event.is_action_released("click"):
			pull = false
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_confis, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
			await get_tree().create_timer(0.60).timeout
			if current_card.water == false and current_card.water_stamp == false:
				print("accept")
				SignalManager.accept.emit()
			else:
				print("reject")
				reject()
			if current_card.water == true and current_card.water_stamp == true:
				print("accept")
				SignalManager.accept.emit()
			else:
				print("reject")
				SignalManager.reject.emit()

func _on_confiscate_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
		else:
			return
