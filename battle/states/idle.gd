extends State

func enter():
	GameSignals.connect("TurnEndMatchesReported", self, "_matches_reported")
	BoardSignals.connect("MatchPhaseEnded", self, "_match_phase_ended")
	
func exit():
	GameSignals.disconnect("TurnEndMatchesReported", self, "_matches_reported")
	BoardSignals.disconnect("MatchPhaseEnded", self, "_match_phase_ended")

func _matches_reported(turn, matches):
	print ("Match report!")
	print(matches)

func _match_phase_ended():
	BattleSignals.emit_signal("BattlePhaseStarted")
	emit_signal("finished", "player_attack")
