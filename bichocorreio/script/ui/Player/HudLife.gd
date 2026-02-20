extends CanvasLayer

@onready var hearts = $HeartContainer.get_children()

func update_hearts(current_life):
	for i in range(hearts.size()):
		hearts[i].visible = i < current_life
