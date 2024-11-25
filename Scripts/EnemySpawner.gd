extends Area2D

@onready var enemy = preload("res://Scenes/Block.tscn")


func spawn_enemy() -> void:
	var rngx = randi_range(45,495)
	var temp_enemy = enemy.instantiate()
	temp_enemy.position = Vector2(rngx,position.y)
	temp_enemy.size = Vector2(100,100)
	get_parent().add_child(temp_enemy)
	

func _on_enemy_spawn_timer_timeout() -> void:
	spawn_enemy()
