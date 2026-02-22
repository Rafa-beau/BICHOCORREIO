extends Node



func _ready() -> void:
	$Player.life_changed.connect($HudLife.update_hearts)
