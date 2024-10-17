extends Node2D

@export
var tile_map : TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for cell in tile_map.get_used_cells():
		print(tile_map.get_cell_tile_data(cell).get_custom_data("speed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
