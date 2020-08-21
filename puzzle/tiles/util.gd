class_name TileUtil

enum TileType { Sword, Magic, Spear, Arrow, Gold, Health }
enum TileColor { Red, Blue, Green, Yellow, Orange, Purple }

const ColorMap : Dictionary = {
	TileColor.Red: Color.red,
	TileColor.Blue: Color.blue,
	TileColor.Green: Color.green,
	TileColor.Yellow: Color.yellow,
	TileColor.Orange: Color.orange,
	TileColor.Purple: Color.purple
}

const IconMap : Dictionary = {
	TileType.Sword: "res://assets/sprites/sword.png",
	TileType.Magic: "res://assets/sprites/magic.png",
	TileType.Spear: "res://assets/sprites/spear.png",
	TileType.Arrow: "res://assets/sprites/bow.png",
	TileType.Gold: "res://assets/sprites/crown.png",
	TileType.Health: "res://assets/sprites/health.png"
}

const IconColorMap : Dictionary = {
	TileType.Sword: [TileColor.Orange],
	TileType.Magic: [TileColor.Blue, TileColor.Purple],
	TileType.Spear: [TileColor.Yellow],
	TileType.Arrow: [TileColor.Green],
	TileType.Gold: [TileColor.Yellow],
	TileType.Health: [TileColor.Red]
}
