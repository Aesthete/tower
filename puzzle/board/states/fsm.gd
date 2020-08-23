extends StateMachine

func _ready():
	states_map = {
		"pre_game": $PreGame,
		"waiting_for_player": $WatingForPlayer,
		"waiting_for_battle": $WaitingForBattle,
		"resolving_matches": $ResolvingMatches,
		"post_game": $PostGame
	}
