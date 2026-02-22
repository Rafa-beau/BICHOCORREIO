extends Control
@export var animation_fly: AnimationPlayer
@export var animation_selected: AnimationPlayer = null
@export var nodes: Array[Control]
func _ready() -> void:
	SignalManager.upgrade_purchased.connect(animation_fly.pause)
	upgrade_cart_clicked("")
	pass

func upgrade_cart_clicked(upgrade: String):
	for i in range(nodes.size()):
		print(nodes[i].upgrade_name)
		#if upgrade == nodes.
