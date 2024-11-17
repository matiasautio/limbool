extends Control

func _ready() -> void:
	pass
	#GameManager.fade_in()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/menu.tscn")

func _on_audio_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/audio_menu.tscn")

func _on_sensitivity_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/sensitivity_menu.tscn")

func _on_apply_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings_menu.tscn")
