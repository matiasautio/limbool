extends Control

func _ready() -> void:
	GameManager.fade_in()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
