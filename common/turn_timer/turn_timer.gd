extends Node2D

const HourglassSections = 3

onready var _timer : Timer = $Timer
onready var _hourglasses = $Hourglasses.get_children()

onready var _hourglass_count = _hourglasses.size()
onready var _hourglass_section_count = _hourglass_count * HourglassSections
onready var _time_per_hourglass = TimePerTurn / _hourglass_count
onready var _time_per_hourglass_section = _time_per_hourglass / HourglassSections

export(float) var TimePerTurn = 5.0

func _ready():
	BoardSignals.connect("TileMatched", self, "_reset_timer")
	_timer.connect("timeout", self, "_timeout")
	_reset_timer()

func _timeout():
	BoardSignals.emit_signal("TurnTimerExpired")
	_reset_hourglasees()
	
func _reset_hourglasees():	
	for _hourglass in _hourglasses: _hourglass.frame = 	HourglassSections - 1
	
func _reset_timer(tile : TileBase = null):
	if tile and (tile.TileType != TileUtil.TileType.Gold):
		_timer.start(5.0)
		_reset_hourglasees()

func _process(delta):
	var _frame_time = _timer.wait_time / _hourglass_section_count
	var _current_frame = int(_timer.time_left / _frame_time)
	var _hourglass = int(_current_frame / HourglassSections)
	var _frame = _current_frame % HourglassSections
	_hourglasses[_hourglass].frame = _frame
