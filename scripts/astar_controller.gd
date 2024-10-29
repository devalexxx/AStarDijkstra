extends "res://scripts/path_controller.gd"

@export
var target : Node2D

class AStarNode:
	var loc : Vector2i
	var p   : AStarNode
	var f   : float = 0
	var g   : float = 0
	var h   : float = 0
	
	func _init(loc: Vector2i, p: AStarNode):
		self.loc = loc
		self.p   = p

func _ready() -> void:
	var sloc = tilemap.local_to_map(position)
	var tloc = tilemap.local_to_map(target.position)

	var clist : Array[AStarNode] = []
	var olist : Array[AStarNode] = []
	olist.append(AStarNode.new(sloc, null))
	
	while not olist.is_empty():
		olist.sort_custom(func(lhs, rhs): return lhs.f < rhs.f)
		var current = olist[0]
		var index   = 0
		
		olist.remove_at(index)
		clist.append(current)
		
		if current.loc == tloc:
			_path = Utility.build_path(current)
			break
			
		var children = Utility.get_valid_neighbors(current.loc, tilemap).reduce(func(acc, elem): return acc + [AStarNode.new(elem, current)], [])		
		for child in children:
			if Utility.array_find(clist, func(elem): return elem.loc == child.loc) == -1:
				child.g = current.g + 1.0 * tilemap.get_cell_tile_data(child.loc).get_custom_data("factor")
				child.h = child.loc.distance_to(tloc)
				child.f = child.g + child.h

				var m = Utility.array_find(olist, func(elem): return child.loc == elem.loc)
				if m >= 0:
					if child.g < olist[m].g:
						olist[m] = child
				else:
					olist.append(child)


func _process(delta: float) -> void:
	super._process(delta)
