extends CharacterBody3D

const LERP_VALUE : float = 0.15

var snap_vector : Vector3 = Vector3.DOWN
var speed : float

@export_group("Movement variables")
@export var walk_speed : float = 2.0
@export var run_speed : float = 5.0
@export var jump_strength : float = 15.0
@export var gravity : float = 50.0
@export var acceleration = 0.25
@export var friction = 0.05

var jump_impulse = false

const ANIMATION_BLEND : float = 7.0

@onready var player_mesh : Node3D = $Mesh
@onready var spring_arm_pivot : Node3D = $SpringArmPivot
@onready var animator : AnimationTree = $AnimationTree

@export var inventory : Control

@export var textures : Array[CompressedTexture2D]
var alien_texture = preload("res://2d art/Alien_humanoid.png")

var door = null
var valve = null

var has_collided_with_wall = false
var is_moving = false

@export var can_play = true

var gameplay = null


func _ready():
	if GameManager.player_texture == null:
		var material = StandardMaterial3D.new()
		var picked_texture
		if randi_range(0, 10) > 9:
			picked_texture = alien_texture
		else:
			picked_texture = textures.pick_random()
		material.albedo_texture = picked_texture
		$Mesh/humanoid/MESH_Base.set_surface_override_material(0, material)
		GameManager.player_texture = picked_texture
	else:
		var material = StandardMaterial3D.new()
		material.albedo_texture = GameManager.player_texture
		$Mesh/humanoid/MESH_Base.set_surface_override_material(0, material)
	$SpringArmPivot.can_play = can_play
	#Input.add_joy_mapping("030000000d0f0000ab01000095000000,HORIPAD STEAM,a:b0,b:b1,y:b4,x:b3,start:b11,back:b10,leftstick:b16,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:b12,dpleft:b14,dpdown:b13,dpright:b15,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a5,righttrigger:a4,platform:Mac OS X")


func _physics_process(delta):
	if !can_play:
		return
	var move_direction : Vector3 = Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	move_direction = move_direction.rotated(Vector3.UP, spring_arm_pivot.rotation.y)
	
	velocity.y -= gravity * delta
	
	speed = walk_speed
	if move_direction:
		velocity.x = move_toward(velocity.x, move_direction.x * speed, acceleration * delta)
		#move_direction.x * speed
		velocity.z = move_toward(velocity.z, move_direction.z * speed, acceleration * delta)
		#move_direction.z * speed
		player_mesh.rotation.y = lerp_angle(player_mesh.rotation.y, atan2(velocity.x, velocity.z), LERP_VALUE)
		
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)

	if move_direction != Vector3.ZERO:
		if not is_moving:
			AudioManager.water_splash.play()
			is_moving = true
	else:
		if is_moving:
			AudioManager.water_splash.stop()
			is_moving = false
	var just_landed := is_on_floor() and snap_vector == Vector3.ZERO
	var using_item = Input.is_action_just_pressed("jump")
	if using_item:
		if inventory.get_current_item() != null:
			inventory.get_current_item().on_frob()
		if door != null:
			door.open(inventory.get_current_item_name())
		if valve != null:
			valve.change_water_level(inventory.get_current_item_name())
				#inventory.get_current_item().on_frob()
				#inventory.remove_from_inventory(inventory.get_current_item())
	if jump_impulse:
		jump_impulse = false
		velocity.y = jump_strength
		snap_vector = Vector3.ZERO
	elif just_landed:
		snap_vector = Vector3.DOWN
	
	apply_floor_snap()
	move_and_slide()
	animate(delta)


func animate(delta):
	if is_on_floor():
		animator.set("parameters/ground_air_transition/transition_request", "grounded")
		
		if velocity.length() > 0:
			if speed == run_speed:
				animator.set("parameters/iwr_blend/blend_amount", lerp(animator.get("parameters/iwr_blend/blend_amount"), 1.0, delta * ANIMATION_BLEND))
			else:
				animator.set("parameters/iwr_blend/blend_amount", lerp(animator.get("parameters/iwr_blend/blend_amount"), 0.0, delta * ANIMATION_BLEND))
		else:
			animator.set("parameters/iwr_blend/blend_amount", lerp(animator.get("parameters/iwr_blend/blend_amount"), -1.0, delta * ANIMATION_BLEND))
	else:
		animator.set("parameters/ground_air_transition/transition_request", "air")


func add_to_inventory(item):
	inventory.add_to_inventory(item)
	AudioManager.generic_pick_up.play()
	if gameplay.level == 0:
		$How2UI/use_item.show()
		$UIAnimation.play("display_hint")
	elif gameplay.level == 1:
		$How2UI/change_items.show()
		$UIAnimation.play("display_hint")


func _on_sensor_area_entered(area):
	if area.get_parent().has_method("open"):
		door = area.get_parent()
	elif area.has_method("change_water_level"):
		valve = area


func _on_sensor_area_exited(area):
	if area.get_parent() == door:
		door = null
	elif area == valve:
		valve = null


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("wall") and not has_collided_with_wall:
		AudioManager.donut_impact.play()
		print("Player collided with the wall")
		has_collided_with_wall = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("wall") and has_collided_with_wall:
		print("Player exited the wall")
		has_collided_with_wall = false


func jump():
	if !jump_impulse:
		jump_impulse = true
