extends State

onready var _tile : TileBase = owner

func enter():
	print ("Tile selected!")
	_tile._highlight.color = Color.black
	_tile._highlight.color.a = 0.5
	_tile.set_selected(true)
