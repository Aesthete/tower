extends Node

onready var _health_bar : HealthBar = $HealthBar
onready var _gold_balance : RichTextLabel = $Gold/Balance
onready var _heroes : Array = $Heroes.get_children()

func _ready():
	_gold_balance.text = String(GameState.get_gold_balance())
	
	var _health = 0
	for _hero in _heroes:
		_health += _hero.Health
	_health_bar.init(_health, _health)
