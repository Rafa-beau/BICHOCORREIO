extends Node2D

@export var card_scene: PackedScene
@export var upgrade_scene: PackedScene
@export var paw: PackedScene
@export var player: GDScript
@export var transition: ColorRect
@onready var fumiga_layer: CanvasLayer = $Fumiga/FumigaCanvasLayer
const TUTO = preload("uid://bkmmcqqu3qw8g")

var err_pass = 0
@onready var combo_ui = $ComboUI

var parent = self
var vel = 15
var current_card: Node
var current_paw: Node
var current_upgrade_scene: Node
var pull = false
var tuto = false

func _ready() -> void:
	PlayerManager.reset()
	SignalManager.coinchange.emit(0)
	SignalManager.no_tutorial.connect(no_tutorial)
	SignalManager.tutorial.connect(tutorial)
	

func tutorial():
	await Utils.timer(1.2)
	$CanvasLayer.hide()
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await Utils.timer(0.4)
	$Background.play()
	Utils.spawn_scene(TUTO, parent, 0)
	SignalManager.step.emit()
	tuto = true
	
	var call_card = func(): 
		current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, 85))
		
	var call_normal = func():
		call_card.call()
		current_card.balls_chance = 0
		current_card.bribe_chance = 0
		current_card.stamp_chance = 0
		current_card.stamp.hide()
		
	var step2_confirm = func():
		if not current_card.stamped:
			call_normal.call()
			return
		SignalManager.step2_finish.emit()
	
	var step4_upgrade = func():
		var up = Utils.spawn_scene(upgrade_scene, parent, 0)
	
	SignalManager.step2_finish.emit()
	#signals
	SignalManager.step2.connect(call_normal)
	SignalManager.confiscar.connect(step2_confirm)
	SignalManager.aceitar.connect(step2_confirm)
	SignalManager.step3.connect(step3)
	SignalManager.step4.connect(step4_upgrade)
	SignalManager.dispause.connect(Utils.disable_cursor)
func step3(i):
	pull = true
	match i:
		0:
			move_card(Vector2(198, 1000))
			move_paw(Vector2(248, -1500))
		1:
			var des_summon = Vector2(198, 85)
			current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
			current_card.stamp.hide()
			current_card.card_frame.hide()
			current_card.ball_text.show()
			current_card.bribe_chance = 0
			
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		2:
			move_card(Vector2(198, 1000))
			await Utils.timer(0.7)
			current_card.queue_free()
			var des_summon = Vector2(198, 85)
			
			current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
			current_card.stamp.show()
			current_card.card_frame.show()
			current_card.ball_text.hide()
			current_card.bribe_chance = 0
			
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		3:
			move_card(Vector2(198, 1000))
			await Utils.timer(0.7)
			current_card.queue_free()
			var des_summon = Vector2(198, 85)
			var paw_summon = Vector2(248, -114)
			
			current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
			current_card.stamp.hide()
			current_card.card_frame.show()
			current_card.ball_text.hide()
			current_card.card_frame.frame = 0
			current_card.bribe_chance = 0
			
			current_paw = Utils.spawn_scene(paw, parent, Vector2(198, -2000))
			current_paw.paws_water.hide()
			current_paw.paws.show()
			current_paw.paws.frame = 4			
			var tween = create_tween()
			var tween_paw = create_tween()
			tween_paw.tween_property(current_paw, "position", paw_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			SignalManager.call_card.emit()
		4:
			move_card(Vector2(198, 1000))
			move_paw(Vector2(248, -1500))
			await Utils.timer(0.7)
			current_card.queue_free()
			var des_summon = Vector2(198, 85)
			
			current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
			current_card.stamp.hide()
			current_card.card_frame.show()
			current_card.ball_text.hide()
			current_card.for_tuto.visible = true
			
			var tween = create_tween()
			tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		5:
			move_card(Vector2(198, 1000))
			await Utils.timer(0.7)
			current_card.queue_free()
			var des_summon = Vector2(198, 85)
			var paw_summon = Vector2(248, -114)
			
			current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
			current_card.stamp.hide()
			current_card.card_frame.show()
			current_card.ball_text.hide()
			current_card.card_frame.frame = 1
			current_card.bribe_chance = 0
			
			current_paw = Utils.spawn_scene(paw, parent, Vector2(198, -2000))
			current_paw.paws_water.show()
			current_paw.paws.hide()
			current_paw.paws_water.frame = 4			
			var tween = create_tween()
			var tween_paw = create_tween()
			tween_paw.tween_property(current_paw, "position", paw_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			SignalManager.call_card.emit()
func no_tutorial():
	SignalManager.AAAAAAANAOAGUENTOMAISSSSSSSSSSAS.connect(init_turn_from_upgrade)
	await Utils.timer(1.2)
	$CanvasLayer.hide()
	TransitionScene.play_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await Utils.timer(0.4)
	$Background.play()
	init_turn()
	SignalManager.dispause.connect(Utils.disable_cursor)
	
### SISTEMA DE TURNO
var turn_index: int
var turn_controler: int
var can_pass_turn: bool

func init_turn_from_upgrade():
	await Utils.timer(1.2)
	init_turn()
func _on_card_validated_correctly():
	combo_ui.add_combo()

# iniciar turno
func init_turn(qtd_provas = PlayerManager.cards_per_turno):
	err_pass = 0
	if PlayerManager.can_heal_end_turn:
		PlayerManager.heal(1)
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

	SignalManager.coinchange.emit(PlayerManager.coins_after_turno)
	current_upgrade_scene = Utils.spawn_scene(upgrade_scene, parent, Vector2(0, 0))

### SPAWNAR CARTA
func call_card():
	var des_summon = Vector2(198, 85)
	var paw_summon = Vector2(248, -114)
	
	current_card = Utils.spawn_scene(card_scene, parent, Vector2(198, -2000))
	if current_paw:
		current_paw.queue_free()
	
	if current_card.ball == false:
		current_paw = Utils.spawn_scene(paw, parent, Vector2(198, -2000))
	
	#CardManager.current_card = current_card
	
	
	var tween = create_tween()
	var tween_paw = create_tween()
	if current_paw:
		tween_paw.tween_property(current_paw, "position", paw_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(current_card, "position", des_summon, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	SignalManager.call_card.emit()

### AÇÔES DA CARTA
func reject():
	if err_pass < PlayerManager.error_ignored:
		err_pass += 1
		current_card.queue_free()
		can_pass_turn = true
		return
	PlayerManager.take_damage(1)
	current_card.queue_free()
	can_pass_turn = true

func accept():
	SignalManager.aceitar.emit() 
	coin_up()
	current_card.queue_free()
	can_pass_turn = true
	_on_card_validated_correctly()

func coin_up():
	SignalManager.coinchange.emit(current_card.coins)
	
func next_card():
	if current_card:
		current_card.queue_free()
		if current_paw:
			current_paw.queue_free()

### MOVIMENTO
func move_card(des):
	if pull == true:
		pull = false
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
			SignalManager.aceitar.emit()
			current_card.dragging = true
			await move_card(Vector2(1500, 85))
			if tuto == true:
				return
			if current_paw:
				await move_paw(Vector2(248, -1500))
			if accept_validate() == true:
				accept()
				return
			reject()

func _on_confiscate_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pull == true and current_card :
		if event.is_action_released("click"):
			SignalManager.confiscar.emit()
			current_card.dragging = true
			await move_card(Vector2(198, 1000))
			if tuto == true:
				return
			if current_paw:
				await move_paw(Vector2(248, -1500))
			if confiscate_validate() == true:
				accept()
				return
			reject()

### ACEITAR E CONFISCAR - MOUSE ENTERED
func _on_mouse_entered() -> void:
	if current_card:
		if current_card.dragging == true:
			pull = true
			return
		return
			
