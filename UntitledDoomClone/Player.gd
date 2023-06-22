extends CharacterBody3D

const camShake = 1
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var damage = 10
var originalCameraTransform = Transform3D()
const sway = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $pivot
@onready var camera := $pivot/camera
@onready var pistol = preload("res://scenes/guns/pistol.tscn")
@onready var uzi = preload("res://scenes/guns/Uzi.tscn")
@onready var shotgun = preload("res://scenes/guns/shotun.tscn")
@onready var animation = $AnimationPlayer
var play = true 
var current_gun = 0
@onready var carriedGuns = [pistol, uzi, shotgun]
@onready var gun = $pivot/gun



func reloadGame():
	if Input.is_action_pressed("reloadGame"):
		
		get_tree().reload_current_scene()
		PlayerStats.reset()
	
func _process(delta):
	if Input.is_action_just_pressed("nextGun"):
		current_gun+=1
		if current_gun > len(carriedGuns)-1:
			current_gun = 0
		changeGun(current_gun)
	elif Input.is_action_just_pressed("prevGun"):
		current_gun-=1
		if current_gun < 0:
			current_gun = len(carriedGuns)-1
		changeGun(current_gun)
		
	
func changeGun(gun):
	$pivot/gun.get_child(0).queue_free()
	var newGun = carriedGuns[gun].instantiate()
	$pivot/gun.add_child(newGun)
	PlayerStats.current_gun = newGun.name
func _ready():
	#hand.set_as_toplevel(true)
	
	originalCameraTransform = camera.transform
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event): 
	
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
			
	

func _physics_process(delta):
	#hand.global_transform.origin - handLoc.global_tranform.origin
	#fire()
	
	reloadGame()
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if PlayerStats.health>0:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("leftward", "rightward", "forward", "backward")
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)	
		move_and_slide()
		
	elif PlayerStats.health==0 and play == true:
		animation.play("death")
		$pivot/gun.queue_free()
		play = false
		


