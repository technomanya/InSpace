extends Area2D

@export var damage : int = 1

var speed : float = 100

func _ready() -> void:
	speed = get_parent().bullet_speed

func _process(delta: float) -> void:
	position.y -= speed*delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		queue_free() # Replace with function body.
