extends CanvasLayer
@export var rich_text_label: RichTextLabel

@export var title_rich: RichTextLabel
@export var desc_rich: RichTextLabel
@export var anim: AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.set_upgrade_title_and_desc.connect(set_text)
	
func set_text(new_title, new_desc, cost):
	title_rich.text	= new_title
	desc_rich.text = new_desc	 
	rich_text_label.text = "[shake][img]res://assets/moeda.png[/img][wave]" + str(cost)
	anim.play("in")
	
