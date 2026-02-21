extends Node

signal stamp #signal ao dar uma carimbada
signal call_card #sigal ao chamar card

signal pause # pausar
signal despause # despausar


### Signais do carimbor (saber se tem cor ainda, etc)
signal stamp_pick(color: String) #signal para pegar carimbo verde
signal stamp_has_color(has: bool)
