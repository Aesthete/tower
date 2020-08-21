extends State

onready var _tile : TileBase = owner
export(float) var FallSpeed = 3.0
var _t = 0.0
var _start_pos

func enter():	
	BoardSignals.connect("BoardLayoutChanged", self, "_update_targets")
	_update_targets()
	
func exit():
	BoardSignals.disconnect("BoardLayoutChanged", self, "_update_targets")
	
func update(delta):
	_t += delta * FallSpeed
	_tile.position = _tile.position.linear_interpolate(_tile.target_position, _t)
	if _tile.position == _tile.target_position:
		emit_signal("finished", "idle")

func _update_targets():
	_start_pos = _tile.position
	_t = 0.0
