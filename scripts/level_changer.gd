extends Node3D

@export var scene_to_change_to : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		GameManager.fade_out()
		await get_tree().create_timer(2).timeout
		#get_tree().call_deferred("reload_current_scene")
		get_tree().change_scene_to_packed(scene_to_change_to)
