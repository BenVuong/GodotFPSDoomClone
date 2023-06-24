extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(open):
	get_node("Timer").start()
	
	



func _on_timer_timeout():
	
	get_node("StaticBody3D/AnimationPlayer").play("close")
	await $StaticBody3D/AnimationPlayer.animation_finished
	get_node("Timer").stop()

