extends State

onready var _enemy : Enemy = owner

func enter():
	BoardSignals.connect("TileMatched", self, "_tile_matched")
	
func exit():
	BoardSignals.disconnect("TileMatched", self, "_tile_matched")
	
func _tile_matched(tile):
	var _tile = tile as TileBase
	if _tile.TileType == _enemy.AttackType:
		_enemy.emit_signal("Matched")
		BattleSignals.emit_signal("EnemyAttackTypeMatched", _enemy)
