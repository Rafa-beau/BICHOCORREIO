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
var current_paw: Node
var current_upgrade_scene: Node
var pull = false

func _ready() -> void:
	SignalManager.no_tutorial.connect(no_tutorial)
	SignalManager.tutorial.connect(tutorial)
	SignalManager.upgrade_clicked.connect(no_tutorial)

func tutorial():
	await Utils.timer(1.2)
	$CanvasLayer.hide()
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await Utils.timer(0.4)
	$Background.play()

func no_tutorial():
	await Utils.timer(1.2)
	$CanvasLayer.hide()
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await Utils.timer(0.4)
	$Background.play()
	init_turn()
	
	#SignalManager.upgrade_clicked.connect()
	
### SISTEMA DE TURNO
var turn_index: int
var turn_controler: int
var can_pass_turn: bool

# iniciar turno
func init_turn(qtd_provas = PlayerManager.cards_per_turno):
	if current_upgrade_scene:
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
		while (can_pass_turn != true):
			await Utils.timer(0.2)
		turn_controler += 1
	end_turn()
# finalizar turno
func end_turn():
	current_upgrade_scene = Utils.spawn_scene(upgrade_scene, parent, Vector2(0, 0))

### SPAWNAR CARTA
func call_card():
	var des_summon = Vector2(198, 85)
	var paw_summon = Vector2(248, -114)
	
	current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
	
	if current_card.ball == false:
		current_paw = Utils.spawn_scene(paw, parent, Vector2(198, -2000))
	
	#CardManager.current_card = current_card
	
	var tween = create_tween()
	if current_paw:
		tween.tween_property(current_paw, "position", paw_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	SignalManager.call_card.emit()

### AÇÔES DA CARTA
func reject():
	PlayerManager.take_damage(1)
	current_card.queue_free()
	can_pass_turn = true

func accept():
	PlayerManager.heal(1)
	coin_up()
	current_card.queue_free()
	can_pass_turn = true

func coin_up():
	SignalManager.coinchange.emit(current_card.coins)
	
func next_card():
	if current_card:
		current_card.queue_free()
		if current_paw:
			current_paw.queue_free()
		next_card()

### MOVIMENTO
func move_card(des):
	var tween = create_tween()
	if current_card.ball == false:
		tween.tween_property(current_card, "position", des, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	if current_card.ball == true:
		tween.tween_property(current_card, "position", des, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		
	await Utils.timer(0.6)
	return

func move_paw(des):
	var tween = create_tween()
	tween.tween_property(current_paw, "position", des, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	await Utils.timer(0.6)
	return


### VALIDATORES
func accept_validate() -> bool:
	return CardManager.can_accept(CardClass.new(current_card, current_paw))
	
func confiscate_validate() -> bool:
	return CardManager.can_confiscate(CardClass.new(current_card, current_paw))

### ACEITAR E CONFISCAR - CLICK
func _on_accept_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card:
		if event.is_action_released("click"):
			pull = false
			await move_card(Vector2(1500, 85))
			if current_paw:
				await move_paw(Vector2(248, -1500))
			if accept_validate() == true:
				accept()
				return
			reject()

func _on_confiscate_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card :
		if event.is_action_released("click"):
			pull = false
			await move_card(Vector2(198, 1000))
			if current_paw:
				await move_paw(Vector2(248, -1500))
			if confiscate_validate() == true:
				accept()
				return
			reject()

func _on_ball_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card.ball == true:
		if event.is_action_released("click"):
			pull = false
			await move_card(Vector2(198, -1000))
			if current_paw:
				await move_paw(Vector2(248, -1500))
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

func _on_ball_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
			return
		return
