extends State

func enter():
	print ("Enemy is attacking!")
	BattleSignals.connect("EnemiesFinishedAttack", self, "_on_enemies_finished_attacking")
	
	BattleSignals.emit_signal("BattlePhaseEnemyAttackStarted")

func exit():
	BattleSignals.disconnect("EnemiesFinishedAttack", self, "_on_enemies_finished_attacking")
	
func update(delta):
	pass
	
func _on_enemies_finished_attacking():
	BattleSignals.emit_signal("BattlePhaseEnemyAttackEnded")
	BattleSignals.emit_signal("BattlePhaseEnded")
	emit_signal("finished", "idle")
