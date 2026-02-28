extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rich_text_label: RichTextLabel = $RichTextLabel
var is_pressed: bool
var msg_queue1: Array = [
	"Olá, eu sou a [wave]Fumiga Barito da Silva Felps II '-'",
	"Eu vim te ensinar como vc vai [wave]trabalhar comigo[/wave] nesse departamento!!",
	"Pra [wave]começar[/wave], você me [wave]controla[/wave] com o seu [color=green][wave]MOUSE[/wave][/color]",
	"Ao clicar com o [color=green][wave]BOTÃO ESQUERDO[/wave][/color] em cima do [wave]refil de tinta[/wave](Parte inferior direita), voce recarrega a [wave]tinta do carimbo",
	"[wave]Tente!!!"
]

var msg_queue2: Array = [
	"Muito bem!",
	"Use a tinta [color=green][wave]VERDE[/wave][/color] para provas de Animais Terrestres",
	"Use a tinta [color=dodger_blue][wave]AZUL[/wave][/color] para provas de Animais Marinhos",
	"Ao usar a o [color=green][wave]BOTÃO ESQUERDO[/wave][/color] na parte superior esquerda da carta você vai carimbar como [color=green][wave]APROVADO[/wave][/color], caso use o [color=green][wave]BOTÃO DIREITO[/wave][/color] ira carimbar como [color=red][wave]REPROVADO[/wave][/color]",
	"Ao arrastar a prova para a [color=green][wave]DIREITA[/wave][/color], você irá [color=green][wave]ACEITAR[/wave][/color] a prova",
	"Apenas [color=green][wave]APROVE[/wave][/color] e [color=green][wave]ACEITE[/wave][/color] se ela estiver correta",
	"Ao arrastar a prova para [color=green][wave]BAIXO[/wave][/color], você irá [color=red][wave]CONFISCAR[/wave][/color] a prova",
	"Apenas [color=red][wave]REPROVE[/wave][/color] e [color=red][wave]CONSFISQUE[/wave][/color] se ela estiver errada",
	"Tente carimbar a prova!"
]

var msg_queue3: Array = [
	"Boaaaa!!",
	"E só pra avisar, cada prova terá um tempo para você carimba-la e arrasta-la, se fizer corretamente e no tempo certo, irá ganha moedas que poderá trocar por upgrades no fim do turno! Caso erre, perde vida, e se sua vida acabar, sua partida se vai '-'",
	
	"Agora, sobre quais cartas voce deve reprovar!",
	"Caso a PROVA venha amassada, voce deve [color=red][shake]CONFISQUE-LA",
	"Caso a PROVA ja venha com um carimbo, a [color=red][shake]CONFISQUE",
	"Caso quem entregue a PROVA for um Tamanduá, carimbe como [color=red][wave]REJEITADO[/wave][/color], a mão dele e a prova, e a [color=red][shake]CONFISQUE[/shake][/color]. Não queremos correr riscos no trabalho :p",
	"Caso haja [color=yellow]SUBORNO[/color], irá aparecer moedas, você pode pegar essas moedas, porém deve [color=red][shake]CONFISCAR[/shake][/color] a prova",
	"Caso quem entregue a prova for um [color=web_green]JACARÉ[/color], carimbe como [color=red][wave]REJEITADO[/wave][/color], a mão dele e a prova, e a [color=red][shake]CONFISQUE"
]

var msg_queue4: Array = [
	"Ótimo! Aprendeu?",
	"Bom, quando um turno acaba, 3 Cartas de Habilidade irão aparecer, que podem ser [color=green]NORMAIS[/color], [color=dodger_blue][wave]INVERTIDAS[/wave][/color] e algumas [color=medium_orchid][wave]ENCANTADAS",
	"Cada uma delas te darão [color=green]HABILIDADES[/color] diferentes, e que, alguns podem ser somados infinitamente",
	"Podendo fazer sua partida ser um grande caos DIVERTIDASSO, como por exemplo ganhar [color=green]MOEDAS INFINITAS[/color]",
	"Cada uma delas tem um custo, ou você pode pular a compra",
	"Tente comprar ou pular!!"
]

var msg_queue5: Array = [
	"Parabénssssss!!!!",
	"Otimo, agora você aprendeu a [color=green]CARIMBAR[/color]",
	"AH...",
	"Quase ia me esquecendo",
	"Se vc apertar [color=green]ESC[/color], o jogo pausa :p",
	"Bom, boa sorte e cuidado com os tamanduas!!!"
]

var kk = 0
var step = 1
@onready var timer: Timer = $Timer

var in_tuto = false

func _ready() -> void:
	hide()
	show_message_step1()
	
	SignalManager.stamp_pick.connect(change_step)
	SignalManager.stamp_pick.connect(show_message_step2)
	SignalManager.step2_finish.connect(change_step)
	SignalManager.step2_finish.connect(show_message_step3)
	SignalManager.upgrade_clicked.connect(change_step)
	SignalManager.upgrade_clicked.connect(show_message_step5)
func resetk():
	kk = 0

func change_step(c:=):
	resetk()
	step += 1
	in_tuto = false
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action("ui_accept") and not is_pressed and in_tuto == false:
		match step:
			1:
				show_message_step1()
				is_pressed = true
			2:
				show_message_step2(1)
				is_pressed = true
			3:
				show_message_step3()
				is_pressed = true
			4:
				show_message_step4()
				is_pressed = true
			5:
				show_message_step5(1)
				is_pressed = true
		

func show_message_step1():
	
	if msg_queue1.size() == 0:
		animation_player.play("tchau")
		$"../Panel".visible = false
		in_tuto = true
		
		return
		
	var  _msg: String = msg_queue1.pop_front()
	
	rich_text_label.visible_characters = 0
	rich_text_label.text = _msg
	timer.start()
	if kk < 1:
		show()
		animation_player.play("oi")
		kk = 1
	if not timer.is_stopped():
			rich_text_label.visible_characters = rich_text_label.text.length()
			return
		

func show_message_step2(c):
	if step == 2:
		$"../Panel".visible = true
		if msg_queue2.size() == 0:
			animation_player.play("tchau")
			$"../Panel".visible = false
			SignalManager.step2.emit()
			in_tuto = true
			return
		var  _msg: String = msg_queue2.pop_front()
		
		rich_text_label.visible_characters = 0
		rich_text_label.text = _msg
		timer.start()
		if kk < 1:
			show()
			animation_player.play("oi")
			kk = 1
		if not timer.is_stopped():
				rich_text_label.visible_characters = rich_text_label.text.length()
				return
			
func show_message_step3():
	$"../Panel".visible = true
	if step == 3:
		if msg_queue3.size() == 0:
			SignalManager.step3.emit(0)
			change_step(1)
			show_message_step4()
			in_tuto = false
			
			return
			
		var  _msg: String = msg_queue3.pop_front()
		
		match msg_queue3.size():
			4:
				SignalManager.step3.emit(1)
			3:
				SignalManager.step3.emit(2)
			2:
				SignalManager.step3.emit(3)
			1:
				SignalManager.step3.emit(4)
			0:
				SignalManager.step3.emit(5)
		
		rich_text_label.visible_characters = 0
		rich_text_label.text = _msg
		timer.start()
		if kk < 1:
			show()
			animation_player.play("oi")
			kk = 1
		if not timer.is_stopped():
				rich_text_label.visible_characters = rich_text_label.text.length()
				return

func show_message_step4():
	$"../Panel".visible = true
	if step == 4:
		if msg_queue4.size() == 0:
			animation_player.play("tchau")
			$"../Panel".visible = false
			SignalManager.coinchange.emit(30)
			in_tuto = true
			
			return
			
		var  _msg: String = msg_queue4.pop_front()
		if msg_queue4.size() == 4:
			SignalManager.step4.emit()
		rich_text_label.visible_characters = 0
		rich_text_label.text = _msg
		timer.start()
		if kk < 1:
			show()
			animation_player.play("oi")
			kk = 1
		if not timer.is_stopped():
				rich_text_label.visible_characters = rich_text_label.text.length()
				return
		
func show_message_step5(c:=):
	$"../Panel".visible = true
	if msg_queue5.size() == 0:
		animation_player.play("tchau")
		TransitionScene.play_in()
		await Utils.timer(1.5)
		get_tree().change_scene_to_file("res://node/menu/menu.tscn")

		return
		
	var  _msg: String = msg_queue5.pop_front()
	
	rich_text_label.visible_characters = 0
	rich_text_label.text = _msg
	timer.start()
	if kk < 1:
		show()
		animation_player.play("oi")
		kk = 1
	if not timer.is_stopped():
			rich_text_label.visible_characters = rich_text_label.text.length()
			return
	


func _on_timer_timeout() -> void:
	if rich_text_label.visible_characters == rich_text_label.text.length():
		timer.stop()
		await Utils.timer(1)
		is_pressed = false
		
	rich_text_label.visible_ratio += 0.1
