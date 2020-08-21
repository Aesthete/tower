extends Area2D

'''Core puzzle board class.'''

export var BoardSize :  Vector2 = Vector2(9,12)
export(PackedScene) var TilePrefab

onready var _tile_frame : TileMap  = $Guide
onready var _tile_root : Node = $InstancedTiles
onready var _states : StateMachine = $States

# keep a list of tiles by tilemap index.
var _tiles : Dictionary = Dictionary() # Vector2: Tile node.

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
	print(_tiles)
	
func _create_new_tile() -> Node:
	var _tile = TilePrefab.instance()
	_tile.init(randi() % TileUtil.TileType.size(), randi() % TileUtil.TileColor.size())
	return _tile
	
func _ready():
	_states.initialize(_states.START_STATE) # Do this when the entire tree is ready.

func _on_Board_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		var _coord = _tile_frame.world_to_map(event.position)
		var _tile = _tiles.get(_coord)
		print (_tile)
