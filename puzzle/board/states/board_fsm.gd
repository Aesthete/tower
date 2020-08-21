extends StateMachine

func _ready():
	states_map = {
		"pre_game": $PreGame,
		"waiting_for_player": $WatingForPlayer,
		"waiting_for_enemy": $WaitingForEnemy,
		"resolving_matches": $ResolvingMatches,
		"shuffling_board": $ShufflingBoard,
		"post_game": $PostGame
	}
