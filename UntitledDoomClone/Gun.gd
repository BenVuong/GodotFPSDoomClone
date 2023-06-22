extends Node3D

@onready var gun_sprite= $CanvasLayer/Control/gunsprite
@onready var gunRay = $ray.get_children()
@onready var flash = preload("res://scenes/muzzle_flash.tscn")
@onready var sound = $AudioStreamPlayer2D
@onready var spawnLocation = $Marker3D
@onready var rocket = preload("res://scenes/rocket.tscn")

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_sprite.play("idle")

func launchProjectile():
	var newRocket = rocket.instantiate()
	get_node("/root/level").add_child(newRocket)
	newRocket.global_transform = spawnLocation.global_transform

func check_hit(dmg):
	for ray in gunRay:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("enemies"):
				print("hit")
				print(ray.get_collider().name)
				ray.get_collider().takeDamage(dmg)
	
func make_flash():
	var f = flash.instantiate()
	add_child(f)
	
func _process(delta):
	#change structure into a match statement later
	if get_parent().get_child(0).name == "uzi":
		if Input.is_action_pressed("fire") and can_shoot and PlayerStats.ammo_pistol>0:
			sound.play()
			PlayerStats.change_pistol_ammo(-1)
			print(PlayerStats.get_pistol_ammo())
			gun_sprite.play("shoot")
			check_hit(2)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
	
	elif get_parent().get_child(0).name == "pistol":
		if Input.is_action_just_pressed("fire") and can_shoot and PlayerStats.ammo_pistol>0:
			sound.play()
			PlayerStats.change_pistol_ammo(-1)
			print(PlayerStats.get_pistol_ammo())
			gun_sprite.play("shoot")
			check_hit(5)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
	elif get_parent().get_child(0).name == "shotgun":
		if Input.is_action_just_pressed("fire") and can_shoot and PlayerStats.ammo_shells>0:
			sound.play()
			PlayerStats.change_shotgun_ammo(-1)
			print(PlayerStats.get_shotgun_ammo())
			gun_sprite.play("shoot")
			check_hit(10)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
	elif get_parent().get_child(0).name == "rpg":
		if Input.is_action_just_pressed("fire") and can_shoot:
			gun_sprite.play("shoot")
			launchProjectile()
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
		


func _on_timer_timeout():
	can_shoot = true
	
