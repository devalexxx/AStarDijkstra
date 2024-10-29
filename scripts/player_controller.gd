extends "res://scripts/vehicule_controller.gd"

func _process(delta: float) -> void:
	if (!is_moving):
		_v = Input.get_axis("Forward", "Back")
		_h = Input.get_axis("Left", "Right")
	
	super._process(delta)
