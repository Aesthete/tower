extends Control

class_name HealthBar

onready var _texture : TextureProgress = $TextureProgress

export(float) var LowHealthChangePercentage =  0.35;
export(float) var CriticalHeathChangePercentage =  0.2;

export(Color) var HealthOkColor = Color.green
export(Color) var HealthLowColor = Color.yellow
export(Color) var HealthCriticalColor = Color.red

func init(start_health : float, max_health : float):
	_texture.max_value = max_health
	set_health(start_health)

func set_health(new_health : float):
	_texture.value = new_health
	var _health_perc = new_health / _texture.max_value
	_texture.tint_progress = _get_bar_tint()

func _get_bar_tint():	
	var _health_perc = _texture.value / _texture.max_value
	if _health_perc < CriticalHeathChangePercentage: return HealthCriticalColor
	elif _health_perc < LowHealthChangePercentage: return HealthLowColor
	return HealthOkColor
