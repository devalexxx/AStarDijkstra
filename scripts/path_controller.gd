extends "res://scripts/vehicule_controller.gd"

var _path  : Array[Vector2i]

var _is_started : bool

func _ready() -> void:
	_is_started = false

func _process(delta: float) -> void:
	if _is_started:
		if not is_moving and not _path.is_empty():
			var current = tilemap.local_to_map(position)
			var dir     = _path.pop_back() - current
			_h = dir.x
			_v = dir.y
			
		super._process(delta)
	else:
		if Input.is_action_just_released("Play"):
			_is_started = true
