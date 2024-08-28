extends Area2D

#init as a backup monster called "bug" in case
@export var data: DataMonster = preload("res://Resources/bug.tres")

var is_moving: bool = true
var is_attacking: bool = false

var attack_timer: float = 0

@onready var hero: Area2D = MainManager.hero


func _ready():
	if data:
		data = data.duplicate()
		get_node("Sprite").texture = data.sprite
	else:
		print("Monster data not set")
		queue_free()


func load_data(input_data: DataMonster):
	self.data = input_data.duplicate()
	get_node("Sprite").texture = data.sprite


func _process(delta):
	if is_moving:
		global_position = global_position.move_toward(
			Vector2(hero.global_position), delta * data.movement_speed
		)


func _physics_process(_delta):
	if is_attacking and attack_timer <= 0:
		attack_timer = data.attack_cooldown * 60
		hero.get_hit(data.damage)
		print("Monster hit hero", data.damage)
	else:
		attack_timer -= 1


func _on_area_entered(_area: Area2D):
	attack_timer = data.attack_cooldown * 60
	is_attacking = true
	is_moving = false
	hero.get_hit(data.damage)
	print("Monster hit hero", data.damage)
