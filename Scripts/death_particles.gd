extends CPUParticles2D


func _on_timer_timeout():
	get_parent().queue_free()
