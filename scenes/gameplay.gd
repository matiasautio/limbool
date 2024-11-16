extends Node3D

@export var color_triggers : Array[Area3D]
var old_color : Color
var new_color # We get this from the trigger
# Used in lerping
var current_water : Color
var new_water = Color("ffffff")
var lerp_water = false
var change = 0
@export var water : Node3D

var water_tween
@export var water_level_change = 0.25
@export var water_level_threshold = 2

@export var spin_water = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if !AudioManager.ambience_sound.playing:
		AudioManager.ambience_sound.play()
	GameManager.fade_in()
	for trigger in color_triggers:
		trigger.body_entered.connect(_on_change_water_color_trigger_body_entered.bind(trigger))
	current_water = water.get_surface_override_material(0).get_shader_parameter("out_color")
	old_color = current_water
	$Player.inventory = GameManager.inventory
	#_on_change_water_color_trigger_body_entered(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("jump"):
		#change_water_level(water_level_change)
		#water_level_change += 0.25
	if lerp_water:
		change += 0.5 * delta
		if change < 1:
			new_water = current_water.lerp(new_color, change)
			water.get_surface_override_material(0).set_shader_parameter("out_color", new_water)
		else:
			#print("water lerp done")
			lerp_water = false
			change = 0
			current_water = new_water
			new_water = Color("ffffff")


func _on_change_water_color_trigger_body_entered(body, area):
	if body.name == "Player":
		new_color = area.color
		area.color = old_color
		old_color = new_color
		lerp_water = true


func change_water_level(amount):
	var new_water_pos = $Water.position + Vector3(0, amount, 0)
	water_tween = create_tween()
	water_tween.tween_property($Water, "position", new_water_pos, 8).set_trans(Tween.TRANS_QUAD)
	if spin_water:
		var new_water_rotation = $Water.rotation_degrees + Vector3(0,180,0)
		var spin_tweem = create_tween()
		spin_tweem.tween_property($Water, "rotation_degrees", new_water_rotation, 8).set_trans(Tween.TRANS_QUAD)
	#water_level_change += 0.25
	#water_tween.play()
