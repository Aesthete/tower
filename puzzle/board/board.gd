extends Area2D
class_name Board

'''Core puzzle board class.'''

export var BoardSize :  Vector2 = Vector2(9,12)
export(PackedScene) var TilePrefab

onready var _tile_frame : TileMap  = $Guide
onready var _tile_root : Node = $InstancedTiles
onready var _states : StateMachine = $States

# keep a list of tiles by tilemap index.
var _tiles : Dictionary = Dictionary() # Vector2: Tile node.
var _matches_possible : Dictionary = Dictionary()

# External
func register_new_match_made(tile : TileBase) -> void:
	tile.emit_signal("TileMatched")
	var _coord = get_tile_coord(tile)
	for _peer_coord in _matches_possible[_coord]:
		_tiles[_peer_coord].emit_signal("TileMatched");

func is_tile_in_match(tile: TileBase) -> bool:
	var _coord = get_tile_coord(tile)
	return _coord and _matches_possible.get(_coord, []).size()

# Internal.
func get_tile_coord(tile : TileBase):
	for x in _tiles:
		if _tiles[x] == tile: return x
	return null
	
func remove_tile_from_board(tile):
	var _coord = get_tile_coord(tile)
	_tiles.erase(_coord)
	
func _clear_board():
	for _tile in _tiles:
		pass # clear tiles here.

func build_board():
	_clear_board()
	for x in range(BoardSize.x):
		for y in range(BoardSize.y):
			var _coord = Vector2(x,y)
			var _cell = _tile_frame.map_to_world(_coord)
			_tile_frame.set_cell(x,y,-1)
			var _tile = _create_new_tile()
			_tile_root.add_child(_tile)
			_tile.position = _cell
			_tiles[_coord] = _tile
	_matches_possible = BoardUtil.find_matches(_tiles)
	while _matches_possible.empty(): shuffle_board()
	
func shuffle_board():
	print ("shuffling!")
	var _tile_objs = _tiles.values()
	_tile_objs.shuffle()
	var _idx = 0
	for _t in _tiles:
		_tiles[_t] = _tile_objs[_idx]
		_idx += 1		
	_matches_possible = BoardUtil.find_matches(_tiles)
	_reposition_tiles()
	
func _fill_empty_tiles():
	for x in range(BoardSize.x):
		for y in range(BoardSize.y):
			var _coord = Vector2(x,y)
			if _tiles.has(_coord) and _tiles[_coord]: continue
			var _cell = _tile_frame.map_to_world(_coord)
			var _tile = _create_new_tile()
			_tile_root.add_child(_tile)
			_tile.position = _cell
			_tiles[_coord] = _tile
	
func _reposition_tiles():
	for x in range(BoardSize.x):
		for y in range(BoardSize.y):
			var _coord = Vector2(x,y)
			if not _tiles.get(_coord): continue
			var _cell = _tile_frame.map_to_world(_coord)
			_tiles.get(_coord).position = _cell
	
func fill_board_empty_tiles():
		_tiles = BoardUtil.drop_tiles(_tiles, BoardSize)	
		_reposition_tiles()
		_fill_empty_tiles()
		_matches_possible = BoardUtil.find_matches(_tiles)
		if _matches_possible.empty():			
			while _matches_possible.empty(): shuffle_board()
	
func _create_new_tile() -> Node:
	var _tile = TilePrefab.instance()
	_tile.init(randi() % TileUtil.TileType.size(), randi() % TileUtil.TileColor.size())
	return _tile
	
func _ready():
	_states.initialize(_states.START_STATE) # Do this when the entire tree is ready.

func _on_Board_input_event(viewport, event, shape_idx):
	_states._input(event)
