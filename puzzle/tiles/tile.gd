extends Node2D
class_name TileBase

export(TileUtil.TileType) var TileType = TileUtil.TileType.Gold
export(TileUtil.TileColor) var TileColor = TileUtil.TileColor.Yellow
export(bool) var Selectable = true
export(bool) var Selected = false

onready var _background : Sprite = $Background
onready var _highlight : ColorRect = $Highlight
onready var _icon : Sprite = $Icon
onready var _states : StateMachine = $States

var target_position = position

signal TileMatched()

#external
func init(type) -> void:
	TileType = type
	TileColor = TileUtil.IconColorMap[type][0] # Todo - just use first for now.
	
func is_matched() -> bool:
	return _states.current_state == $States/Matched
	
func is_falling() -> bool:
	return _states.current_state == $States/Falling

#internals
func set_selected(selected : bool):
	Selected = selected
	_highlight.visible = selected

func _set_color(new_color):
	var _col = TileUtil.ColorMap[new_color]
	
func _set_type(new_type):
	_icon.texture = load(TileUtil.IconMap.get(TileType))

func _ready():
	_states.initialize(_states.START_STATE)
	_set_type(TileType)
	_set_color(TileColor)
	set_selected(Selected)
