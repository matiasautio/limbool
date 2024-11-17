extends Control

func _ready() -> void:
	$VBoxContainer/HSlider.value = AudioServer.get_bus_volume_db(0)
	$VBoxContainer/HSlider2.value = AudioServer.get_bus_volume_db(1)
	$VBoxContainer/HSlider3.value = AudioServer.get_bus_volume_db(2)


func _on_apply_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/settings_menu.tscn")

# Master
func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)

# SFX
func _on_h_slider_2_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)

# Music
func _on_h_slider_3_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
