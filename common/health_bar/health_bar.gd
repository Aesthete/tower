extends Control

class_name HealthBar

onready var _progress_bar : TextureProgress = $TextureProgress

export(float) var LowHealthChangePercentage =  0.35;
export(float) var CriticalHeathChangePercentage =  0.2;

export(Color) var HealthOkColor = Color.green
export(Color) var HealthLowColor = Color.yellow
export(Color) var HealthCriticalColor = Color.red

export(float) var CountSpeed = 2.5
var _count_speed = 100

var _health : int = 0

func init(start_health : float, max_health : float):
	_count_speed = max_health / CountSpeed
	_progress_bar.max_value = max_health
	set_health(start_health)

func set_health(new_health : float):
	_health = new_health
	var _health_perc = new_health / _progress_bar.max_value

func _get_bar_tint():	
	var _health_perc = _progress_bar.value / _progress_bar.max_value
	if _health_perc < CriticalHeathChangePercentage: return HealthCriticalColor
	elif _health_perc < LowHealthChangePercentage: return HealthLowColor
	return HealthOkColor

func _process(delta):
	if _health != _progress_bar.value:
		var _dir = sign(_health - _progress_bar.value)
		var _incr = _dir * _count_speed * delta
		_progress_bar.value += _incr
	_progress_bar.tint_progress = _get_bar_tint()
