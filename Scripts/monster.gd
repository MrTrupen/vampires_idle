extends Node2D

@export var data: DataMonster

var moving: bool = true
var attacking: bool = false

var attack_timer: float = 0

@onready var target: Node2D = %Hero


func _ready():
	data = data.duplicate()
	get_node("Sprite").texture = data.monster_sprite
	data.hitbox_component = get_node("HitboxComponent")
	data.attack_component = get_node("AttackComponent")


func _process(delta):
	if moving:
		position = position.move_toward(Vector2(target.position), delta * data.movement_speed)
