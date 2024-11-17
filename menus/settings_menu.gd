extends Control

signal closed


func _on_back_pressed() -> void:
	emit_signal("closed")
	#get_tree().change_scene_to_file("res://menus/menu.tscn")

func _on_audio_pressed() -> void:
	$MarginContainer.hide()
	$"Audio menu".show()
	#get_tree().change_scene_to_file("res://menus/audio_menu.tscn")

func _on_sensitivity_pressed() -> void:
	$MarginContainer.hide()
	$"Sensitivity menu".show()
	#get_tree().change_scene_to_file("res://menus/sensitivity_menu.tscn")

func _on_apply_pressed() -> void:
	emit_signal("closed")
	#get_tree().change_scene_to_file("res://menus/settings_menu.tscn")


func sub_menus_closed():
	$MarginContainer.show()
	$"Sensitivity menu".hide()
	$"Audio menu".hide()
