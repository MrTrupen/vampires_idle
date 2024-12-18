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
@export var monsters_spawn_limit: int = 1
