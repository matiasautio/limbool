extends Area3D

#@export var is_increase = true
@export var keys : Array[String]
@export var water_level_change = 1.0


func change_water_level(_key):
	if !keys.has(_key):
		return
	get_parent().change_water_level(water_level_change)
	$AnimationPlayer.play("rotate")
