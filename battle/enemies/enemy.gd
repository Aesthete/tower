extends Node

class_name Enemy

onready var _mission_icon : Sprite = $Mission/Icon
onready var _mission_complete : Sprite = $Mission/MissionComplete
onready var _mission_fail : Sprite = $Mission/MissionFail
onready var _enemy_icon : Sprite = $Enemy/Enemy
onready var _health_bar : HealthBar = $HealthBar

export(int) var MaxHealth = 100
export(int) var Health = MaxHealth
export(int) var AttackBaseDamage = 100
export(int) var DefenseBaseDamage = 100
export(TileUtil.TileType) var AttackType = TileUtil.TileType.Sword
export(BattleUtil.EnemyType) var EnemyType = BattleUtil.EnemyType.Skeleton

func _ready():
	_mission_complete.visible = false
	_mission_fail.visible = false

func init(mission_type):	
	AttackType = mission_type
	EnemyType = BattleUtil.get_random_enemy()
	_enemy_icon.texture = BattleUtil.get_icon_for_enemy(EnemyType)
	_mission_icon.texture = TileUtil.get_tile_icon(AttackType)
	_health_bar.init(MaxHealth, MaxHealth)
