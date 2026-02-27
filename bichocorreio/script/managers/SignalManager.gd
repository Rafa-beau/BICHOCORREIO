extends Node
signal call_card
signal pause
signal tutorial
signal no_tutorial

signal is_water(isw: bool)
signal AntEat

### Signals pro PlayerManager/Player | Turno
signal life_changed(life)
signal died
signal coinchange(coin_int: int)
signal accept
signal reject

### Signais do carimbor (saber se tem cor ainda, etc)
signal stamp_pick(color: Color) #signal para pegar carimbo verde
signal stamp_has_color(has: bool)
signal bad_stamp
signal stamp

### Sinals do Upgrade

signal upgrade_purchased(upgrade_index: int, inverted: bool, enchanted: bool)
signal upgrade_clicked(upgrade_index: int)
signal upgrade_hovered(upgrade_name: String, upgrade_desc: String)
signal upgrade_dishovered
signal upgrade_blocked

signal set_upgrade_title_and_desc(title: String, desc: String)
