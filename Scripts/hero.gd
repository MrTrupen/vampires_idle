extends Area2D

var max_health: int = 1000
var health: int = 999999
var health_regeneration: int = 100
var attack_cooldown: float = 3
var attack_damage: int = 300

var attack_timer: float = 0
var enemies_in_range: Array = []


func _ready():
	health = max_health


## Called when the hero is hit by a monster [br]
## @param damage: The amount of damage the hero takes
func get_hit(damage: int):
	health -= damage
	MainManager.add_blood(damage)
	# print("Hero hit by monster", health)


func _physics_process(_delta):
	health += health_regeneration
	if health > max_health:
		health = max_health

	if attack_timer <= 0:
		attack_timer = attack_cooldown * 60
		hit_all_enemies()
	else:
		attack_timer -= 1


func add_enemy(enemy: Area2D):
	enemies_in_range.append(enemy)
	print("Enemy added to range")


func hit_all_enemies():
	for enemy in enemies_in_range:
		if enemy.get_hit(attack_damage):
			enemies_in_range.erase(enemy)
			enemy.queue_free()
			print("Enemy killed")
		else:
			print("Enemy survived")
