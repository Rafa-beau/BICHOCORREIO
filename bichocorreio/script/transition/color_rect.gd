extends ColorRect

@export var anim: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func play_out():
	anim.play("transition_out")

func play_in():
	anim.play("transition_in")
	
