extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -600.0

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_input()
	handle_animation()

	move_and_slide()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_input() -> void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY

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
