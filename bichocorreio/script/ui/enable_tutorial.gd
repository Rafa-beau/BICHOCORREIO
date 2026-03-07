extends CanvasLayer
@onready var sim: Button = $HBoxContainer/sim
@onready var nao: Button = $HBoxContainer/nao
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_pressed(extra_arg_0: int) -> void:
	$Click.play()
	match extra_arg_0:
		0:
			SignalManager.tutorial.emit()
			sim.disabled = true
			nao.disabled = true
			animation_player.play("tchau")

		1:
			SignalManager.no_tutorial.emit()
			sim.disabled = true
			nao.disabled = true
			animation_player.play("tchau")


func _on_mouse_entered() -> void:
	$Hover.play()
