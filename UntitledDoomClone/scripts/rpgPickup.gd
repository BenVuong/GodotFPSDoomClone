extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("Player") and PlayerStats.ammo_rocket < PlayerStats.ammo_max_rocket :
		PlayerStats.change_rocket_ammo(5)
		if PlayerStats.guns_carried.has("rpg") == false:
			PlayerStats.guns_carried.append("rpg")
			PlayerStats.changeWeapon = true
			
		
		#Player.current_gun = 2
		queue_free()

