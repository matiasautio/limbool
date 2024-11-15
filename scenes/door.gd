extends Node3D

@export var opening_amount = 2
@export var key = "key"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func open(players_key):
	if players_key == key:
		var tween = create_tween()
		tween.tween_property(self, "position", position + Vector3(0, opening_amount, 0),1).set_trans(Tween.TRANS_SINE)
		return true
