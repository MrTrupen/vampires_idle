class_name DataMonster
extends Resource

@export var name: String = "Monster"

@export var sprite: Texture2D

@export var movement_speed: int = 1
@export var health: int = 1
@export var experience: int = 1
@export var damage: int = 1
## Attack cooldown in seconds
@export var attack_cooldown: float = 1
## Spawner cooldown in seconds
@export var respawn_cooldown: float = 1
## Monsters limit from one spawner
@export var spawn_limit: int = 1

var max_health: int = 1

# upgrades
var health_upgrade: int = 0
var respawn_cooldown_upgrade: float = 1
var spawn_limit_upgrade: int = 0

# upgrades prices
var health_upgrade_price: int = 100
var respawn_cooldown_upgrade_price: int = 100
var spawn_limit_upgrade_price: int = 100


func _ready():
	max_health = get_health()


func restart() -> void:
	max_health = health
	health_upgrade = 0
	respawn_cooldown_upgrade = 1
	spawn_limit_upgrade = 0


func get_health() -> int:
	return health + health_upgrade


func get_respawn_cooldown() -> float:
	return respawn_cooldown * respawn_cooldown_upgrade


func get_spawn_limit() -> int:
	return spawn_limit + spawn_limit_upgrade


func get_experience() -> int:
	print("health and damage:", max_health, " ", damage)
	return max_health * damage
