extends Control
@export var _upgrade_index: int = -1: 
	set(value):
		print(value)
		if value != upgrade_index:
			upgrade_index = value
			set_enchant_or_inverted()
			set_text_and_desc()
@export var card: Sprite2D
@export var shine: Sprite2D
@export var card_viewport: SubViewportContainer
@export var inverted_texture: Texture2D 
@export var enchanted_texture: Texture2D

enum upgrades {
	LOUCO,
	MAGO,
	IMPERATRIZ,
	HIEROFANTE,
	IMPERADOR,
	JUSTICA,
	ENFORCADO,
	TEMPERANCA,
	DIABO,
	TORRE
}

var upgrade_index: int = -1
var upgrade_name: String 
var upgrade_desc: String = "[wave]"
var enchanted: bool
var inverted: bool

var enchantble_cards: Array[int] = [upgrades.LOUCO, upgrades.MAGO, upgrades.JUSTICA, upgrades.ENFORCADO]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	SignalManager.upgrade_clicked.connect(burn_card)
	
	print("inverted:", inverted)
	print("enchanted:", enchanted)
	
	pass

func set_text_and_desc():
	match upgrade_index:
		upgrades.LOUCO:
			upgrade_name = "[tornado]O    L O U C O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				
				upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] perdidas no fim do turno em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] aumenta em 1"
				return
			if enchanted == true:
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				return
		upgrades.MAGO:
			upgrade_name = "[tornado]O    M A G O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				return
			if enchanted == true:
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				return
		upgrades.IMPERATRIZ:
			upgrade_name = "[tornado]A    I M P E R A T R I Z"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				return
			
			pass
		upgrades.HIEROFANTE:
			upgrade_name = "[tornado]O    H I E R O F A N T E"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				return
			
			pass		
		upgrades.IMPERADOR:
			upgrade_name = "[tornado]O    I M P E R A D O R"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				return
			pass
		upgrades.JUSTICA:
			upgrade_name = "[tornado]A    J U S T I C A"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				return
			if enchanted == true:
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				return
			pass
		upgrades.ENFORCADO:
			upgrade_name = "[tornado]O    E N F O R C A D O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				return
			if enchanted == true:
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				return
			
			pass
		upgrades.TEMPERANCA:
			upgrade_name = "[tornado]A    T E M P E R A N Ç A"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				return
			
			pass
		upgrades.DIABO:
			upgrade_name = "[tornado]O    D I A B O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				return
			
			pass
		upgrades.TORRE:
			upgrade_name = "[tornado]A    T O R R E"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				return
			pass

func set_inverted():
	if randf() < 0.3:
		inverted = true
		card.texture = inverted_texture
		
func set_enchant():
	if upgrade_index in enchantble_cards and not upgrade_index in PlayerManager.already_enchanted_cards_purchased:
		if randf() < 0.3 and not inverted or upgrade_index == 8:
			var mat: ShaderMaterial = shine.material
			enchanted = true
			mat.set_shader_parameter("Line_Width", 0.083)
			mat.set_shader_parameter("Distortion", 1.857)
			mat.set_shader_parameter("Speed", 1.16)
			card.texture = enchanted_texture
			
	

func set_enchant_or_inverted():
	set_inverted()
	set_enchant()


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func burn_card(upgrade):
	if upgrade == upgrade_index:
		return
	var tween = create_tween()
	tween.tween_property(card_viewport.material, "shader_parameter/dissolve_value", 0.0, 1.0)
	tween.play()


func _on_sub_viewport_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if card_viewport.mouse_animate == true:
				SignalManager.upgrade_purchased.emit(upgrade_index, inverted, enchanted)
	pass # Replace with function body.	
