extends Control

@export var card: Node
@export var card_viewport: SubViewportContainer
@export var textures: Array[Texture2D]
@export var upgrade_name = ""
var upgrades = []

var upgrade_cost: int
var upgrade_texture: Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var material_burn = card_viewport.material.duplicate()
	card_viewport.material = material_burn	
	upgrades = [
		{
		"upgrade_name": "fool",
		"upgrade_cost": 0,
		"upgrade_texture": textures[0]
		},
		{
		"upgrade_name": "magician",
		"upgrade_cost": 0,
		"upgrade_texture": textures[1]
		},
		{
		"upgrade_name": "priestess",
		"upgrade_cost": 0,
		"upgrade_texture": textures[2]
		},
		{
		"upgrade_name": "empress",
		"upgrade_cost": 0,
		"upgrade_texture": textures[3]
		},
		{
		"upgrade_name": "emperor",
		"upgrade_cost": 0,
		"upgrade_texture": textures[4]
		},
		{
		"upgrade_name": "hiero",
		"upgrade_cost": 0,
		"upgrade_texture": textures[5]
		}
		]
	
	var upgrade_cart = upgrades.pick_random()
	
	upgrade_name = upgrade_cart["upgrade_name"]
	upgrade_cost = upgrade_cart["upgrade_cost"]
	upgrade_texture = upgrade_cart["upgrade_texture"]
	
	card.texture = upgrade_texture
	SignalManager.upgrade_clicked.connect(burn_card)
	pass

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
