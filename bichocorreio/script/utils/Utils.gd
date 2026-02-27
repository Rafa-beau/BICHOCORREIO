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
