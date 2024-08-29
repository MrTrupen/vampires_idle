extends Area2D

var max_health: int = 1000
var health: int = 999999
var health_regeneration: int = 1


func _ready():
	health = max_health


## Called when the hero is hit by a monster [br]
## @param damage: The amount of damage the hero takes
func get_hit(damage: int):
	health -= damage
	MainManager.add_blood(damage)
	print("Hero hit by monster", health)


func _physics_process(_delta):
	health += health_regeneration
	if health > max_health:
		health = max_health
