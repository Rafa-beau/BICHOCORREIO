extends Control

@export var life_icon = Image
@export var HudCoin: RichTextLabel
@export var HudLife: HBoxContainer
var base_current_life = 3

var player = PlayerManager

func _ready() -> void:
	
	SignalManager.coinchange.connect(upd_display_coin)
	SignalManager.life_changed.connect(upd_display_life)
	upd_display_coin(1)
	upd_display_life(1)

func upd_display_coin(a: int):
	HudCoin.text = "[shake][img]res://assets/moeda.png[/img]x[wave]" + str(player.coins) + " "
	
func upd_display_life(a: int):
	for i in range(HudLife.get_children().size()):
		HudLife.get_children()[i].visible = i < player.current_life
		if player.current_life < base_current_life:
			$Hit.play()
		
		base_current_life = player.current_life
