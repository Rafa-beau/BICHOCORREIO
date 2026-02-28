extends CanvasLayer

@onready var anim = $AnimationPlayer

const TIMER_LIMIT = 2.0
var timer = 0
var a : bool = true

func play_in():
	anim.play("in")
	a = true
	
func play_out():
	anim.play("out")
	a = false
	await Utils.timer(1.7)
