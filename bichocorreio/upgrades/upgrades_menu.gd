extends Control
@export var animation_fly: AnimationPlayer
@export var animation_selected: AnimationPlayer = null
@export var nodes: Array[Control]
func _ready() -> void:
	SignalManager.upgrade_purchased.connect(animation_fly.pause)
	TransitionScene.play_in()
