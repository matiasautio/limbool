extends Camera3D

@export var lerp_speed = 3.0
@export var target: Node3D
@export var offset = Vector3.ZERO
@export var shaky_cam = false


func _ready():
	pass


func _physics_process(delta):
	if !target:
		return
	var target_pos = target.global_position + offset
	global_position = global_position.lerp(target_pos, lerp_speed * delta)
	global_position.x = offset.x
	#global_position.y = 3.65
	if shaky_cam:
		look_at(target.global_transform.origin, target.transform.basis.y)
