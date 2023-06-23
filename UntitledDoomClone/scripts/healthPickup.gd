extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("Player") and PlayerStats.health < PlayerStats.max_health:
		PlayerStats.change_health(20)
		
		#Player.current_gun = 2
		queue_free()
