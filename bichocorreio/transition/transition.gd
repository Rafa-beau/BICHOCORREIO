extends CanvasLayer

@onready var anim = $AnimationPlayer

func play_in():
	anim.play("in")
	
func play_out():
	anim.play("out")
