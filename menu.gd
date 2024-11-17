extends Control

func _ready() -> void:
	GameManager.fade_in()
	AudioManager.ambience_sound.play()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func _on_settings_pressed() -> void:
	$MarginContainer.hide()
	$Menu.show()
	#get_tree().change_scene_to_file("res://menus/settings_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func settings_closed():
	$MarginContainer.show()
	$Menu.hide()
