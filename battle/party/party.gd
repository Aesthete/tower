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
	GameState.set_player_health(_health)
	
	BattleSignals.connect("BattlePhasePlayerAttackStarted", self, "_process_attacks")
	BattleSignals.connect("BattlePhaseEnded", self, "_on_battle_end")
	BattleSignals.connect("PlayerDamaged", self, "_player_damaged")
	GameSignals.connect("PlayerHealthChanged", self, "_player_health_changed")
	GameSignals.connect("GoldBalanceChanged", self, "_on_gold_changed")
	
func _process_attacks():
	var _matches_made = GameState.get_matches_made_last_turn()
	for _hero in _heroes:
		if _matches_made.has(_hero.AttackType):
			var _damage_done = _matches_made.get(_hero.AttackType) * _hero.AttackBaseDamage
			print ("Doing damage: " + String(_damage_done))
			BattleSignals.emit_signal("HeroAttackTriggered", _hero, _damage_done)
	BattleSignals.emit_signal("PartyFinishedAttacking")

func _player_damaged(amount):
	var _health = GameState.get_player_health()
	var _new_health = max(_health-amount, 0)
	GameState.set_player_health(_new_health)
	if _new_health <= 0:
		BattleSignals.emit_signal("PlayerKilled")

func _player_health_changed(old, new):
	_health_bar.set_health(new)

func _on_battle_end():
	var _match = GameState.get_matches_made_last_turn()
	var _gold_collected = _match.get(TileUtil.TileType.Gold, 0)
	GameState.add_gold(_gold_collected * GameState.GoldValuePerPiece)
	var _health_collected = _match.get(TileUtil.TileType.Health, 0)
	var _current_health = GameState.get_player_health()
	var _added = min(_current_health + _health_collected * GameState.HealthValuePerPiece, _health_bar._max)
	GameState.set_player_health(_added)

func _on_gold_changed(old, new):
	_gold_balance.text = String(new)
