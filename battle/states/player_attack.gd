extends State

func enter():
	print ("player is attacking!")
	BattleSignals.connect("PartyFinishedAttacking", self, "_on_party_finished_attacking")
	BattleSignals.connect("HeroAttackTriggered", self, "_player_attack_triggered")	
	BattleSignals.emit_signal("BattlePhasePlayerAttackStarted")
	
func exit():
	BattleSignals.disconnect("PartyFinishedAttacking", self, "_on_party_finished_attacking")	
	BattleSignals.disconnect("HeroAttackTriggered", self, "_player_attack_triggered")
	
func update(delta):
	pass
	
func _on_party_finished_attacking():
	BattleSignals.emit_signal("BattlePhasePlayerAttackEnded")
	emit_signal("finished", "enemy_attack")

func _player_attack_triggered(hero, damage):
	var _battle : Battle = owner
	var _enemies = _battle._enemies._enemies
	var _attack = BattleUtil.find_enemy_to_attack(hero, _enemies)
	if _attack:
		_attack.emit_signal("TakeDamage", damage)
		BattleSignals.emit_signal("EnemyDamaged", _attack, damage)
