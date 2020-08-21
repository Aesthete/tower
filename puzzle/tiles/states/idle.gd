extends State

onready var _tile : TileBase = owner

func enter():
	owner.connect("TileMatched", self, "_tile_matched")
	BoardSignals.connect("BoardLayoutChanged", self, "_resposition_if_required")
	
func exit():
	owner.disconnect("TileMatched", self, "_tile_matched")

func _tile_matched():
	emit_signal("finished", "matched")
	
func _resposition_if_required():
	if _tile.target_position != _tile.position:
		emit_signal("finished", "falling")
