extends Node2D

onready var _target_type = $TargetType

func _ready():
	BoardSignals.connect("TileMatched", self, "_tile_matched")
	
func _tile_matched(tile):
	var _icon = _target_type.get_node("Icon");
	var _tileType = randi() % TileUtil.TileType.size()
	_icon.texture = load(TileUtil.IconMap.get(_tileType))
