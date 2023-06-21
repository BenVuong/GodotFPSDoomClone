extends CharacterBody3D


@onready var navAgent = $NavigationAgent3D
@onready var animation = $AnimatedSprite3D
@onready var animation2 = $AnimatedSprite3D2
@onready var eyes = $eyes
var shooting = false
var dead = false
var speed = 1
var health = 20
var isShot = false
var searching = false
var target

func _ready():
	animation2.visible = false
	
func death():
	print("I am dead")
	set_process(false)
	set_physics_process(false)
	$CollisionShape3D.disabled=true
	
	
	animation.visible = false
	animation2.visible = true
	animation2.play("die")
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
		dead = true
		death()
	

func updateTargetLocation(targetLocation):
	navAgent.set_target_position(targetLocation)
	target= targetLocation

func _physics_process(delta):
	if dead:
		return
	if isShot == false or (searching == true and not shooting):
		animation.play("walking")
		look_at(target,Vector3.UP)
		var currentLocation = global_transform.origin
		var nextLocation = navAgent.get_next_path_position()
		var newVel = (nextLocation-currentLocation) * speed
		velocity = newVel
		move_and_slide()
		
	else:
		animation.play("idle")
	

func shoot():
	if searching and not dead and not shooting:
		set_physics_process(false)
		shooting = true
		animation.play("shoot")
		await $AnimatedSprite3D.frame_changed
		if eyes.is_colliding():
			if eyes.get_collider().is_in_group("Player"):
				PlayerStats.change_health(-10)
		await $AnimatedSprite3D.animation_finished
		set_physics_process(true)
		shooting = false
		


func _on_ears_body_entered(body):
	if body.is_in_group("Player"):
		set_physics_process(false)
		searching = true


func _on_ears_body_exited(body):
	if body.is_in_group("Player"):
		set_physics_process(true)
		searching = false


func _on_shoot_timer_timeout():
	shoot() # Replace with function body.
