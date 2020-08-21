extends MotionStateBase

func enter():
	pass

func update(delta):
	var input_direction = InputActions.get_input_directions()
	if input_direction.length_squared() != 0: # no movement.
		emit_signal(SIGNAL_STATE_FINISHED, "move")
