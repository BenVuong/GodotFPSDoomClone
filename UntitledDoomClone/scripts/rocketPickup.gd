extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("Player") and PlayerStats.ammo_rocket < PlayerStats.ammo_max_rocket :
		PlayerStats.change_rocket_ammo(10)
		queue_free()
