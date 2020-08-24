extends State

onready var _board = owner as Board

var _matches_made_this_turn : Dictionary
var _turn_tracker : int = 0

func enter():		
	_turn_tracker += 1
	BoardSignals.connect("TilePressed", self, "_on_tile_pressed")
	BoardSignals.connect("TurnTimerExpired", self, "_on_turn_timer_expired")
	BoardSignals.connect("TileMatched", self, "_on_match_made")
	
func _on_turn_timer_expired():
	GameState.set_matches_made(_turn_tracker, _matches_made_this_turn)
	_matches_made_this_turn.clear()
	emit_signal("finished", "waiting_for_battle")
	
func handle_input(event):	
	if (event is InputEventMouseButton && event.pressed):
		var _mouse_pos = event.position
		var _coord = _board._tile_frame.world_to_map(_mouse_pos - _board.position) # adjust for positioning of board in main scene.
		var _tile = _board._tiles.get(_coord)
		BoardSignals.emit_signal("TilePressed", _tile)
		
func _on_tile_pressed(tile : TileBase):
	if tile and tile.Selectable:
		if _board.is_tile_in_match(tile) and not tile.is_matched():
			_board.register_new_match_made(tile)						
	else:
		pass # handle no match state

func _on_match_made(tile):
	var _matches = _matches_made_this_turn.get(tile.TileType, 0)
	_matches += 1
	_matches_made_this_turn[tile.TileType] = _matches
