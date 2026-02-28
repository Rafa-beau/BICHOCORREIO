extends Node

### variaveis vida e coins
var max_life :int = 3
var current_life :int = max_life
var coins: int
var total_coins: int
### array de habilidades ja compradas
var already_enchanted_cards_purchased: Array = []

### variaveis de controlar, sorte, mais ou menos moedas no fim do turno, tempo
var can_heal_end_turn: bool

# coins
var coins_after_turno: int # carrega quantas moedas o jogador vai perder no final do turno

# turno
var time_per_prova: float = 3.0
var cards_per_turno: int = 8
var error_ignored: int

# prova marinha
var water_card_chance: float = 0.2 # controla a chance de vir uma carta azul
var water_card_coins: int = 2 # controla a quantidade de coins q uma carta azul da\

# carimbo
var wears_stamp_chance: float = 0.45 # controla a chance do carimbo ir apagando

func reset():
	max_life = 3
	current_life = max_life
	coins = 0
	total_coins = 0
	already_enchanted_cards_purchased = []
	can_heal_end_turn = 0
	coins_after_turno = 0
	time_per_prova = 3.0
	cards_per_turno = 8
	error_ignored = 0
	water_card_chance = 0.2
	water_card_coins = 2
	wears_stamp_chance = 0.45

func _ready() -> void:
	reset()
	SignalManager.coinchange.connect(coinchange)

func change_can_heal_end_turn():
	can_heal_end_turn = not can_heal_end_turn

# tomar dano
func take_damage(amount):
	current_life -= amount
	current_life = max(current_life, 0)
	SignalManager.life_changed.emit(current_life)
	
	if current_life == 0:
		die()
		
#curar
func heal(amount):
	if current_life < max_life:
		current_life += amount
		SignalManager.life_changed.emit(current_life)

#morrer
func die():
	SignalManager.died.emit()

func coinchange(coin_int: int):
	coins += coin_int
	coins = max(coins, 0)
	
