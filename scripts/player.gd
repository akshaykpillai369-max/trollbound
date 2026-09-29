extends CharacterBody2D


const SPEED = 250.0
var current_speed = SPEED
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
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * current_speed
		$AnimatedSprite2D.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
	if position.y > 380:
		die()

func die():
	set_physics_process(false)
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	get_tree().current_scene.get_node("UI/DeathScreen").show()


func _on_troll_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var troll_ground = get_parent().get_node_or_null("TrollGround")
		
		if troll_ground:
			troll_ground.queue_free()
