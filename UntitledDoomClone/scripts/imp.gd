extends CharacterBody3D


@onready var navAgent = $NavigationAgent3D
@onready var animation = $AnimatedSprite3D
@onready var animation2 = $AnimatedSprite3D2
@onready var eyes = $eyes
@onready var timer = $shootTimer
@onready var rocket = preload("res://scenes/impFireBall.tscn")
@onready var spawnLocation = $Marker3D
@onready var deathSound = $AudioStreamPlayer3D
var shooting = false
var dead = false
var speed = 1
var startingHealth = 50
var health = 50
var isShot = false
var searching = false
var target
var damage = 5
var rng = RandomNumberGenerator.new()
var painChance = 50

func launchProjectile():
	var newRocket = rocket.instantiate()
	get_node("/root/level").add_child(newRocket)
	newRocket.global_transform = spawnLocation.global_transform

func _ready():
	animation2.visible = false
	var my_random_number = rng.randf_range(0.5, 2.0)
	timer.set_wait_time(my_random_number)
	
func death():
	print("I am dead")
	set_process(false)
	set_physics_process(false)
	$CollisionShape3D.disabled=true
	
	
	animation.visible = false
	animation2.visible = true
	if health>=-startingHealth:
		animation2.play("die")
		deathSound.play()
	else:
		animation2.play("explode")
		deathSound.play()
		

func takeDamage(dmg):
	#var painNum = rng.randf_range(0, 100)
	print("I have been shot")
	health -= dmg
	#if painNum>=painChance:
	animation.play("hit")
		
		
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
	
	if eyes.is_colliding():
			if eyes.get_collider().is_in_group("Player"):
				searching = true
	look_at(target,Vector3.UP)
	if  (searching == true and not shooting):
		animation.play("walking")
		
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
		#searching = false
		shooting = true
		animation.play("shoot")
		await $AnimatedSprite3D.frame_changed
		#if eyes.is_colliding():
		#	if eyes.get_collider().is_in_group("Player"):
		#		PlayerStats.change_health(-damage)
		
		launchProjectile()
		
		await $AnimatedSprite3D.animation_finished
		set_physics_process(true)
		shooting = false
		#searching = false
	#elif shooting:
		
		


func _on_ears_body_entered(body):
	if body.is_in_group("Player"):
		set_physics_process(true)
		searching = true


func _on_ears_body_exited(body):
	if body.is_in_group("Player"):
		set_physics_process(false)
		searching = false


func _on_shoot_timer_timeout():
	shoot()
	var my_random_number = rng.randf_range(0.5, 2.0)
	timer.set_wait_time(my_random_number)
