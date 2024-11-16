extends Node3D

@export var _name = "key"
@export var audio : AudioStreamOggVorbis
@export var textures : Array[CompressedTexture2D]


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.stream = audio
	if textures.size() > 0:
		var material = StandardMaterial3D.new()
		material.albedo_texture = textures.pick_random()
		$MeshPos.get_child(0).get_child(0).set_surface_override_material(0, material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_frob():
	$AudioStreamPlayer.play()


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		body.add_to_inventory(self)
