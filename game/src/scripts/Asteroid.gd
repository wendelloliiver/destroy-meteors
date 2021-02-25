extends Area2D

var explosion_scene = preload("res://src/scenes/Explosion.tscn")
var current_scene = 0

var move_speed = 75
var score_emitted = false

var direction

func _ready() -> void:
	randomize()
	
	direction = rand_range(0, 9)

func _process(delta: float) -> void:
	position -= Vector2(move_speed * delta, 0)
	
	if position.x <= -100:
		queue_free()
	

	if direction <= 4:
		rotation -= 0.005
	else:
		rotation += 0.005

func _on_asteroid_area_entered(area: Area2D) -> void:
	if area.is_in_group("shot") or area.is_in_group("player"):
		if not score_emitted:
			score_emitted = true
			queue_free()
			
			var stage_node = get_parent()
			var explosion_instance = explosion_scene.instance()
			
			explosion_instance.frame = current_scene
			
			explosion_instance.position = position
			stage_node.add_child(explosion_instance)
