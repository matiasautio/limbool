extends Control

func _ready() -> void:
	GameManager.fade_in()
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")
