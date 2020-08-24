extends State

onready var _board : Board = owner

func enter():
	BattleSignals.connect("BattlePhaseEnded", self, "_on_battle_ended")
	BattleSignals.connect("PlayerKilled", self, "_game_over")
	BoardSignals.connect("RemoveRandomTile", self, "_remove_random_tile")
	BoardSignals.emit_signal("MatchPhaseEnded")
	
func exit():
	BattleSignals.disconnect("BattlePhaseEnded", self, "_on_battle_ended")

func update(delta): pass	

func _on_battle_ended():	
	emit_signal("finished", "resolving_matches")
	
func _game_over():
	emit_signal("finished", "post_game")
	GameSignals.emit_signal("GameOver")

func _remove_random_tile():pass
	
	#var _rand_remove = Vector2(randi() % int(_board.BoardSize.x), randi() % int(_board.BoardSize.y))
	#var _tile = _board._tiles.get(_rand_remove)
	#if _tile: _board.remove_tile_from_board(_tile)
