extends State

onready var _board : Board = owner

func enter():
	print("Resolving matches!")
	
	BoardSignals.connect("TileCollected", self, "_tile_collected")	
	BoardSignals.emit_signal("TileResolveTriggered")
	
	# by this point all tiles should be removed. Lets find new spaces for the rest.
	_board.fill_board_empty_tiles()
	
func update(delta):			
	var _any_tiles_falling = false
	for _tile in _board._tiles.values():
		_any_tiles_falling = _tile.is_falling()
		if _any_tiles_falling: break;
	
	if not _any_tiles_falling:
		emit_signal("finished", "waiting_for_player")	
	
func exit():
	BoardSignals.disconnect("TileCollected", self, "_tile_collected")
	
func _tile_collected(tile):
	_board.remove_tile_from_board(tile)
