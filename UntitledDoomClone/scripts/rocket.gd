extends Area3D
 
var speed = 10
var damage = 100
var splashDamage = 50
@onready var animation = $AnimatedSprite3D
@onready var animation2 = $AnimatedSprite3D2
@onready var sound = $AudioStreamPlayer3D
#@onready var camera = preload("res://player.tscn")
func dealDamage():
	var enemies = get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("enemies"):
			body.takeDamage(damage)
			
	enemies = $slpashDamage.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("enemies"):
			body.takeDamage(damage)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	animation2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#TODO: figure out how to shoot launch the rocket at an angle
func _process(delta):
	translate(Vector3.FORWARD* speed * delta)
	
	


func _on_body_entered(body):
	if body.is_in_group("Player"):
		return
	set_process(false)
	animation.visible = false
	animation2.visible = true
	animation2.play("explode")
	sound.play()
	dealDamage()
	set_deferred("monitoring", false)
	await $AnimatedSprite3D2.animation_finished
	animation2.visible = false
	await sound.finished
	#animation2.visible = false
	queue_free()


func _on_slpash_damage_body_entered(body):
	pass # Replace with function body.
