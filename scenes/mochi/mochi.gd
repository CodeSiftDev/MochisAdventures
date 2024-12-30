extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction != 0:
		velocity.x = direction * SPEED
		# Flip sprite based on the movement direction
		_animated_sprite.flip_h = direction < 0  # Flip horizontally if moving left
		# Set the running animation (assuming it's named "run")
		_animated_sprite.play("walk")  # Change to your actual running animation name
	else:
		# If no input, stop horizontal movement gradually (decelerate)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# Set the idle animation
		_animated_sprite.play("idle")  # Change to your actual idle animation name


	move_and_slide()
