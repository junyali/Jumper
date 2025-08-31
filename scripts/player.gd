extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -600.0
@export var COYOTE_TIME: float = 0.2

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

var coyote_timer: float = 0.0
var was_on_floor_last_frame: bool = false

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_coyote_time(delta)
	handle_input()
	handle_animation()

	move_and_slide()
	
	was_on_floor_last_frame = is_on_floor()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_coyote_time(delta: float) -> void:
	if is_on_floor():
		coyote_timer = COYOTE_TIME
	elif was_on_floor_last_frame and not is_on_floor():
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta

func handle_input() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_timer > 0:
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0
			jump_sound.play()

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func handle_animation() -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
		
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
	elif velocity.x != 0:
		sprite.play("run")
	else:
		sprite.play("idle")
