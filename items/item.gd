extends Node3D

@export var _name = "key"
@export var audio : AudioStreamOggVorbis


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.stream = audio


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_frob():
	$AudioStreamPlayer.play()


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		body.add_to_inventory(self)
