extends Label

@onready var player = get_node("../Life/Player")

func _ready() -> void:
	SignalManager.coinup.connect(coinup)
	upd_display()

func coinup():
	upd_display()

func upd_display():
	text = "X" + str(player.coin)
