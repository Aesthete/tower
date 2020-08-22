extends Node2D

onready var _progress_bar : ProgressBar = $ProgressBar
onready var _timer : Timer = $Timer

func _ready():
	BoardSignals.connect("TileMatched", self, "_reset_timer")
	_timer.connect("timeout", self, "_timeout")
	_reset_timer()

func _timeout():
	BoardSignals.emit_signal("TurnTimerExpired")
	
func _reset_timer(tile : TileBase = null):
	if tile and (tile.TileType != TileUtil.TileType.Gold):
		_progress_bar.max_value = 5.0
		_timer.start(5.0)

func _process(delta):
	_progress_bar.value = _timer.time_left
