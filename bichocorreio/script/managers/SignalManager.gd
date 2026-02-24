extends Node
signal call_card
signal pause
signal despause


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

signal upgrade_purchased(upgrade_name: String, cost: int, inverted: bool, enchanted: bool)
signal upgrade_clicked(upgrade: String)
signal upgrade_blocked
