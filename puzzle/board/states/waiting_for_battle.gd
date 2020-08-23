extends State

onready var _board : Board = owner

func enter():
	BattleSignals.connect("BattlePhaseEnded", self, "_on_battle_ended")
	BattleSignals.connect("PlayerKilled", self, "_game_over")
	BoardSignals.emit_signal("MatchPhaseEnded")
	
func exit():
	BattleSignals.disconnect("BattlePhaseEnded", self, "_on_battle_ended")

func update(delta): pass	

func _on_battle_ended():	
	emit_signal("finished", "resolving_matches")
	
func _game_over():
	emit_signal("finished", "post_game")
	GameSignals.emit_signal("GameOver")
