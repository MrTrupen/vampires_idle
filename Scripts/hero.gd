extends Area2D

var max_health: int = 1000
var health: int = 999999
var health_regeneration: int = 100
var attack_cooldown: float = 0.15
var attack_damage: int = 25

var attack_timer: float = 0
var enemies_in_range: Array = []

@onready var health_bar: ProgressBar = $HealthBar


func _ready():
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = max_health


func respawn_hero():
	health = max_health
	health_bar.value = max_health
	enemies_in_range = []


## Called when the hero is hit by a monster [br]
## @param damage: The amount of damage the hero takes
func get_hit(damage: int):
	health -= damage
	health_bar.value = health
	MainManager.add_blood(damage)
	if health <= 0:
		MainManager.hero_died()
		respawn_hero()


func _physics_process(_delta):
	health += health_regeneration
	if health > max_health:
		health = max_health

	if attack_timer <= 0:
		attack_timer = attack_cooldown * 60
		hit_all_enemies()
	else:
		attack_timer -= 1


func hit_all_enemies():
	for enemy in enemies_in_range:
		if enemy.get_hit(attack_damage):
			enemies_in_range.erase(enemy)
			print("Enemy killed")
		else:
			pass
			# print("Enemy survived")


func _on_area_entered(area: Area2D):
	enemies_in_range.append(area)
	# print("monser entered area")
