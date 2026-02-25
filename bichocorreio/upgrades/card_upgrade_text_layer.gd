extends CanvasLayer

@export var title_rich: RichTextLabel
@export var desc_rich: RichTextLabel
@export var anim: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.set_upgrade_title_and_desc.connect(set_text)
	
func set_text(new_title, new_desc):
	title_rich.text	= new_title
	desc_rich.text = new_desc	 
	anim.play("in")
	
