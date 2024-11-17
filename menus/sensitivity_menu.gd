extends Control

func _ready() -> void:
	GameManager.fade_in()

func _on_back_to_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings_menu.tscn")
	
