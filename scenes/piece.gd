extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_block_down():
	position.y -= 0.25
	if position.y == 0.5:
		pass
	else:
		$Timer.start()


func _on_timer_timeout():
	move_block_down()
