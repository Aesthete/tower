extends State

export(PackedScene) var GameScene
export(NodePath) var WorldRoot
onready var _world = get_node(WorldRoot)
var _game : Node
onready var _darkener = get_tree().get_root().find_node("GUI", true, false).get_node("DarkenedOverlay")
var _started_fade = false
var _timer

func enter():	
	_game = GameScene.instance()	
	_world.add_child(_game)
	_timer = _game.get_node("Timer")
	_timer.connect("timeout", self, "_timeout")
	_darkener.fade_out(1.0)
	GameSignals.connect("GameOver", self, "_game_over")
	
func exit():
	_world.remove_child(_game)

func _timeout():
	if not _started_fade:
		_started_fade = true
		_darkener.fade_in()		
	else: emit_signal("finished", "splash")

func _game_over():	
	_timer.start(2.5)
