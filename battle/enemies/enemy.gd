extends Node

class_name Enemy

onready var _mission_icon : Sprite = $Mission/Icon
onready var _mission_complete : Sprite = $Mission/MissionComplete
onready var _mission_fail : Sprite = $Mission/MissionFail
onready var _enemy_icon : Sprite = $Enemy/Enemy
onready var _health_bar : HealthBar = $HealthBar

func _ready():
	_mission_complete.visible = false
	_mission_fail.visible = false

func init(mission_type):	
	_enemy_icon.frame = randi() % EnemyUtil.ENEMY_TYPE_COUNT
	_mission_icon.texture = TileUtil.get_tile_icon(mission_type)
	_health_bar.init(randi() % 100, 100.0)
