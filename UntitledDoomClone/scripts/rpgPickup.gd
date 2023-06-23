extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("Player") :
		if PlayerStats.guns_carried.has(3) == false:
			PlayerStats.guns_carried.append(3)
			PlayerStats.changeWeapon = true
		else:
			PlayerStats.change_rocket_ammo(5)
		
		#Player.current_gun = 2
		queue_free()

