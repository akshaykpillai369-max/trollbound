extends CharacterBody2D


const SPEED = 250.0
var current_speed = SPEED
const JUMP_VELOCITY = -400.0
@export var death_y = 382.0
@export var reverse_controls := false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if reverse_controls:
		direction = -direction
	if direction:
		velocity.x = direction * current_speed
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = direction < 0
		if not $RunSound.playing:
			$RunSound.play()
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		$AnimatedSprite2D.play("idle")
		$RunSound.stop()
	move_and_slide()
	if position.y > death_y:
		die()

func die():
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Death")
	$DeathSound.play()
	await $AnimatedSprite2D.animation_finished
	get_tree().current_scene.get_node("UI/DeathScreen").show()
