extends Node
signal call_card

signal pause
signal despause

signal coinup



### Signais do carimbor (saber se tem cor ainda, etc)
signal stamp_pick(color: String) #signal para pegar carimbo verde
signal stamp_has_color(has: bool)
signal bad_stamp
signal stamp


### Sinals do Upgrade

signal upgrade_purchased # colocar parametro (upgrade, cost) dps
signal upgrade_clicked(upgrade: String)
signal upgrade_blocked
