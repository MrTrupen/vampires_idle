class_name Monster
extends Area2D

# @export var data: DataMonster = preload("res://Resources/bug.tres")
@export var data: DataMonster = null

var is_moving: bool = true
var is_attacking: bool = false

var attack_timer: float = 0

@onready var hero: Area2D = MainManager.hero


func _ready():
	if data:
		print("Enemy spawned with")
		data = data.duplicate()
		get_node("Sprite").texture = data.sprite
	else:
		print("Monster data not set")
		queue_free()


func _process(delta):
	if is_moving:
		global_position = global_position.move_toward(
			Vector2(hero.global_position), delta * data.movement_speed
		)


func _physics_process(_delta):
	if is_attacking and attack_timer <= 0:
		attack_timer = data.attack_cooldown * 60
		hero.get_hit(data.damage)
		# print("Monster hit hero", data.damage)
	else:
		attack_timer -= 1


func _on_area_entered(_area: Area2D):
	attack_timer = data.attack_cooldown * 60
	is_attacking = true
	is_moving = false
	hero.get_hit(data.damage)
	hero.add_enemy(self)
	# print("Monster hit hero", data.damage)


func get_hit(damage: int) -> bool:
	data.health -= damage
	if data.health <= 0:
		MainManager.add_experience(10)
		return true
	return false


# Creates a new enemy instance based on provided data and template.
# @param input_data: A `DataMonster` object containing all the necessary data for the new monster
# @param input_monster_template: Template for creating new monsters.
# @return: Returns `Area2D` representing the newly created enemy
static func new_enemy(input_data: DataMonster, input_monster_template: PackedScene) -> Area2D:
	var new_monster: Area2D = input_monster_template.instantiate()
	new_monster.data = input_data.duplicate()
	return new_monster
