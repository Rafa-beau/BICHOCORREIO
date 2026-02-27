extends Control

var vg
var vm
var vsfx
var vsy
var full


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_options()
	visible = false # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_options():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	vm = config.get_value("audio", "volume_music", 0.5)
	vsfx = config.get_value("audio", "volume_sfx", 0.5)
	vg = config.get_value("audio", "volume_geral", 0.5)
	vsy = config.get_value("video", "vsync", true)
	full = config.get_value("video", "fullscren", true)
	
	$Vsync/CheckButton.button_pressed = vsy
	$"Tela Cheia/CheckButton".button_pressed = full
	$"Volume Geral/HSlider6".value = vg
	$Musica/HSlider5.value = vm
	$Sfx/HSlider3.value = vsfx

func save_options(volume_geral, volume_music, volume_sfx, vsync: bool, fullscrean: bool):
	var config = ConfigFile.new()
	config.set_value("audio", "volume_music", volume_music)
	config.set_value("audio", "volume_sfx", volume_sfx)
	config.set_value("audio", "volume_geral", volume_geral)
	config.set_value("video", "vsync", vsync)
	config.set_value("video", "fullscren", fullscrean)
	
	
	config.save("user://settings.cfg")
	Utils.load_options()


	

func _on_mouse_entered(extra_arg_0: int = -1) -> void:
	$Hover.play()
	if extra_arg_0 == 0:
		$voltar/Voltar.add_theme_color_override("default_color", Color("#fff"))



func _on_mouse_exited() -> void:
	$voltar/Voltar.add_theme_color_override("default_color", Color("#390005"))



func _on_voltar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			$".".visible = false
			
			save_options(vg,vm,vsfx,vsy,full)
			$Click.play()
			

func _on_value_changed(value: float, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			vg = value
			AudioServer.set_bus_volume_db(0, linear_to_db(vg))
			
		1:
			vm = value
			AudioServer.set_bus_volume_db(1, linear_to_db(vm))
			
		2:
			vsfx = value
			AudioServer.set_bus_volume_db(2, linear_to_db(vsfx))
			


func _on_check_button_toggled(toggled_on: bool, extra_arg_0: int) -> void:
	match extra_arg_0:
		0:
			if toggled_on:
				vsy = true
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
				$Click.play()
				return
			vsy = false
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			$Click.play()
		1:
			if toggled_on:
				full = true
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				$Click.play()
				return
			full = false
			$Click.play()
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
