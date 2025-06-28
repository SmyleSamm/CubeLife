extends CharacterBody3D

const SENSIVITY: float = 0.001
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const RUNNING = 10.0
@onready var animations: AnimationPlayer = $Animations
@onready var eyes: Camera3D = $Head/Eyes
@onready var spiritBack: Camera3D = $Head/SpiritBack
@onready var spiritFront: Camera3D = $Head/SpiritFront
@onready var head: CollisionShape3D = $Head

var camNum: int = 0
@export var maxCamNum: int = 2

func _ready() -> void:
	eyes.current = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		return
	handleMouseInputs(event)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeCam"):
		changeCam()
	if Input.is_action_just_pressed("esc"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_pressed("zoom"):
			eyes.fov = 30.0
			spiritBack.fov = 30.0
			spiritFront.fov = 30.0
	else:
		eyes.fov = 75.0
		spiritBack.fov = 75.0
		spiritFront.fov = 75.0

func changeCam() -> void:
	camNum += 1
	if camNum > maxCamNum: 
		camNum = 0
	if camNum == 0:
		eyes.current = true
		spiritBack.current = false
		spiritFront.current = false
	elif camNum == 1:
		eyes.current = false
		spiritBack.current = true
		spiritFront.current = false
	elif camNum == 2:
		eyes.current = false
		spiritBack.current = false
		spiritFront.current = true
	
	
func handleMouseInputs(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSIVITY)
		head.rotate_x(-event.relative.y * SENSIVITY)
		head.rotation.x = clamp(head.rotation.x, -1, 1)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	
	var run: float = int(Input.is_action_pressed("sprint")) * RUNNING
	run = 1 + run
	
	# Handle jump.
	if Input.is_action_pressed("jump"): #and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * run
	if direction:
		animations.play("walk")
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		animations.stop()
		velocity.x = 0
		velocity.z = 0
		velocity.y = 0

	move_and_slide()
