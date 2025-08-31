extends Area2D

signal player_died

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_died.emit()
