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
	var _erase = []
	for _match in _matches:
		if _matches[_match].size() < min_count: _erase.append(_match)
	for _e in _erase: _matches.erase(_e)
		
	return _matches

static func drop_tiles(node_map : Dictionary, board_size : Vector2) -> Dictionary:
		for x in range(board_size.x):
			for y in range(board_size.y - 2, -1, -1):
				var _coord = Vector2(x,y)
				var _tile = node_map.get(_coord)
				if not _tile: continue
				var _coord_below = Vector2(0, 1) + _coord
				while not node_map.get(_coord_below):
					if _coord_below.y >= board_size.y: break
					node_map[_coord_below] = _tile
					node_map.erase(_coord)
					_coord = _coord_below
					_coord_below = Vector2(0, 1) + _coord
		return node_map
