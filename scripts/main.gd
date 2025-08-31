extends Node2D

@onready var player = $Player
@onready var spikes = $Spikes
@onready var platforms = $Platforms

var game_paused: bool = false
var score: float = 0.0
var game_time: float = 0.0

func _ready() -> void:
	spikes.player_died.connect(_on_player_died)
	
func _process(delta: float) -> void:
	if not game_paused:
		var multiplier = calculate_position_multiplier()
		score += delta * multiplier * 100 # because bigger scores are k00l!!
		game_time += delta
		print(score, game_time)

func _on_player_died() -> void:
	player.get_node("DeathSound").play()
	game_paused = true
	show_death_scene()
	player.set_physics_process(false)
	platforms.set_process(false)

func _input(event) -> void:
	if game_paused and event.is_action_pressed("ui_accept"):
		restart_game()

func show_death_scene() -> void:
	var death_label: Label = Label.new()
	death_label.text = "You died :c, Score was %.1f - you survived for %.1f seconds. Press Enter to restart" % [score, game_time]
	death_label.size = Vector2(200, 100)
	death_label.position = Vector2(-300, 0) + player.global_position
	death_label.add_theme_font_size_override("font_size", 8)
	death_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	death_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	add_child(death_label)

func restart_game() -> void:
	game_paused = false
	get_tree().reload_current_scene()

func calculate_position_multiplier() -> float:
	var player_y = player.global_position.y
	var clamped_y = clamp(player_y, -560, 560)
	var normalised = (clamped_y + 560) / 1120.0

	return normalised
