extends Node2D

var is_game_over = false

var asteroid = preload("res://src/scenes/Asteroid.tscn")

var screen_width
var screen_height

var score = 0

func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("ui_quit"):
			get_tree().quit()
		if is_game_over and event.is_action("ui_enter"):
			get_tree().change_scene("res://src/scenes/Stage.tscn")

func _on_player_destroyed() -> void:
	get_node("CanvasLayer/UI/Ready").show()
	is_game_over = true

func _on_spawn_timer_timeout() -> void:
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(screen_width + 8, rand_range(0, screen_height))
	add_child(asteroid_instance)

func _on_player_score() -> void:
	score += 1
	$CanvasLayer/UI/Score.text = "Score: " + str(score)
