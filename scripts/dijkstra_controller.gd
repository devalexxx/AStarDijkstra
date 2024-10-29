extends "res://scripts/path_controller.gd"

@export
var target : Node2D

class DijkstraNode:
	var loc : Vector2i
	var p   : DijkstraNode
	var t   : float = 0
	
	func _init(loc: Vector2i, p: DijkstraNode):
		self.loc = loc
		self.p   = p

func _ready() -> void:
	var sloc = tilemap.local_to_map(position)
	var tloc = tilemap.local_to_map(target.position)
	
	var ilist : Array[DijkstraNode] = []
	var olist : Array[DijkstraNode] = []
	olist.append(DijkstraNode.new(sloc, null))
	
	while not olist.is_empty():
		olist.sort_custom(func(lhs, rhs): return lhs.t < rhs.t)
		
		var current = olist.pop_front()
		if current:
			ilist.append(current)
			
			if current.loc == tloc:
				_path = Utility.build_path(current)
				break
			
			for child in Utility.get_valid_neighbors(current.loc, tilemap):
				var i = Utility.array_find(ilist, func(elem): return elem.loc == child)
				var t = tilemap.get_cell_tile_data(child).get_custom_data("factor")
				if i >= 0:
					# update if faster
					if ilist[i].t > current.t + t:
						ilist[i].t = current.t + t
						ilist[i].p = current
				else:
					# add to olist
					i = Utility.array_find(olist, func(elem): return elem.loc == child)
					if i >= 0:
						if olist[i].t > current.t + t:
							olist[i].t = current.t + t
							olist[i].p = current
					else:
						var node = DijkstraNode.new(child, current)
						node.t = current.t + t
						olist.append(node)

func _process(delta: float) -> void:
	super._process(delta)
