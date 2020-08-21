extends State

onready var _board : Board = owner

func enter():
	print("Resolving matches!")
	
	BoardSignals.connect("TileCollected", self, "_tile_collected")	
	BoardSignals.emit_signal("TileResolveTriggered")
	
	# by this point all tiles should be removed. Lets find new spaces for the rest.
	_board.fill_board_empty_tiles()
	
	emit_signal("finished", "waiting_for_player")
	
func exit():
	BoardSignals.disconnect("TileCollected", self, "_tile_collected")	
	
func _tile_collected(tile):
	_board.remove_tile_from_board(tile)
