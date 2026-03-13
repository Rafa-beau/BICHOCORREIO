extends CanvasLayer

@export var life_icon = Image
@export var HudCoin: RichTextLabel
@export var HudLife: HBoxContainer
@onready var leftlabel = $Cards_left
@onready var timelabel = $Time_left

var cardleft: int:
	set(value):
		cardleft = value
		if is_node_ready():
			_update_left_label()

var timeleft: float:
	set(value):
		timeleft = value
		if is_node_ready():
			_update_time_label()

var base_current_life = 3
var base_current_coins = 0
var player = PlayerManager

func _ready() -> void:
	SignalManager.coinchange.connect(upd_display_coin)
	SignalManager.life_changed.connect(upd_display_life)
	# Initialize displays
	upd_display_coin(0)
	upd_display_life(player.current_life)
	_update_left_label()
	_update_time_label()

func _update_left_label():
	leftlabel.text = "[wave]Provas restantes:\n[wave]" + str(cardleft) + " "

func _update_time_label():
	if timeleft > 0:
		timelabel.text = "[wave]Tempo restante:\n[wave]" + str(snapped(timeleft, 0.1)) + "s "
		timelabel.visible = true
	else:
		timelabel.visible = false

func upd_display_coin(a: int):
	if HudCoin:
		HudCoin.text = "[wave]" + str(player.coins) + "[/wave]"
	
	if player.coins < base_current_coins:
		$coin_down.play()
	elif player.coins > base_current_coins:
		$coin_up.play()
		
	base_current_coins = player.coins

func upd_display_life(a: int):
	if HudLife:
		var life_label = HudLife.get_node_or_null("Node2D/RichTextLabel")
		if life_label:
			life_label.text = str(player.current_life)
			
	if player.current_life < base_current_life:
		$Hit.play()
	
	base_current_life = player.current_life
