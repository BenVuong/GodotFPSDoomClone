extends Node3D


func _input(event: InputEvent):
	if (event.is_action_pressed("ui_cancel")):
		var currentVal : bool = get_tree().paused
		get_tree().paused = !currentVal
