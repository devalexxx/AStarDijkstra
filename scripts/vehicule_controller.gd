extends Node2D

@export
var tilemap : TileMapLayer

@export
var speed   : float

var is_moving : bool

var _h : float
var _v : float
var _start  : Vector2
var _target : Vector2
var _elapsed   : float
var _movetime  : float

func _ready() -> void:
	is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if (is_moving):
		if (_elapsed < _movetime):
			_elapsed += delta
			global_position = _start.lerp(_target, _elapsed / _movetime)
		else:
			is_moving = false
	elif _h != 0 or _v != 0:
		var cell   = tilemap.local_to_map(position)
		var factor = tilemap.get_cell_tile_data(cell).get_custom_data("factor")
		
		if _h != 0 and _v != 0:
			_h = 0
		
		$Forward.visible = _v < 0
		$Back   .visible = _v > 0
		$Left   .visible = _h < 0
		$Right  .visible = _h > 0
		
		_start     = global_position
		_target    = global_position + Vector2(_h * 16, _v * 16);
		_movetime  = (1.0 / speed) * factor 
		_elapsed   = 0.0
		is_moving = true;
