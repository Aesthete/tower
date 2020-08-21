extends Node2D
class_name TileBase

export(TileUtil.TileType) var TileType = TileUtil.TileType.Gold
export(TileUtil.TileColor) var TileColor = TileUtil.TileColor.Yellow
export(bool) var Selectable = true
export(bool) var Selected = false

onready var _background : ColorRect = $Background
onready var _highlight : ColorRect = $Highlight
onready var _icon : Sprite = $Icon
onready var _states : StateMachine = $States

signal TileMatched()

#external
func init(type, color) -> void:
	TileType = type
	TileColor = color
	
func is_matched() -> bool:
	return _states.current_state == $States/Matched

#internals
func set_selected(selected : bool):
	Selected = selected
	_highlight.visible = selected

func _set_color(new_color):
	_background.color = TileUtil.ColorMap[new_color] # should be TileUtil.TileColor

func _ready():
	_states.initialize(_states.START_STATE)
	_set_color(TileColor)
	set_selected(Selected)
	connect("TileMatched", self, "_on_matched")
	
func _on_matched():
	print ("I was matched!")
