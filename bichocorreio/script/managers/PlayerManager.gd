extends Node
class_name Player


### variaveis vida e coins
var max_life = 3
var current_life = max_life
var coin = 0

### variaveis de habilidades

#serao apenas essas cartas encantadas q virarao habilidades
var hability_o_louco: bool
var hability_a_imperatriz: bool
var hability_o_enforcado: bool
var hability_o_diabo: bool
var hability_a_torre: bool

### variaveis de controlar, sorte, mais ou menos moedas no fim do turno, tempo

var coins_up_after_turno: int # carrega quantas moedas a mais o jogador vai receber no final do turno
var coins_down_after_turno: int # carrega quantas moedas a mais o jogador vai perder no final do turno
var time_up_to_stamp: float # carrega o tempo a mais pra carimbar e passar/confiscar uma carta
var time_down_to_stamp: float # carrega o tempo a menos pra carimbar e passar/confiscar uma carta
var time_to_stamp: float # valor base do tempo pra carimbar e passar/confiscar uma carta 
var water_card_chance: float = 0.2 # controla a chance de vir uma carta azul
var water_card_coins: int = 2 # controla a quantidade de coins q uma carta azul da

func _ready() -> void:
	SignalManager.coinchange.connect(coinchange)

# tomar dano
func take_damage(amount):
	current_life -= amount
	current_life = max(current_life, 0)
	SignalManager.life_changed.emit(current_life)
	
	if current_life == 0:
		die()
		
#curar
func take_cure(amount):
	current_life += amount
	current_life = max(current_life, 0)
	SignalManager.life_changed.emit(current_life)

#morrer
func die():
	SignalManager.died.emit()

func coinchange(coin_int: int):
	coin += coin_int
