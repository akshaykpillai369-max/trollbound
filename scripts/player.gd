extends CharacterBody2D


const SPEED = 250.0
@export var current_speed = SPEED
@export var reverse_controls := false
const JUMP_VELOCITY = -400.0
var current_jump_velocity = JUMP_VELOCITY
@export var death_y = 382.0
var gravity_flipped := false
@export var both_directions_right := false
var ceiling_locked := false
var flap_started := false
@export var flap_mode := false


func _physics_process(delta: float) -> void:
	if gravity_flipped:
		up_direction = Vector2.DOWN
	else:
		up_direction = Vector2.UP

	if not is_on_floor():
		if gravity_flipped:
			velocity.y = 0
		else:
			velocity += get_gravity() * delta

	if flap_mode:
		if Input.is_action_just_pressed("ui_accept"):
			flap_started = true
			velocity.y = current_jump_velocity
			$JumpSound.play()
	else:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not ceiling_locked:
			if gravity_flipped:
				gravity_flipped = false
				up_direction = Vector2.UP
				$AnimatedSprite2D.flip_v = false
				velocity.y = abs(current_jump_velocity)
			else:
				velocity.y = current_jump_velocity

			$JumpSound.play()

	var direction := Input.get_axis("ui_left", "ui_right")

	if flap_mode:
		if flap_started:
			direction = 1
		else:
			direction = 0

	if both_directions_right:
		direction = abs(direction)

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

	if not flap_mode and not gravity_flipped and is_on_ceiling():
		gravity_flipped = true
		velocity.y = 0
		$AnimatedSprite2D.flip_v = true

	if position.y > death_y:
		die()

func die():
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Death")
	$DeathSound.play()
	await $AnimatedSprite2D.animation_finished
	get_tree().current_scene.get_node("UI/DeathScreen").show()
