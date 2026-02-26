extends Control

@export var life_icon = Image
@onready var HudCoin: Label = $HudCoin
@onready var HudLife: HBoxContainer = $HudLife


var player = PlayerManager

func _ready() -> void:
	
	SignalManager.coinchange.connect(upd_display_coin)
	SignalManager.life_changed.connect(upd_display_life)
	upd_display_coin(1)
	upd_display_life(1)

func upd_display_coin(a: int):
	HudCoin.text = "X" + str(player.coins)
	
func upd_display_life(a: int):
	for i in range(HudLife.get_children().size()):
		HudLife.get_children()[i].visible = i < player.current_life
