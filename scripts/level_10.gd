extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.main_menu_music_enabled:
		$LevelMusic.play() 
	$Player.current_speed = 200.0
	$Player.current_jump_velocity = -400.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ground_move_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property(
			$StaticBody2D2,
			"position",
			$StaticBody2D2.position + Vector2(400, 0),
			0.3
		)
		await tween.finished
		await get_tree().create_timer(0.5).timeout
		var up_tween = create_tween()
		up_tween.tween_property(
			$StaticBody2D,
			"position",
			$StaticBody2D.position + Vector2(100, -88),
			0.5
		)
		
	


func _on_player_hit_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property(
			$StaticBody2D4,
			"position",
			$StaticBody2D4.position + Vector2(-250, 0),
			0.5
		)
		await tween.finished
		$StaticBody2D4/PlayerHitTrigger.monitoring = false
		await get_tree().create_timer(0.5).timeout
		
		var right_tween = create_tween()
		right_tween.tween_property(
			$StaticBody2D4,
			"position",
			$StaticBody2D4.position + Vector2(+250, 0),
			0.5
		)


func _on_spike_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Spike.show()


func _on_ground_fall_trigger_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(0.3).timeout
	if body.name == "Player":
		$Spike.hide()
		var tween = create_tween()
		tween.tween_property($StaticBody2D, "position:y", $StaticBody2D.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D2, "position:y", $StaticBody2D2.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D3, "position:y", $StaticBody2D3.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D4, "position:y", $StaticBody2D4.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D5, "position:y", $StaticBody2D5.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D6, "position:y", $StaticBody2D6.position.y + 400, 0.4)
		tween.tween_property($StaticBody2D8, "position:y", $StaticBody2D8.position.y - 100, 0.5)


func _on_ground_gone_2_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property($StaticBody2D7, "position:y", $StaticBody2D7.position.y + 400, 0.4)

func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 11)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
