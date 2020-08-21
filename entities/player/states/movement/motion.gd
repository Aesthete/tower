extends State
class_name MotionStateBase

var speed : float = 0.0
var velocity : Vector2 = Vector2()

func handle_input(event): pass

func update_look_direction(direction):
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
	if not direction.x in [-1, 1]:
		return
	owner.get_node("BodyPivot").set_scale(Vector2(direction.x, 1))
