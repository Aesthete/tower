extends Node

enum Difficulty { Easy, Medium, Hard }
var DifficultEnemyCountMap : Dictionary = {
	Difficulty.Easy: 2,
	Difficulty.Easy: 4,
	Difficulty.Easy: 6
}

export(Difficulty) var GameDifficulty = Difficulty.Easy


