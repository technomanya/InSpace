extends Node

@export var bullet_speed : float = 500
@export var block_speed : float = 150
@export var block_health_min : int = 10
@export var block_health_max : int = 20

@onready var block = preload("res://Scenes/Block.tscn")
@onready var player: Area2D = $Player
@onready var score_label: Label = $UI/ScoreLabel
@onready var game_over_ui: Control = $GameOverUI



var player_point : int
var blocks_amount : int = 0
var save_path : String = "user://save_game.save"

func _ready() -> void:
	game_over_ui.hide()
	#var load_data = load_score()
	#score_label.text = str(load_data)

func game_over() -> void:
	save_score()
	game_over_ui.show()
	get_tree().paused = true

func update_score(score : int) -> void:
	player_point += score
	score_label.text = "Score: " + str(player_point)

func save_score():
	var save_data = {
		"player_score" : player_point
	}
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	
func load_score() -> int:
	var file = FileAccess.open(save_path,FileAccess.READ)
	var data = file.get_as_text()
	var parseData = JSON.parse_string(data)
	if parseData:
		file.close()
		return parseData["player_score"]
	else:
		return 0
	
func _on_block_spawn_timer_timeout() -> void:
	block_speed += 1
	if player_point >= 0 and player_point<200:
		blocks_amount = 1
		
	elif player_point >=200 and player_point < 500:
		blocks_amount = randi_range(1,2)
		player.damage = 2
		block_health_min = 15
		block_health_max = 25
		
	elif player_point >=500 and player_point < 1000:
		blocks_amount = randi_range(2,3)
		
	elif player_point >=1000 and player_point < 2000:
		blocks_amount = randi_range(2,4)
		player.damage = 3
		block_health_min = 20
		block_health_max = 30
		
	elif player_point >=2000 and player_point < 5000:
		blocks_amount = randi_range(1,5)
		player.damage = 4
		block_health_min = 30
		block_health_max = 40
		
	else:
		blocks_amount = randi_range(3,5)
		player.damage = 5
		block_health_min = 40
		block_health_max = 50
			
	var spots : Array[int] = []
	
	for i in range(blocks_amount):
		var random_spot : int = randi() % 5
		
		while spots.find(random_spot) != -1:
			random_spot = randi() % 5
		
		spots.append(random_spot)
		
	var init_pos = Vector2(20,-100)
	for i in spots:
		var temp_block = block.instantiate()
		temp_block.position = init_pos + (Vector2(100,0)*i)
		add_child(temp_block)
		temp_block.size = Vector2(100,100)


func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene() # Replace with function body.


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenuScene.tscn")
