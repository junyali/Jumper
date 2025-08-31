extends Node2D

@export var platform_scenes: Array[PackedScene] = []
@export var spawn_interval: float = 1.0
@export var spawn_height: float = -560.0

@onready var spawn_timer: Timer = $Spawner

var last_platform_type: String = "full"

func _ready() -> void:
	load_platform_scenes()

	spawn_timer.wait_time = spawn_interval

func _process(delta: float) -> void:
	pass

func load_platform_scenes() -> void:
	platform_scenes = [
		preload("res://scenes/platforms/smallmiddlegap.tscn"),
		preload("res://scenes/platforms/mediummiddlegap.tscn"),
		preload("res://scenes/platforms/bigmiddlegap.tscn"),
		preload("res://scenes/platforms/largemiddlegap.tscn"),
		preload("res://scenes/platforms/largestmiddlegap.tscn"),
		preload("res://scenes/platforms/islandleft.tscn"),
		preload("res://scenes/platforms/islandmiddle.tscn"),
		preload("res://scenes/platforms/islandright.tscn"),
		preload("res://scenes/platforms/multiplegap_a.tscn"),
		preload("res://scenes/platforms/multiplegap_b.tscn"),
		preload("res://scenes/platforms/multiplegap_c.tscn")
	]

func _on_spawner_timeout() -> void:
	if platform_scenes.size() > 0:
		var random_platform = platform_scenes.pick_random()
		var platform = random_platform.instantiate()
		last_platform_type = platform.name
		add_child(platform)
		platform.position = Vector2(0, spawn_height)
