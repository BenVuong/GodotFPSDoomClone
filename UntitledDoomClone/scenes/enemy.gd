extends CharacterBody3D


@onready var navAgent = $NavigationAgent3D
@onready var animation = $AnimatedSprite3D
var speed = 1
var health = 20
var isShot = false

func _ready():
	pass
	
func death():
	print("I am dead")
	set_process(false)
	set_physics_process(false)
	$CollisionShape3D.disabled=true
	animation.play("die")
func takeDamage(dmg):
	print("I have been shot")
	animation.play("hit")
	health -= dmg
	
	isShot = true
	#set_process(false)
	set_physics_process(false)
	await $AnimatedSprite3D.animation_finished
	isShot = false
	#set_process(true)
	set_physics_process(true)
	
	if health <=0:
		death()
	

func updateTargetLocation(targetLocation):
	navAgent.set_target_position(targetLocation)

func _physics_process(delta):
	if isShot == false:
		animation.play("walking")
		var currentLocation = global_transform.origin
		var nextLocation = navAgent.get_next_path_position()
		var newVel = (nextLocation-currentLocation) * speed
		velocity = newVel
	move_and_slide()
