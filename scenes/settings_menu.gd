extends Control

func _ready() -> void:
	GameManager.fade_in()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://audio_menu/.tscn")

func _on_sensitivity_pressed() -> void:
	get_tree().change_scene_to_file("res://sensitivity_menu./.tscn")


func _on_apply_pressed() -> void:
	get_tree().change_scene_to_file("res://settings_menu./.tscn")
