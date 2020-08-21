extends State

onready var _tile : TileBase = owner

func enter():
	print ("Tile matched!")	
	BoardSignals.connect("TileResolveTriggered", self, "_resolve_triggered")
	_tile._highlight.color = Color.black
	_tile._highlight.color.a = 0.5
	_tile.set_selected(true)
	
func exit():
	BoardSignals.disconnect("TileResolveTriggered", self, "_resolve_triggered")
	
func _resolve_triggered():
	emit_signal("finished", "collecting")
