extends Node2D

class_name Hero

export(int) var Health = 500
export(int) var AttackBaseDamage = 100
export(int) var DefenseBaseDamage = 100
export(TileUtil.TileType) var AttackType = TileUtil.TileType.Sword
export(BattleUtil.HeroType) var HeroType = BattleUtil.HeroType.Knight

onready var _icon : Sprite = $Display/Enemy

func _ready():
	_icon.texture = BattleUtil.get_icon_for_hero(HeroType)
