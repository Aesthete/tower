extends Node2D

class_name Mission

onready var _enemies = $Characters.get_children()
	
func _tile_matched(tile):
	pass

func _ready():		
	BattleSignals.connect("BattlePhaseEnemyAttackStarted", self, "_process_attacks")
	for _char in _enemies:
		var _enemy = _char as Enemy
		_enemy.init(TileUtil.get_random_attack_tile_type())
	
func _process_attacks():
	for _enemy in _enemies:
		if not _enemy._matched:
			var _damage_done = _enemy.AttackBaseDamage
			print ("Doing damage: " + String(_damage_done))
			BattleSignals.emit_signal("PlayerDamaged", _damage_done)
	BattleSignals.emit_signal("EnemiesFinishedAttack")
