extends Control

func _ready() -> void:
	GameManager.fade_in()
	AudioManager.ambience_sound.play()

func _on_apply_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sensitivity_menu.gd")
