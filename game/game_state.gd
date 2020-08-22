extends Node

# Gold
var _gold : int = 0
func add_gold(delta):
	set_gold_balance(_gold + delta)
	
func spend_gold(spend_amount):
	set_gold_balance(_gold - spend_amount)
	
func set_gold_balance(gold : int):	
	GameSignals.emit_signal("GoldBalanceChanged", _gold, gold)
	_gold = gold

func get_gold_balance() -> int: return _gold

# Player health
var _player_health : int = 0
func add_player_health(delta):
	set_gold_balance(_player_health + delta)
	
func set_player_health(health : int):	
	GameSignals.emit_signal("PlayerHealthChanged", _player_health, health)
	_player_health = health

func get_player_health() -> int: return _player_health
