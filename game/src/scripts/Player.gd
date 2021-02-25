extends Area2D

const MOVE_SPEED = 150

var screen
var screen_width
var screen_height

var shot_scene = preload("res://src/scenes/Shot.tscn")
var can_shot = true

signal destroyed

func _ready() -> void:
	screen = get_viewport_rect().size
	
	screen_width = screen.x
	screen_height = screen.y
	

func _process(delta: float) -> void:
	var dir = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		dir.y += 1
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		dir.x += 1
	
	position += (MOVE_SPEED * delta) * dir
	
	check_collision()

func check_collision() -> void:
	if position.x < 0:
		position.x = 0
	elif position.x > screen_width:
		position.x = screen_width
	if position.y < 0:
		position.y = 0
	elif position.y > screen_height:
		position.y = screen_height

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action("ui_shot") and can_shot:
			var stage_node = get_parent()
			var shot_instance = shot_scene.instance()
			
			shot_instance.position = $PositionShot.global_position
			stage_node.add_child(shot_instance)
			
			can_shot = false
			$ReloadTimer.start()

func _on_reload_timeout() -> void:
	can_shot = true

func _on_player_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		queue_free()
