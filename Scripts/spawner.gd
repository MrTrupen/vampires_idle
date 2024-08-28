extends Node2D

@export var monster_data: DataMonster
@export var monster_template: PackedScene

var spawn_timer: float = 0


func _ready():
	if monster_data:
		monster_data = monster_data.duplicate()
		spawn_timer = monster_data.respawn_cooldown * 60
	else:
		print("Monster data not set")
		queue_free()


func _physics_process(_delta):
	if spawn_timer <= 0:
		spawn_timer = monster_data.respawn_cooldown * 60
		var monster: Area2D = monster_template.instantiate()
		add_child(monster)
		# monster.get_script().load_data(monster_data)
		print("Monster spawned")
	else:
		spawn_timer -= 1
