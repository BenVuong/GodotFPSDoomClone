extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("Player") and PlayerStats.ammo_shells < PlayerStats.ammo_max_shells:
		PlayerStats.change_shotgun_ammo(10)
		if PlayerStats.guns_carried.has("shotgun") == false:
			PlayerStats.guns_carried.append("shotgun")
			PlayerStats.changeWeapon = true
		
		#Player.current_gun = 2
		queue_free()
