extends CanvasLayer

@onready var armor = $MarginContainer/stats/values/armorValue
@onready var health = $MarginContainer/stats/values/healthValue
@onready var ammo = $MarginContainer/stats/ammo/ammoValue
var currentGun
func _ready():
	pass
	#ammo.text = PlayerStats.get_pistol_ammo()

func _process(delta):
	var currentGun = PlayerStats.current_gun
	ammo.text = PlayerStats.get_pistol_ammo()
	match currentGun:
		"pistol":
			ammo.text = PlayerStats.get_pistol_ammo()
		"uzi":
			ammo.text = PlayerStats.get_pistol_ammo()
		"shotgun":
			ammo.text = PlayerStats.get_shotgun_ammo()
		"rpg":
			ammo.text = PlayerStats.get_rocket_ammo()
	armor.text = PlayerStats.get_armor()
	health.text = PlayerStats.get_health()
	
	
		
