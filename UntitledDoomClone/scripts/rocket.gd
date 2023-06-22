extends Area3D
 
var speed = 10
var damage = 100
var splashDamage = 50

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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector3.FORWARD * speed * delta)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		return
	set_process(false)
	$AnimatedSprite3D.play("explode")
	dealDamage()
	await $AnimatedSprite3D.animation_finished
	queue_free()


func _on_slpash_damage_body_entered(body):
	pass # Replace with function body.
