extends State

onready var _board = owner as Board

func enter():
	BoardSignals.connect("TilePressed", self, "_on_tile_pressed")
	
func handle_input(event):	
	if (event is InputEventMouseButton && event.pressed):
		var _mouse_pos = event.position
		var _coord = _board._tile_frame.world_to_map(_mouse_pos - _board.position) # adjust for positioning of board in main scene.
		var _tile = _board._tiles.get(_coord)
		BoardSignals.emit_signal("TilePressed", _tile)
		
func _on_tile_pressed(tile : TileBase):
	print ("Player input state is handling tile press.")
	if tile and tile.Selectable:
		if _board.is_tile_in_match(tile) and not tile.is_matched():
			_board.register_new_match_made(tile)
			
			# Immediate match mode.
			emit_signal("finished", "resolving_matches")
			
	else:
		pass # handle no match state
