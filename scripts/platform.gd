extends CharacterBody2D
class_name Platform

@export var fall_speed: float = 100.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.y += fall_speed * delta

	if position.y > 560:
		queue_free()
