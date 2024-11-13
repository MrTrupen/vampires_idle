extends Node

# Resources
var blood: int = 0
var experience: int = 0

# Global variables
var alive_enemies = {"Bug": 0, "Deer": 0, "Flesh golem": 0, "Scyther rider": 0}

@onready var hero: Area2D = get_node("/root/MainScene/Hero")
@onready var blood_counter: Label = get_node("/root/MainScene/GUI/Blood_counter")
@onready var experience_counter: Label = get_node("/root/MainScene/GUI/Experience_counter")
@onready var enemies: Node = get_node("/root/MainScene/Enemies")


func _ready():
	add_blood(0)
	add_experience(0)


func add_blood(amount: int) -> void:
	blood += amount
	blood_counter.text = "Blood: " + str(blood)


func add_experience(amount: int) -> void:
	experience += amount
	experience_counter.text = "Experience: " + str(experience)


func hero_died():
	print("Hero died")
	blood = 0
	add_blood(0)
	alive_enemies = {"Bug": 0, "Deer": 0, "Flesh golem": 0, "Scyther rider": 0}
	for enemy in enemies.get_children():
		enemy.queue_free()
