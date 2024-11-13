extends Node2D

@export var monster_data: DataMonster
@export var monster_template: PackedScene

var spawn_timer: float = 0
var random_manager = RandomNumberGenerator.new()

@onready var enemies = get_node("/root/MainScene/Enemies")


func _ready():
	if monster_data:
		monster_data = monster_data.duplicate()
	else:
		print("Monster data not set")
		queue_free()


func _physics_process(_delta):
	if (
		spawn_timer <= 0
		and MainManager.alive_enemies[monster_data.name] < monster_data.monsters_spawn_limit
	):
		spawn_timer = monster_data.respawn_cooldown * 60
		var monster: Area2D = Monster.new_enemy(monster_data, monster_template)
		enemies.add_child(monster)
		MainManager.alive_enemies[monster_data.name] += 1
		var offset = Vector2(
			random_manager.randf_range(-50, 50), random_manager.randf_range(-50, 50)
		)
		monster.position = global_position + offset
	else:
		spawn_timer -= 1
