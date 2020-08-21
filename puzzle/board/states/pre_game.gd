extends State

func enter():
	#init board.
	owner.build_board()
	emit_signal("finished", "waiting_for_player")
