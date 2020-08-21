class_name BoardUtil

static func _get_matching_neighbors_recursive(node_coord : Vector2, node_map: Dictionary, matched : Array) -> Array:
	# left up right down
	var _directions = [node_coord + Vector2(-1,0), node_coord + Vector2(0,-1), node_coord + Vector2(1,0), node_coord + Vector2(0,1)]
	var _neighbors = []
	for dir in _directions:
		_neighbors.push_back(node_map[dir] if node_map.has(dir) else null)
	
	var _tile = node_map[node_coord] as TileBase
	var _tile_color = _tile.TileColor
	
	for i in _neighbors.size():
		var _coord = _directions[i]
		var _neighbor = _neighbors[i]
		if _neighbor and (_neighbor as TileBase).TileColor == _tile_color and not matched.has(_coord):
			matched.push_back(_coord)
			matched = _get_matching_neighbors_recursive(_coord, node_map, matched)
	return matched

# take a board state, find all the matches, return them as array of matches
static func find_matches(node_map : Dictionary, min_count : int = 3) -> Dictionary:
	var _matches = {}
	for _coord in node_map:
		_matches[_coord] = _get_matching_neighbors_recursive(_coord, node_map, [])
		
	return _matches
