extends Marker2D

const bullet = preload("res://Scenes/Bullet.tscn")
@onready var player: Area2D = $".."
	
func shoot() -> void:
	var bullet_temp = bullet.instantiate()
	
	bullet_temp.damage = player.damage
	get_node("../..").add_child(bullet_temp)
	bullet_temp.global_position = global_position


func _on_fire_rate_timer_timeout() -> void:
	shoot() # Replace with function body.
