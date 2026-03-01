extends Control
@export var _upgrade_index: int = -1: 
	set(value):
		print(value)
		if value != upgrade_index:
			upgrade_index = value
			set_enchant_or_inverted()
			set_text_and_desc()
			card.frame = upgrade_index
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
var cost
var enchantble_cards: Array[int] = [upgrades.LOUCO, upgrades.MAGO, upgrades.ENFORCADO]

var enchant_chance: float = 2.3
var inverted_chance: float = 0
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
			cost = 10
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				
				upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] perdidas no fim do [color=green]TURNO[/color] em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] aumenta em 1"
				return
			if enchanted == true:
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				cost = 20
				upgrade_desc += "Primeiro [color=green]ERRO[/color] no [color=green]TURNO[/color] não diminui sua [color=green]VIDA[/color]"
				return
			
			upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] ganhas no fim do [color=green]TURNO[/color] em [color=green]3[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] diminui em 2 [color=gray]até o minino de tempo possivel(3 Segundos)"
		upgrades.MAGO:
			cost = 10
			upgrade_name = "[tornado]O    M A G O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] perdidas no fim do [color=green]TURNO[/color] em [color=green]1[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] aumenta em 0.5"
				return
			if enchanted == true:
				cost = 20
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				upgrade_desc += "Cura [color=green]1[/color] de [color=green]VIDA[/color] após o fim do [color=green]TURNO[/color]"
				return
			upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] ganhas no fim do turno em [color=green]1[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] diminui em 0.5 [color=gray]até o minino de tempo possivel(3 Segundos)"
		upgrades.IMPERATRIZ:
			cost = 10
			upgrade_name = "[tornado]A    I M P E R A T R I Z"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				
				upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] ganhas no fim do turno em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] diminui em 5%[color=gray](máximo de 3 Segundos)"
				return
			upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] perdidas no fim do turno em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] aumenta em 5%[color=gray](Mín: 1 Segundo, Máx: 4 Segundos)"
			pass
		upgrades.HIEROFANTE:
			cost = 10
			upgrade_name = "[tornado]O    H I E R O F A N T E"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				upgrade_desc += "Diminui a [color=green]CHANCE[/color] da sua [color=green]TINTA[/color] acabar em [color=green]10%[/color]. Porém diminui a [color=green]CHANCE[/color] de uma [color=dodger_blue]Prova Marinha[/color] [color=green]APARECER[/color] em [color=green]10%[/color]"
				return
			upgrade_desc += "Aumenta a [color=green]CHANCE[/color] da sua [color=green]TINTA[/color] acabar em [color=green]10%[/color]. Porém aumenta a [color=green]CHANCE[/color] de uma [color=dodger_blue]Prova Marinha[/color] [color=green]APARECER[/color] em [color=green]10%[/color]"
			pass		
		upgrades.IMPERADOR:
			cost = 10
			upgrade_name = "[tornado]O    I M P E R A D O R"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				upgrade_desc += "Diminui a quantidade de [color=green]MOEDAS[/color] recebida por uma [color=dodger_blue]Prova Marinha[/color] em [color=green]1[/color][color=gray](Até a quantidade recebida for 1)[/color]. Porém aumenta a chance da mesma [color=green]APARECER[/color] em [color=green]15%[/color] [color=gray](Máx: 30%)[/color]"
				return
			upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] recebida por uma [color=dodger_blue]Prova Marinha[/color] em [color=green]1[/color][color=gray](Máx: 2)[/color]. Porém dimuinui a chance da mesma [color=green]APARECER[/color] em [color=green]10%[/color]"
		upgrades.ENFORCADO:
			cost = 10
			upgrade_name = "[tornado]O    E N F O R C A D O"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDO"
				upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] ganhas no fim do [color=green]TURNO[/color] em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] diminui em 3"
				return
			if enchanted == true:
				cost = 20
				upgrade_name+= "[/tornado][color=medium_orchid][wave]  ENCANTADO"
				upgrade_desc += "Aumenta sua [color=green]VIDA MÁXIMA[/color] em [color=green]1[/color]"
				return
			upgrade_desc += "Aumenta a quantidade de [color=green]MOEDAS[/color] perdidas no fim do [color=green]TURNO[/color] em [color=green]2[/color]. Porém seu [color=green]TEMPO POR CARTA[/color] aumenta em 3"
			pass
		upgrades.TEMPERANCA:
			cost = 10
			upgrade_name = "[tornado]A    L U A"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				upgrade_desc += "Diminui seu [color=green]TEMPO POR PROVA[/color] em [color=green]0.5[/color]. Porém aumenta em [color=green]4%[/color] a [color=green]CHANCE[/color] de uma [color=dogder_blue]Prova Marinha[/color] Aparecer"
				return
			upgrade_desc += "Aumenta seu [color=green]TEMPO POR PROVA[/color] em [color=green]0.5[/color]. Porém diminui em [color=green]4%[/color] a [color=green]CHANCE[/color] de uma [color=dogder_blue]Prova Marinha[/color] Aparecer"
			pass
		upgrades.DIABO:
			cost = 25
			upgrade_name = "[shake][color=dark_red]O DIABO"
			if inverted == true:
				upgrade_name += "[/color][color=green]  INVERTIDO"
				upgrade_desc += "[color=red]Todo pacto tem um preço. Aumenta a quantidade de [color=tomato]MOEDAS[/color] perdidas após o fim do [color=tomato]TURNO[/color] em [color=tomato][shake]6[/shake][/color]. Porém, o seu [color=tomato]TEMPO POR PROVA[/color] aumenta em [color=tomato][shake]4[/shake][/color][/color]"
				return
			upgrade_desc += "[color=red]Aumenta a quantidade de [color=tomato]MOEDAS[/color] ganhas após o fim do [color=tomato]TURNO[/color] em [color=tomato]4[/color]. Porém, todo pacto tem um preço. Uma das suas [color=tomato]HABILIDADES[/color] será [color=tomato]EXCLUIDA[/color] em qualquer momento![/color]"
			pass
		upgrades.TORRE:
			cost = 10
			upgrade_name = "[tornado]A    M O R T E"
			if inverted == true:
				upgrade_name += "[/tornado][color=dodger_blue][shake]  INVERTIDA"
				upgrade_desc += "Diminui a [color=green]CHANCE[/color] de uma [color=dodger_blue]Prova Marinha[/color] aparecer em [color=green]15%[/color], Porém aumenta a quantidade de [color=green]CARTAS POR TURNO[/color] em [color=green]2[/color]. [color=gray](Máx: 4)[/color]"
				return
				
			upgrade_desc += "Aumenta a [color=green]CHANCE[/color] de uma [color=dodger_blue]Prova Marinha[/color] aparecer em [color=green]15%[/color], Porém diminui a quantidade de [color=green]CARTAS POR TURNO[/color] em [color=green]2[/color]. [color=gray](Min: 3 cartas por turno)[/color]"
			pass
			

func set_inverted():
	inverted = true
	card.texture = inverted_texture
		
func set_enchant():
	var mat: ShaderMaterial = shine.material
	enchanted = true
	mat.set_shader_parameter("Line_Width", 0.083)
	mat.set_shader_parameter("Distortion", 1.857)
	mat.set_shader_parameter("Speed", 1.16)
	
	

func set_enchant_or_inverted():
	if upgrade_index == 8:
		set_enchant()
	
	if randf() < inverted_chance:
		set_inverted()
	
	if upgrade_index in enchantble_cards and not upgrade_index in PlayerManager.already_enchanted_cards_purchased:
		if randf() < enchant_chance and not inverted:
			set_enchant()
			card.texture = enchanted_texture


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func burn_card(upgrade):
	if upgrade == upgrade_index:
		return
	var tween = create_tween()
	tween.tween_property(card_viewport.material, "shader_parameter/dissolve_value", 0.0, 1.0)
	tween.play()

	pass # Replace with function body.	
