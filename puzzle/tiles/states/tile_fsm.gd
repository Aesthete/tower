extends StateMachine

func _ready():
	states_map = {
		"idle": $Idle,
		"matched": $Matched,
		"falling": $Falling,
		"collecting": $Collecting
	}
