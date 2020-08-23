extends Node

class_name Enemy

onready var _mission_icon : Sprite = $Mission/Icon
onready var _mission_complete : Sprite = $Mission/MissionComplete
onready var _mission_fail : Sprite = $Mission/MissionFail
onready var _enemy_icon : Sprite = $Enemy/Enemy
onready var _health_bar : HealthBar = $HealthBar

export(int) var MaxHealth = 10000
export(int) var Health = MaxHealth
export(int) var AttackBaseDamage = 100
export(int) var DefenseBaseDamage = 100
export(int) var IsAlive = true
export(TileUtil.TileType) var AttackType = TileUtil.TileType.Sword
export(BattleUtil.EnemyType) var EnemyType = BattleUtil.EnemyType.Skele

onready var _states : StateMachine = $States

var _matched = false
signal Matched()

signal TakeDamage(damage)

func _ready():	
	connect("Matched", self, "_matched")	
	connect("TakeDamage", self, "_take_damage")
	BoardSignals.connect("TurnTimerExpired", self, "_turn_ended")
	BattleSignals.connect("BattlePhaseEnded", self, "_battle_ended")
	
	_states.initialize(_states.START_STATE)	

func init(mission_type):	
	_mission_complete.visible = false
	_mission_fail.visible = false
	AttackType = mission_type
	EnemyType = BattleUtil.get_random_enemy()
	_enemy_icon.texture = BattleUtil.get_icon_for_enemy(EnemyType)
	_mission_icon.texture = TileUtil.get_tile_icon(AttackType)
	_health_bar.init(MaxHealth, MaxHealth)
	
func _matched():
	_matched = true
	_mission_complete.visible = true

func _turn_ended():
	if not _matched:
		_mission_fail.visible = true

func _battle_ended():
	if _matched: init(TileUtil.get_random_attack_tile_type())
	_mission_complete.visible = false
	_mission_fail.visible = false
	_matched = false

func _take_damage(damage):
	Health -= damage
	Health = max(Health, 0)
	_health_bar.set_health(Health)
	if Health <= 0:
		BattleSignals.emit_signal("EnemyKilled", self)
		_states._change_state("dying")
		IsAlive = false
