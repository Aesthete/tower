extends State

onready var _board = owner as Board

func enter():
	BoardSignals.connect("TilePressed", self, "_on_tile_pressed")
		
func _on_tile_pressed(tile : TileBase):
	print ("Player input state is handling tile press.")
	if tile.Selectable:
		if _board.is_tile_in_match(tile) and not _board.is_tile_matched_already(tile):
			pass # DO EPIC MATCHING SHIT
	else:
		pass # handle no match state
