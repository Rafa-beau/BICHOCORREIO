extends Area2D

@export var coin: Node

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			self.hide()
			SignalManager.coinchange.emit(1)
