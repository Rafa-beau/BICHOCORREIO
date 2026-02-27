extends Node

func spawn_scene(scene: PackedScene, parent, pos:=):
	var instance = scene.instantiate()
	parent.add_child(instance)
	if pos is Vector2:
		instance.global_position = pos
	return instance

func set_cursor(img_path:String):
	Input.set_custom_mouse_cursor(load(img_path))

func disable_cursor():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		
func enable_cursor():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_HIDDEN:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func timer(sec: float):
	await get_tree().create_timer(sec).timeout
	

func load_options():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var volume_m = config.get_value("audio", "volume_music", 0.5)
	var volume_sfx = config.get_value("audio", "volume_sfx", 0.5)
	var volume_geral = config.get_value("audio", "volume_geral", 0.5)
	var vsync = config.get_value("video", "vsync", true)
	var fullscrenn = config.get_value("video", "fullscren", true)
	print(fullscrenn)
	#Fullscrenn
	if fullscrenn == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	if vsync == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
	AudioServer.set_bus_volume_db(0, linear_to_db(volume_geral))
	AudioServer.set_bus_volume_db(1, linear_to_db(volume_m))
	AudioServer.set_bus_volume_db(2, linear_to_db(volume_sfx))
	print(AudioServer.get_bus_name(0))
