extends CharacterBody3D


@export var speed = 2.5
const JUMP_VELOCITY = 4.5
@export var acceleration = 0.25
@export var friction = 0.05

@export var current = false

@export var camera : Camera3D

# TODO: Changing directions is too instant to feel like floating

func _ready():
	Input.add_joy_mapping("030000000d0f0000ab01000095000000,HORIPAD STEAM,a:b0,b:b1,y:b4,x:b3,start:b11,back:b10,leftstick:b16,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:b12,dpleft:b14,dpdown:b13,dpright:b15,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:a5,righttrigger:a4,platform:Mac OS X")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if current:
		direction.z += -0.1
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)#direction.x * speed / 2
		velocity.z = move_toward(velocity.z, direction.z * speed, acceleration * delta) #direction.z * speed
		#if input_dir.x > 0:
		#	camera.offset.z = -1.5
		#elif input_dir.x < 0:
		#	camera.offset.z =  1.5
		#camera.lerp_speed = 2
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
		velocity.z = move_toward(velocity.z, 0, friction)
		#camera.lerp_speed = 1

	move_and_slide()
