extends Node

var test : Dictionary = {
	0: {
		"normal": func(): print("aaaaaa")
	}
}

func _ready() -> void:
	SignalManager.upgrade_purchased.connect(set_upgrade)
	
func set_upgrade(upgrade_index: int, inverted: bool, enchanted: bool):
	if not inverted:
		test[upgrade_index]["normal"].call()
	print(upgrade_index)
	print("invertido: ", inverted)
	print("encantado: ", enchanted)
	
