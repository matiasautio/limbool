extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
		
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
	
func _on_resume_pressed() -> void:
	resume()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()
	
func _on_settings_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://menus/settings_menu.gd")

func _on_quit_to_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://menus/menu.tscn")
	
func _process(delta):
	testEsc()
