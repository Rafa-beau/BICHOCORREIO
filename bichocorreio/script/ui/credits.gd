extends Node2D

var x = 375
var y = 700

@export var credits: Node

func _ready() -> void:
	TransitionScene.play_out()
	await Utils.timer(1.7)
	var des_summon = Vector2(0, -3500)
	var tween = create_tween()
	tween.tween_property(credits, "position", des_summon, 25)
	await Utils.timer(25)
	get_tree().change_scene_to_file("res://node/menu/menu.tscn")
	
