extends Area3D

#@export var is_increase = true
@export var key = "key"
@export var water_level_change = 1.0


func change_water_level(_key):
	if _key != key:
		return
	get_parent().change_water_level(water_level_change)
