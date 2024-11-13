class_name Monster
extends Area2D

const DEATH_PARTICLES = preload("res://Scenes/death_particles.tscn")

@export var monster_data: DataMonster = null

var is_moving: bool = true
var is_attacking: bool = false

var attack_timer: float = 0

@onready var hero: Area2D = MainManager.hero


func _ready():
	if monster_data:
		# print("Enemy spawned")
		monster_data = monster_data.duplicate()
		get_node("Sprite").texture = monster_data.sprite
	else:
		print("Monster monster_data not set")
		queue_free()


func _process(delta):
	if is_moving:
		var move_direction = (hero.global_position - global_position).normalized()

		# Add a small random offset to the movement direction for a "wander" effect
		var jitter_strength = 10  # Adjust this to control the amount of randomness
		var random_offset = Vector2(
			randf_range(-jitter_strength, jitter_strength),
			randf_range(-jitter_strength, jitter_strength)
		)

		move_direction += random_offset.normalized() * 0.1
		global_position += move_direction * delta * monster_data.movement_speed


func _physics_process(_delta):
	if is_attacking and attack_timer <= 0:
		attack_timer = monster_data.attack_cooldown * 60
		hero.get_hit(monster_data.damage)
		# print("Monster hit hero", monster_data.damage)
	else:
		attack_timer -= 1


func _on_area_entered(_area: Area2D):
	attack_timer = monster_data.attack_cooldown * 60
	is_attacking = true
	is_moving = false
	hero.get_hit(monster_data.damage)
	# print("Monster hit hero", monster_data.damage)


func get_hit(damage: int) -> bool:
	monster_data.health -= damage
	if monster_data.health <= 0:
		MainManager.add_experience(monster_data.experience)
		MainManager.alive_enemies[monster_data.name] -= 1
		var particle = DEATH_PARTICLES.instantiate()
		add_child(particle)
		return true
	return false


# Creates a new enemy instance based on provided monster_data and template.
# @param input_data: A `DataMonster` object containing all the monster's data
# @param input_monster_template: Template for creating new monsters.
# @return: Returns `Area2D` representing the newly created enemy
static func new_enemy(input_data: DataMonster, input_monster_template: PackedScene) -> Area2D:
	var new_monster: Area2D = input_monster_template.instantiate()
	new_monster.monster_data = input_data.duplicate()
	return new_monster
