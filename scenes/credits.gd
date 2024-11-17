extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if !AudioManager.ambience_sound.playing:
		AudioManager.ambience_sound.play()
	GameManager.fade_in()
	GameManager.in_menu = true
	GameManager.inventory.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	elif event.is_action_pressed("jump"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
