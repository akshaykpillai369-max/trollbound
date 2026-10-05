extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.level_music_enabled:
		$LevelMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 8)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level8.tscn")


func _on_chase_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property(
			$RightSideGround,
			"position:x",
			$RightSideGround.position.x - 520,
			1.8
		)

func _on_death_trigger_body_entered(body: Node2D) -> void:
	$DeathTriggerGround.show()
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property(
			$DeathTriggerGround,
			"position:x",
			$DeathTriggerGround.position.x + 125,
			0.6
		)
		await tween.finished
		await get_tree().create_timer(0.5).timeout
		$DeathTriggerGround/DeathTrigger.monitoring = false
		$DeathTriggerGround/DeathTrigger/CollisionShape2D.disabled = true
		$DeathTriggerGround/CollisionShape2D.disabled = true
		$DeathTriggerGround.hide()
		
