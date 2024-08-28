extends Area2D

@export var data: DataMonster

var moving: bool = true
var attacking: bool = false

var attack_timer: float = 0

@onready var target: Area2D = %Hero


func _ready():
	data = data.duplicate()
	get_node("Sprite").texture = data.sprite


func _process(delta):
	if moving:
		position = position.move_toward(Vector2(target.position), delta * data.movement_speed)


func _physics_process(_delta):
	if attacking and attack_timer <= 0:
		attack_timer = data.attack_cooldown * 60
		target.get_hit(data.damage)
		print("Monster hit hero", data.damage)
	else:
		attack_timer -= 1


func _on_area_entered(_area: Area2D):
	attack_timer = data.attack_cooldown * 60
	attacking = true
	moving = false
	target.get_hit(data.damage)
	print("Monster hit hero", data.damage)
