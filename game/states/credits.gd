extends State

export(PackedScene) var SplashScene
export(NodePath) var WorldRoot
onready var _world = get_node(WorldRoot)
var _splash : Node
var _timer
var _started_fade = false
onready var _darkener = get_tree().get_root().find_node("GUI", true, false).get_node("DarkenedOverlay")

func enter():	
	_splash = SplashScene.instance()
	_timer = _splash.get_node("Timer")
	_timer.connect("timeout", self, "_timeout")
	_world.add_child(_splash)
	_timer.start(3.0)
	
func exit():
	_world.remove_child(_splash)

func _timeout():
	if not _started_fade:
		_started_fade = true
		_timer.start(1.0)
		_darkener.fade_in(5.0)
		
	else: emit_signal("finished", "splash")
	
func update(delta):
	print (_timer.time_left)
