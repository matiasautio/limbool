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


# Called when the node enters the scene tree for the first time.
func _ready():
	for trigger in color_triggers:
		trigger.body_entered.connect(_on_change_water_color_trigger_body_entered.bind(trigger))
	current_water = water.get_surface_override_material(0).get_shader_parameter("out_color")
	old_color = current_water
	#_on_change_water_color_trigger_body_entered(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
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
