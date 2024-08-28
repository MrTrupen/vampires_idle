class_name DataMonster
extends Resource

@export var monster_sprite: Texture2D

@export var movement_speed: int = 1
@export var health: int = 1
@export var damage: int = 1
## Attack cooldown in seconds
@export var attack_cooldown: float = 1

var hitbox_component: HitboxComponent = null
var attack_component: AttackComponent = null
