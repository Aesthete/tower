extends State

export(PackedScene) var MenuScene
export(NodePath) var WorldRoot
onready var _world = get_node(WorldRoot)
var _menu : Node
var _timer
var _started_fade = false
onready var _darkener = get_tree().get_root().find_node("GUI", true, false).get_node("DarkenedOverlay")

func enter():	
	_menu = MenuScene.instance()
	_timer = _menu.get_node("Timer")
	_timer.connect("timeout", self, "_timeout")
	_timer.stop()
	_world.add_child(_menu)	
	_darkener.fade_out()
	
func exit():
	_world.remove_child(_menu)

func _timeout():
	if not _started_fade:
		_started_fade = true
		_timer.start(1.0)
		_darkener.fade_in()
		
	else: emit_signal("finished", "tutorial")

func handle_input(event):
	if event is InputEventMouseButton and _timer.time_left <= 0:
		_timer.start(0.1)
