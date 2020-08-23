extends State

func enter():
	BattleSignals.connect("BattlePhasePlayerAttackStarted", self, "_start_attack")
	
func exit():
	BattleSignals.disconnect("BattlePhasePlayerAttackStarted", self, "_start_attack")

func _start_attack():
	pass

func _end_attack():
	pass
