extends CanvasLayer

@onready var armor = $MarginContainer/stats/values/armorValue
@onready var health = $MarginContainer/stats/values/healthValue
@onready var ammo = $MarginContainer/stats/ammo/ammoValue

func _process(delta):
	var currentGun = PlayerStats.current_gun
	armor.text = PlayerStats.get_armor()
	health.text = PlayerStats.get_health()
	
	if currentGun == "pistol" or currentGun == "uzi":
		ammo.text = PlayerStats.get_pistol_ammo()
	elif currentGun == "shotgun":
		ammo.text = PlayerStats.get_shotgun_ammo()
		
