extends StaticBody2D
class_name Platform

@export var fall_speed: float = 100.0

func _ready() -> void:
	fall_speed += randf_range(-10, 20)

func _process(delta: float) -> void:
	position.y += fall_speed * delta

	if position.y > 560:
		queue_free()
