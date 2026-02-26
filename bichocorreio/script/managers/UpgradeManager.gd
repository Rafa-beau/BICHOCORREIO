extends Node

var test : Dictionary = {
	0: { # louco
		"normal": {
			1: func(): change_coins_after_turn(-1),
			2: func(): change_time_per_prova(-2)
		},
		"inverted": {
			1: func(): change_coins_after_turn(-2),
			2: func(): change_time_per_prova(1)
		},
		"enchanted": {
			1: func(): change_error_ignored(1)
		}
		},
	1: { # mago
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	2: { # imperatriz
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	3: { # hierofante
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	4: { # imperador
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	5: { # justica
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	6: { # enforcado
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	7: { # temperanca
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	8: { # diabo
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		},
	9: { # a torre
		"normal": {
			1: func(): pass,
			2: func(): pass
		},
		"inverted": {
			1: func(): pass,
			2: func(): pass
		},
		"enchanted":{
			1: func(): pass,
			2: func(): pass
		}
		}
}


func _ready() -> void:
	SignalManager.upgrade_purchased.connect(set_upgrade)

### Funcoes pra dar change nas variaveis de PlayerManager

func change_coins_after_turn(value):
	pass
	
func change_time_per_prova(value):
	pass
	
func change_cards_per_turn(value):
	pass

func change_water_card_chance(value):
	pass
	
func change_water_card_coins(value):
	pass
	
func change_wears_stamp_chane(value):
	pass

func change_error_ignored(value):
	pass


func set_upgrade(upgrade_index: int, inverted: bool, enchanted: bool):
	if inverted:
		test[upgrade_index]["inverted"][1].call()
		if test[upgrade_index]["inverted"][2]:
			test[upgrade_index]["inverted"][2].call()
		return
	if enchanted:
		test[upgrade_index]["enchanted"][1].call()
		if test[upgrade_index]["enchanted"][2]:
			test[upgrade_index]["enchanted"][2].call()
		return
	test[upgrade_index]["normal"][1].call()
	if test[upgrade_index]["normal"][2]:
		test[upgrade_index]["normal"][2].call()
			
			
	print("invertido: ", inverted)
	print("encantado: ", enchanted)
	
