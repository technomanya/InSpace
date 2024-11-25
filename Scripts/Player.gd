extends Area2D

@export var sideSpeed : float = 10
@export var damage : int = 1

@onready var debug_log_label: Label = $"../DebugLog"

var target_position: Vector2 = Vector2.ZERO
var is_touch_active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	if is_touch_active:
		position.x = target_position.x
		position.x = clamp(position.x,60,490)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			is_touch_active = true
			target_position = event.position
		else:
			is_touch_active = false
	elif event is InputEventScreenDrag:
		is_touch_active = true
		target_position = event.position

func debug_log(_text : String) -> void:
	debug_log_label.text = _text


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_parent().game_over()
		print("Die")
		queue_free()
