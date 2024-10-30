extends Node

func array_find(array: Array, callabe: Callable) -> int:
	for index in array.size():
		if callabe.call(array[index]):
			return index
	return -1
	
func build_path(root) -> Array[Vector2i]:
	var path : Array[Vector2i] = []
	var cursor = root
	while cursor != null:
		path.append(cursor.loc)
		cursor = cursor.p
	return path
	
func get_valid_neighbors(loc: Vector2i, tilemap: TileMapLayer, obstacles: TileMapLayer) -> Array[Vector2i]:
	var children : Array[Vector2i] = []
	for side in [0, 4, 8, 12]:
		var cell = tilemap.get_neighbor_cell(loc, side)
		var data = tilemap.get_cell_tile_data(cell)
		
		# Skip if there is no cell
		if data:
			if not obstacles.get_cell_tile_data(cell):
				children.append(cell)
			
	return children
