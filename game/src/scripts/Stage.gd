extends Node2D

var is_game_over = false

var asteroid = preload("res://src/scenes/Asteroid.tscn")

var screen_width
var screen_height

var score = 0

func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_enter") and is_game_over:
		get_tree().reload_current_scene()

func _on_player_destroyed() -> void:
	$CanvasLayer/UI/Ready.visible = true
	is_game_over = true

func _on_spawn_timer_timeout() -> void:
	var asteroid_instance = asteroid.instance()
	asteroid_instance.position = Vector2(screen_width + 8, rand_range(0, screen_height))
	add_child(asteroid_instance)

func _on_player_score() -> void:
	score += 1
	$CanvasLayer/UI/Score.text = "Score: " + str(score)
