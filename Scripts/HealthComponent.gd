class_name HealthComponent
extends Node

var max_health: int = 999999
var health: int = 999999


func _ready():
	health = max_health


## Called when object is hit [br]
## @param recived_damage: The amount of damage the object takes
func get_hit(recived_damage: int):
	health -= recived_damage
	print("Object hit Health: ", health, " Damage: ", recived_damage)

	if health <= 0:
		print("Object died")
		get_parent().queue_free()
