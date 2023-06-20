extends CharacterBody3D


@onready var navAgent = $NavigationAgent3D
var speed = 1
func updateTargetLocation(targetLocation):
	navAgent.set_target_position(targetLocation)

func _physics_process(delta):
	var currentLocation = global_transform.origin
	var nextLocation = navAgent.get_next_path_position()
	var newVel = (nextLocation-currentLocation) * speed
	velocity = newVel
	move_and_slide()
