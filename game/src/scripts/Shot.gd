extends Area2D

const MOVE_SPEED = 500
var screen_width

func _ready() -> void:
	screen_width = get_viewport_rect().size.x

func _process(delta: float) -> void:
	position += Vector2(MOVE_SPEED * delta, 0)
	if position.x >= screen_width + 8:
		queue_free()

func _on_shot_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroid"):
		queue_free()
