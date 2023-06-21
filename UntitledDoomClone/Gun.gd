extends Node3D

@onready var gun_sprite= $CanvasLayer/Control/gunsprite
@onready var gunRay = $ray.get_children()
@onready var flash = preload("res://scenes/muzzle_flash.tscn")
@onready var sound = $AudioStreamPlayer2D

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	gun_sprite.play("idle")

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
	if get_parent().get_child(0).name == "uzi":
		if Input.is_action_pressed("fire") and can_shoot:
			sound.play()
			gun_sprite.play("shoot")
			check_hit(2)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
	
	elif get_parent().get_child(0).name == "pistol":
		if Input.is_action_just_pressed("fire") and can_shoot:
			#sound.play()
			gun_sprite.play("shoot")
			check_hit(5)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
	elif get_parent().get_child(0).name == "shotgun":
		if Input.is_action_just_pressed("fire") and can_shoot:
			#sound.play()
			gun_sprite.play("shoot")
			check_hit(20)
			make_flash()
			can_shoot = false
			await $CanvasLayer/Control/gunsprite.animation_finished
			can_shoot = true
			gun_sprite.play("idle")
		


func _on_timer_timeout():
	can_shoot = true
	
