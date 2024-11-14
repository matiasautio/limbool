extends Node3D

var start_basis = Basis.IDENTITY
var target_basis

var can_rot = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func turn_left():
	print(rotation_degrees)
	if can_rot:
		target_basis = Basis.IDENTITY.rotated(Vector3.UP, TAU / 4)
		can_rot = false
		var tween = create_tween()
		tween.tween_method(interpolate, 0.0, 1.0, 0.25).set_trans(Tween.TRANS_EXPO)
		tween.tween_callback(free_rot)


func turn_right():
	var tween = get_tree().create_tween()
	var new_rotation = global_rotation_degrees + Vector3(0,90,0)
	tween.tween_property(self, "global_rotation_degrees", new_rotation, 0.25)
	#global_rotation_degrees.y += 90


func interpolate(weight):
	basis = start_basis.slerp(target_basis, weight)


func free_rot():
	can_rot = true
	start_basis = target_basis
