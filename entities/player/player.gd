extends KinematicBody2D

signal direction_changed(new_direction)

var look_direction = Vector2(1, 0) setget set_look_direction

onready var movement_animator : AnimationPlayer = $MovementAnimator;
onready var action_animator : AnimationPlayer = $ActionAnimator;

func take_damage(attacker, amount, effect=null):
	$Health.take_damage(amount, effect)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)
