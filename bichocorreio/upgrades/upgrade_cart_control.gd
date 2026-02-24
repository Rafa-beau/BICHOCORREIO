extends Control
@export var upgrade_index: int
@export var card: Node
@export var card_viewport: SubViewportContainer


var upgrade_name: String
var enchanted: bool
var inverted: bool

var enchantble_cards: Array = [0, 4, 5, 8, 9]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var material_burn = card_viewport.material.duplicate()
	card_viewport.material = material_burn	
	SignalManager.upgrade_clicked.connect(burn_card)
	random_type_of_upgrade_card()
	pass

func random_type_of_upgrade_card():
	
	
			
	print("inverted:", inverted)
	print("enchanted:", enchanted)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func burn_card(up_name):
	if up_name == upgrade_name:
		return
	var tween = create_tween()
	tween.tween_property(card_viewport.material, "shader_parameter/dissolve_value", 0.0, 1.0)
	tween.play()


func _on_sub_viewport_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			SignalManager.upgrade_clicked.emit(upgrade_name)
	pass # Replace with function body.
