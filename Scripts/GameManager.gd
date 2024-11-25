extends Node

@onready var player_data : PlayerData = preload("res://Resources/main_player_data.tres")

func _process(delta: float) -> void:
	if player_data.player_energy < 100:
		player_data.player_energy += 1

func increase_coin() -> void:
	player_data.player_coins +=1
	player_data.player_energy -=1
