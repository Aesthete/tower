extends Node

class_name Battle

enum Difficulty { Easy, Medium, Hard }
var DifficultEnemyCountMap : Dictionary = {
	Difficulty.Easy: 2,
	Difficulty.Easy: 4,
	Difficulty.Easy: 6
}

export(Difficulty) var GameDifficulty = Difficulty.Easy

onready var _states : StateMachine = $States
onready var _party = $Party
onready var _enemies = $Enemies

func _ready():
	_states.initialize(_states.START_STATE)
