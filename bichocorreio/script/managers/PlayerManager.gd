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

# stats
var accept_q: int = 0
var reject_q: int = 0
var start_time: int = 0
var tuto: bool = false
var skip_tutorial_prompt: bool = false

# coins
var coins_after_turno: int # carrega quantas moedas o jogador vai perder no final do turno

# turno
var time_per_prova: float = 15.0
var cards_per_turno: int = 8
var error_ignored: int

# prova marinha
var water_card_chance: float = 0.2 # controla a chance de vir uma carta azul
var water_card_coins: int = 2 # controla a quantidade de coins q uma carta azul da\

# carimbo
var wears_stamp_chance: float = 0.45 # controla a chance do carimbo ir apagando

const CONFIG_PATH = "user://config.cfg"

func reset():
	max_life = 3
	current_life = max_life
	coins = 0
	total_coins = 0
	accept_q = 0
	reject_q = 0
	already_enchanted_cards_purchased = []
	can_heal_end_turn = false
	coins_after_turno = 0
	cards_per_turno = 8
	error_ignored = 0
	water_card_chance = 0.2
	water_card_coins = 2
	wears_stamp_chance = 0.45
	start_time = Time.get_ticks_msec()
	tuto = false

func _ready() -> void:
	load_config()
	reset()
	SignalManager.coinchange.connect(coinchange)

func save_config():
	var config = ConfigFile.new()
	config.set_value("settings", "skip_tutorial_prompt", skip_tutorial_prompt)
	config.save(CONFIG_PATH)

func load_config():
	var config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)
	if err == OK:
		skip_tutorial_prompt = config.get_value("settings", "skip_tutorial_prompt", false)

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
	if coin_int > 0:
		total_coins += coin_int

func get_time_played() -> String:
	var total_msec = Time.get_ticks_msec() - start_time
	var total_sec = total_msec / 1000
	var minutes = total_sec / 60
	var seconds = total_sec % 60
	return "%02d:%02d" % [minutes, seconds]
	
