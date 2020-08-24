extends State

export(PackedScene) var TutorialScene
export(NodePath) var WorldRoot
onready var _world = get_node(WorldRoot)
var _tutorial : Node
var _timer
var _started_fade = false
onready var _darkener = get_tree().get_root().find_node("GUI", true, false).get_node("DarkenedOverlay")

func enter():	
	_tutorial = TutorialScene.instance()
	_timer = _tutorial.get_node("Timer")
	_timer.connect("timeout", self, "_timeout")
	_world.add_child(_tutorial)
	_timer.start(8.0)
	_darkener.fade_out()
	
func exit():
	_world.remove_child(_tutorial)

func _timeout():
	if not _started_fade:
		_started_fade = true
		_timer.start(1.0)
		_darkener.fade_in()
		
	else: emit_signal("finished", "game")
