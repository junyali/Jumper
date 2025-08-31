extends Node2D

@onready var player = $Player
@onready var spikes = $Spikes
@onready var platforms = $Platforms

var game_paused: bool = false

func _ready() -> void:
	spikes.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	game_paused = true
	show_death_scene()
	player.set_physics_process(false)
	platforms.set_process(false)

func show_death_scene() -> void:
	var death_label: Label = Label.new()
	death_label.text = "You died :c. Press Enter to restart"
	death_label.position = Vector2(0, 32) + player.global_position
	add_child(death_label)

func _input(event) -> void:
	if game_paused and event.is_action_pressed("ui_accept"):
		restart_game()

func restart_game() -> void:
	game_paused = false
	get_tree().reload_current_scene()
