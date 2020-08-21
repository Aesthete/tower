extends State

onready var _board = owner as Board

func enter():
	BoardSignals.connect("TilePressed", self, "_on_tile_pressed")
		
func _on_tile_pressed(tile : TileBase):
	print ("Player input state is handling tile press.")
	if tile and tile.Selectable:
		if _board.is_tile_in_match(tile) and not tile.is_matched():
			_board.register_new_match_made(tile)
	else:
		pass # handle no match state
