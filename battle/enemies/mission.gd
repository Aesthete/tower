extends Node2D

onready var _chars = $Characters.get_children()

func _ready():
	BoardSignals.connect("TileMatched", self, "_tile_matched")	
	for _char in _chars:
		var _enemy = _char as Enemy
		_enemy.init(TileUtil.get_random_attack_tile_type())
	
func _tile_matched(tile):
	pass
