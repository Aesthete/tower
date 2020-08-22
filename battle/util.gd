class_name BattleUtil

enum HeroType { Knight, Mage, Rogue }
static func get_random_hero():
	return randi() % HeroType.size()
	
enum EnemyType { Goblin, Skeleton, Ghost, Spider, Crocodile }
static func get_random_enemy():
	return randi() % EnemyType.size()

const HeroIconMap : Dictionary = {
	HeroType.Knight: "res://assets/sprites/knight.png",
	HeroType.Mage: "res://assets/sprites/mage.png",
	HeroType.Rogue: "res://assets/sprites/rogue.png"	
}

const EnemyIconMap : Dictionary = {
	EnemyType.Goblin: "res://assets/sprites/goblin.png",
	EnemyType.Skeleton: "res://assets/sprites/skeleton.png",
	EnemyType.Ghost: "res://assets/sprites/ghost.png",
	EnemyType.Spider: "res://assets/sprites/spider.png",
	EnemyType.Crocodile: "res://assets/sprites/crocodile.png"
}

static func get_icon_for_hero(hero_type):
	return load(HeroIconMap.get(hero_type))

static func get_icon_for_enemy(enemy_type):
	return load(EnemyIconMap.get(enemy_type))
