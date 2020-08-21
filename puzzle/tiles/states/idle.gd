extends State

func _ready():
	owner.connect("TileMatched", self, "_tile_matched")

func _tile_matched():
	emit_signal("finished", "matched")
