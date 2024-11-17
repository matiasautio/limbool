extends Control

signal closed


func _on_back_to_settings_pressed() -> void:
	emit_signal("closed")
	#get_tree().change_scene_to_file("res://menus/settings_menu.tscn")
	
