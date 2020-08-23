extends State

func enter():
	#init board.
	owner.build_board()
	GameSignals.emit_signal("GameStart")
	emit_signal("finished", "waiting_for_player")

