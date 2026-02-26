extends Node

var pm = PlayerManager

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
			1: func(): change_coins_after_turn(1),
			2: func(): change_time_per_prova(-0.5)
		},
		"inverted": {
			1: func(): change_coins_after_turn(-1),
			2: func(): change_time_per_prova(0.5)
		},
		"enchanted":{
			1: func(): PlayerManager.change_can_heal_end_turn()
		}
		},
	2: { # imperatriz
		"normal": {
			1: func(): change_coins_after_turn(-2),
			2: func(): change_time_per_prova(pm.time_per_prova * 0.05)
		},
		"inverted": {
			1: func(): change_coins_after_turn(2),
			2: func(): change_time_per_prova(pm.time_per_prova *  -0.05)
		}
		},
	3: { # hierofante
		"normal": {
			1: func(): change_wears_stamp_chance(0.10),
			2: func(): change_water_card_chance(0.10)
		},
		"inverted": {
			1: func(): change_wears_stamp_chance(-0.10),
			2: func(): change_water_card_chance(-0.10)
		}
		},
	4: { # imperador
		"normal": {
			1: func(): change_water_card_coins(1),
			2: func(): change_water_card_chance(-0.10)
		},
		"inverted": {
			1: func(): change_water_card_coins(-1),
			2: func(): change_water_card_chance(0.15)
		},
		},
	5: { # justica
		"normal": {
			1: func(): change_time_per_prova(0.5),
		},
		"inverted": {
			1: func(): change_time_per_prova(-0.5),
		},
		"enchanted":{
			1: func(): change_error_ignored(2)
		}
		},
	6: { # enforcado 
		"normal": {
			1: func(): change_cards_per_turn(-2),
			2: func(): change_coins_after_turn(3)
		},
		"inverted": {
			1: func(): change_cards_per_turn(2),
			2: func(): change_coins_after_turn(-3)
		},
		"enchanted":{
			1: func(): change_max_life(1)
		}
		},
	7: { # temperanca
		"normal": {
			1: func(): change_time_per_prova(0.5),
			2: func(): change_water_card_chance(PlayerManager.water_card_chance * -0.04)
		},
		"inverted": {
			1: func(): change_time_per_prova(-0.5),
			2: func(): change_water_card_chance(PlayerManager.water_card_chance * 0.04)
		},
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

func devil_function(inverted: bool):
	if inverted:
		change_coins_after_turn(4)
		var habilidades: Dictionary[int, Callable] = {
			0: Callable(self, change_error_ignored(-1)),
			1: Callable(self, PlayerManager.change_can_heal_end_turn()),
			5: Callable(self, change_error_ignored(-2)),
			6: Callable(self, change_max_life(-1))
		}
		var in_habilities: bool
		while in_habilities == false:
			await get_tree().process_frame
			var ramdon_key : Array = habilidades.keys()
			ramdon_key.shuffle()
			if PlayerManager.already_enchanted_cards_purchased.has(ramdon_key[1]):
				habilidades[ramdon_key[1]].call()
				in_habilities == true
				break
		
	change_coins_after_turn(-6)
	change_time_per_prova(4)

func change_coins_after_turn(value):
	pm.coins_after_turno += value
	
func change_time_per_prova(value):
	pm.time_per_prova += value
	
func change_cards_per_turn(value):
	pm.cards_per_turno += value

func change_water_card_chance(value):
	pm.water_card_chance += value
	
func change_water_card_coins(value):
	pm.water_card_coins += value
	
func change_wears_stamp_chance(value):
	pm.wears_stamp_chance += value

func change_error_ignored(value):
	pm.error_ignored += value
func change_max_life(value):
	PlayerManager.max_life += value
	PlayerManager.heal(value)
	SignalManager.life_changed.emit()

func set_upgrade(upgrade_index: int, inverted: bool, enchanted: bool):
	if inverted:
		test[upgrade_index]["inverted"][1].call()
		if test[upgrade_index]["inverted"].has(2):
			test[upgrade_index]["inverted"][2].call()
		return
	if enchanted:
		test[upgrade_index]["enchanted"][1].call()
		if test[upgrade_index]["enchanted"].has(2):
			test[upgrade_index]["enchanted"][2].call()
		return
	test[upgrade_index]["normal"][1].call()
	if test[upgrade_index]["normal"].has(2):
		test[upgrade_index]["normal"][2].call()
			
			
	print("invertido: ", inverted)
	print("encantado: ", enchanted)
	
