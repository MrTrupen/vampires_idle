extends Control

@export var monster_data: DataMonster
@export var spawner: Node2D = null


func _ready():
	if !monster_data:
		print("Monster data not set")
		queue_free()
	else:
		restart()


func restart() -> void:
	%SpawnerName.text = monster_data.name

	# reset upgrades
	%HealthStat.text = str(monster_data.get_health())
	%RespawnCooldownStat.text = str(monster_data.get_respawn_cooldown())
	%SpawnLimitStat.text = str(monster_data.get_spawn_limit())

	# reset prices
	%BuyHealth.text = str(monster_data.health_upgrade_price)
	%BuyRespawnCooldown.text = str(monster_data.respawn_cooldown_upgrade_price)
	%BuySpawnLimit.text = str(monster_data.spawn_limit_upgrade_price)


func _on_buy_health_pressed():
	monster_data.health_upgrade += 100
	%HealthStat.text = str(monster_data.get_health())
	%BuyHealth.text = str(monster_data.health_upgrade_price)


func _on_buy_respawn_cooldown_pressed():
	monster_data.respawn_cooldown_upgrade -= 0.1
	%RespawnCooldownStat.text = str(monster_data.get_respawn_cooldown())
	%BuyRespawnCooldown.text = str(monster_data.respawn_cooldown_upgrade_price)


func _on_buy_spawn_limit_pressed():
	monster_data.spawn_limit_upgrade += 1
	%SpawnLimitStat.text = str(monster_data.get_spawn_limit())
	%BuySpawnLimit.text = str(monster_data.spawn_limit_upgrade_price)
