extends Node2D

@export
var tilemap : TileMapLayer

var is_moving : bool
var start     : Vector2
var target    : Vector2
var elapsed   : float
var movetime  : float

func _ready() -> void:
	is_moving = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var h = Input.get_axis("Left", "Right")
	var v = Input.get_axis("Forward", "Back")
	
	if (is_moving):
		if (elapsed < movetime):
			elapsed += delta
			global_position = start.lerp(target, elapsed / movetime)
		else:
			is_moving = false
	elif h != 0 or v != 0:
		var cell   = tilemap.local_to_map(position)
		var factor = (tilemap.get_cell_tile_data(cell).get_custom_data("factor") as Dictionary)["Gray"]
		
		if h != 0 and v != 0:
			h = 0
		
		$Forward.visible = v < 0
		$Back   .visible = v > 0
		$Left   .visible = h < 0
		$Right  .visible = h > 0
		
		start     = global_position
		target    = global_position + Vector2(h * 16, v * 16);
		movetime  = 1.0 * factor
		elapsed   = 0.0
		is_moving = true;
