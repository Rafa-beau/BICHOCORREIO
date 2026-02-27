extends Node2D

@export var card_scene: PackedScene
@export var upgrade_scene: PackedScene
@export var paw: PackedScene
@export var player: GDScript
@export var transition: ColorRect
@onready var fumiga_layer: CanvasLayer = $Fumiga/FumigaCanvasLayer


var parent = self
var vel = 15
var current_card: Node
var current_upgrade_scene: Node
var pull = false

func _ready() -> void:
	
	
	await Utils.timer(0.2)
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await Utils.timer(0.4)
	$Background.play()
	init_turn()
	
	SignalManager.upgrade_clicked.connect(init_turn)
	
### SISTEMA DE TURNO
var turn_index: int
var turn_controler: int
var can_pass_turn: bool

# iniciar turno
func init_turn(qtd_provas = PlayerManager.cards_per_turno):
	if current_upgrade_scene:
		current_upgrade_scene.queue_free()
		TransitionScene.play_out()
		await Utils.timer(1)
	turn_index = qtd_provas
	turn_controler = 0
	exec_turn()
	
# executar turno
func exec_turn():
	while turn_controler < turn_index:
		can_pass_turn = false
		call_card()
		print("turno iniciado")
		while (can_pass_turn != true):
			await Utils.timer(0.2)
		turn_controler += 1
	end_turn()
# finalizar turno
func end_turn():
	current_upgrade_scene = Utils.spawn_scene(upgrade_scene, parent, Vector2(0, 0))




### SPAWNAR CARTA
func call_card():
	var des_summon = Vector2(98, 85)
	
	current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
	print(current_card)
	#CardManager.current_card = current_card
	
	var tween = create_tween()
	tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	SignalManager.call_card.emit()

### AÇÔES DA CARTA
func reject():
	PlayerManager.take_damage(1)
	$Hit.play()
	current_card.queue_free()
	can_pass_turn = true
	print("rejeitou")

func accept():
	PlayerManager.heal(1)
	coin_up()
	current_card.queue_free()
	can_pass_turn = true
	print("ceitou")

func coin_up():
	SignalManager.coinchange.emit(current_card.coins)
	
func next_card():
	if current_card:
		current_card.queue_free()
		next_card()

### MOVIMENTO
func move_card(des):
	var tween = create_tween()
	tween.tween_property(current_card, "position", des, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await Utils.timer(0.6)
	return

### VALIDATORES
func accept_validate() -> bool:
	if current_card.water == true and current_card.water_stamp == true:
		current_card.water = false
		return true
	if current_card.water == false and current_card.water_stamp == false and current_card.stamped == true:
		if current_card.is_anteat == true:
			if current_card.paw.disapproved == true:
				return true
		if current_card.is_anteat == false:
			if current_card.paw.stamped == true:
				return false
	return false
	
func confiscate_validate() -> bool:
	# troocar para as validacoes certas dps
	if current_card.water == true and current_card.water_stamp == true:
		current_card.water = false
		return true
	if current_card.water == false and current_card.water_stamp == false and current_card.stamped == true:
		if current_card.is_anteat == true:
			if current_card.paw.disapproved == true:
				return true
		if current_card.is_anteat == false:
			if current_card.paw.stamped == true:
				return false
	return false
		
### ACEITAR E CONFISCAR - CLICK
func _on_accept_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card:
		if event.is_action_released("click"):
			pull = false
			await move_card(Vector2(1500, 85))
			if accept_validate() == true:
				accept()
				return
			reject()

func _on_confiscate_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card :
		if event.is_action_released("click"):
			pull = false
			await move_card(Vector2(198, 1000))
			if confiscate_validate() == true:
				accept()
				return
			reject()
			
### ACEITAR E CONFISCAR - MOUSE ENTERED
func _on_accept_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
			return
		return
			

func _on_confiscate_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
			return
		return
