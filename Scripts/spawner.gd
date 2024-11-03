extends Node2D

@export var monster_data: DataMonster
@export var monster_template: PackedScene

var spawn_timer: float = 0
var random_manager = RandomNumberGenerator.new()


func _ready():
	if monster_data:
		monster_data = monster_data.duplicate()
	else:
		print("Monster data not set")
		queue_free()


func _physics_process(_delta):
	if spawn_timer <= 0 and get_child_count() <= monster_data.monsters_spawn_limit:
		spawn_timer = monster_data.respawn_cooldown * 60
		var monster: Area2D = Monster.new_enemy(monster_data, monster_template)
		add_child(monster)
		monster.position = Vector2(
			random_manager.randf_range(-50, 50), random_manager.randf_range(-50, 50)
		)
	else:
		spawn_timer -= 1
