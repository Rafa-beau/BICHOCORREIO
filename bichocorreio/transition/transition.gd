extends CanvasLayer

@onready var anim = $AnimationPlayer

const TIMER_LIMIT = 2.0
var timer = 0


func play_in():
	anim.play("in")
	
func play_out():
	anim.play("out")
	await Utils.timer(1.7)
