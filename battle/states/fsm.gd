extends StateMachine

func _ready():
	states_map = {
		"idle": $Idle,
		"player_attack": $PlayerAttack,
		"enemy_attack": $EnemyAttack,
	}
