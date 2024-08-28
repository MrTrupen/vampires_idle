class_name AttackComponent
extends Area2D


func _on_area_entered(area: Area2D):
	if area.has_method("get_hit"):
		area.get_hit(10)
		print("get_hit method found")
	else:
		print("No get_hit method found")

# func _physics_process(delta):
# 	pass
