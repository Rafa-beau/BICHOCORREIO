extends Node

enum upgrade_name {
	LOUCO,
	MAGO,
	IMPERATRIZ,
	HIEROFANTE,
	IMPERADOR,
	JUSTICA,
	ENFORCADO,
	TEMPERANCA,
	DIABO,
	TORRE
}

func _ready() -> void:
	SignalManager.upgrade_purchased.connect(set_upgrade)
	
func set_upgrade(upgrade_index: int, cost: int, inverted: bool, enchanted: bool):
	match upgrade_index:
		upgrade_name.LOUCO:
			pass
		upgrade_name.MAGO:
			pass
		upgrade_name.IMPERATRIZ:
			pass
		upgrade_name.HIEROFANTE:
			pass		
		upgrade_name.IMPERADOR:
			pass
		upgrade_name.JUSTICA:
			pass
		upgrade_name.ENFORCADO:
			pass
		upgrade_name.TEMPERANCA:
			pass
		upgrade_name.DIABO:
			pass
		upgrade_name.TORRE:
			pass
