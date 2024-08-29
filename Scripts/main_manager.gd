extends Node

# Resources
var blood: int = 0
var experience: int = 0

@onready var hero: Area2D = get_node("/root/MainScene/Hero")
@onready var blood_counter: Label = get_node("/root/MainScene/Background/Blood_counter")
@onready var experience_counter: Label = get_node("/root/MainScene/Background/Experience_counter")


func _ready():
	add_blood(0)
	add_experience(0)


func add_blood(amount: int) -> void:
	blood += amount
	blood_counter.text = "Blood: " + str(blood)


func add_experience(amount: int) -> void:
	experience += amount
	experience_counter.text = "Experience: " + str(experience)
