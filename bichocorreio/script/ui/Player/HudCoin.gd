extends Control

@export var life_icon = Image
@onready var HudCoin: Label = $HudCoin
@onready var HudLife: HBoxContainer = $HudLife

var player = PlayerManager

func _ready() -> void:
	
	SignalManager.coinchange.connect(upd_display_coin)
	upd_display_coin()
	upd_display_life()
	
func upd_display_coin():
	HudCoin.text = "X" + str(player.coin)
	
func upd_display_life():
	var max_vidas = player.max_life
	while HudLife.get_child_count() < max_vidas:
		var heart_life = TextureRect.new()
		heart_life.texture = life_icon
		HudLife.add_child(heart_life)
	
	
	
