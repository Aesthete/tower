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

func _change_state(state_name : String):
	var _newState = states_map[state_name]
	._change_state(state_name)
