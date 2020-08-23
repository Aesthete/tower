class_name BattleUtil

enum HeroType { Knight, Mage, Rogue }
static func get_random_hero():
	return randi() % HeroType.size()
	
enum EnemyType { Goblin, Skele, Ghost, Spider, Crocodile }
static func get_random_enemy():
	return randi() % EnemyType.size()

const HeroIconMap : Dictionary = {
	HeroType.Knight: "res://assets/sprites/knight.png",
	HeroType.Mage: "res://assets/sprites/mage.png",
	HeroType.Rogue: "res://assets/sprites/rogue.png"	
}

const EnemyIconMap : Dictionary = {
	EnemyType.Goblin: "res://assets/sprites/goblin.png",
	EnemyType.Skele: "res://assets/sprites/skeleton.png",
	EnemyType.Ghost: "res://assets/sprites/ghost.png",
	EnemyType.Spider: "res://assets/sprites/spider.png",
	EnemyType.Crocodile: "res://assets/sprites/crocodile.png"
}

static func get_icon_for_hero(hero_type):
	return load(HeroIconMap.get(hero_type))

static func get_icon_for_enemy(enemy_type):
	return load(EnemyIconMap.get(enemy_type))

static func find_enemy_to_attack(hero, enemies):	
	var _found = []
	for _enemy in enemies:
		if _enemy._matched: _found.push_back(_enemy)
	if _found.empty(): _found = enemies
	var _lowest_health = 999999999;
	var _enemy_to_attack = null
	for _enemy in enemies:
		if _enemy.Health != 0 and _enemy.Health < _lowest_health: 
			_enemy_to_attack = _enemy
			_lowest_health = _enemy.Health	
	
	return _enemy_to_attack if _enemy_to_attack else _found[0]
