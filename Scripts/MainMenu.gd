extends Control

@onready var coins_label: Label = $Coins

@export var player_data : PlayerData

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_clicker_pressed() -> void:
	if player_data.player_energy > 0:
		GameManager.increase_coin()
	print(player_data.player_coins)
	coins_label.text = "Coins: " + str(player_data.player_coins)
