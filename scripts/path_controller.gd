extends "res://scripts/vehicule_controller.gd"

var _path  : Array[Vector2i]

func _process(delta: float) -> void:
	if not is_moving and not _path.is_empty():
		var current = tilemap.local_to_map(position)
		var dir     = _path.pop_back() - current
		_h = dir.x
		_v = dir.y
		
	super._process(delta)
