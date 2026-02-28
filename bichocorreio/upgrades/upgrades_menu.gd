extends Control

@export var animation_fly: AnimationPlayer
@export var desc_upgrade_scene: PackedScene
@export var card_upgrades: Array[Control]
@onready var spawn: AnimationPlayer = $Spawn
@onready var spawn_2: AnimationPlayer = $Spawn2

var current_text: Node

var parent = self

var index: Array = range(9)
func _ready() -> void:
	print(card_upgrades)
	index.shuffle()
	for i in range(3):
		card_upgrades[i]._upgrade_index = index[i]
	
	print(card_upgrades)
	SignalManager.upgrade_clicked.connect(pause_fly)
	SignalManager.upgrade_clicked.connect(move_card_purchased)
	SignalManager.upgrade_hovered.connect(call_desc)
	SignalManager.upgrade_dishovered.connect(free_text)
	TransitionScene.play_in()
	await Utils.timer(1.2849)
	Utils.enable_cursor()
	
	
func pause_fly(i):
	animation_fly.pause()
	
func free_text():
	if current_text:
		current_text.queue_free()
	
func call_desc(title: String, desc: String, coins):
	current_text = Utils.spawn_scene(desc_upgrade_scene, parent, false)
	current_text.set_text(title, desc, coins)
	
func tween_center(card: Control):
	var center = Vector2(450.0, 95.0)
	var tween = create_tween()
	tween.tween_property(card, "position", center, 1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.play()
func move_card_purchased(upgrade_index := -1):
	for i in range(3):
		if upgrade_index > -1:
			if 	card_upgrades[i].upgrade_index == upgrade_index:
				Utils.disable_cursor()
				await Utils.timer(0.7)
				tween_center(card_upgrades[i])
				await Utils.timer(1)
				spawn.play("Spawn",true)
				spawn_2.play("oi moanoite",true)
				current_text.anim.play("out")
				await Utils.timer(1)
				TransitionScene.play_out()
				SignalManager.AAAAAAANAOAGUENTOMAISSSSSSSSSSAS.emit()
				queue_free()
	
	



func _on_sim_focus_entered() -> void:
	$Hover.play()


func _on_sim_pressed() -> void:
	Utils.disable_cursor()
	$Click.play()
	$Card_Upgrade_Layer/sim.hide()
	$Card_Upgrade_Layer/Card_Upgrades.hide()
	await Utils.timer(1)
	TransitionScene.play_out()
	SignalManager.AAAAAAANAOAGUENTOMAISSSSSSSSSSAS.emit()
	SignalManager.step5.emit()
	queue_free()
	
