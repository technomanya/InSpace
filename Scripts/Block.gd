extends Control

@export var colors : Array[Color]

@onready var block: Control = $"."
@onready var health_label: Label = $HealthLabel

var block_health : int
var block_point : int

func _ready() -> void:
	$BackGround.color = colors[randi() % colors.size()]
	block_health = randi_range(get_parent().block_health_min,get_parent().block_health_max)
	block_point = int(block_health/2)*10
	
	health_label.text = str(block_health)
		
func _process(delta: float) -> void:
	position.y += get_parent().block_speed*delta
	
func hit(damage:int) -> void :
	block_health -= damage;
	health_label.text = str(block_health)
	if block_health <= 0:
		get_parent().update_score(block_point)
		queue_free()


func _on_body_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		hit(area.damage)
