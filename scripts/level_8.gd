extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.main_menu_music_enabled:
		$LevelMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_move_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(0.5).timeout
		var tween = create_tween()
		tween.tween_property(
			$MovingGround,
			"position:x",
			$MovingGround.position.x + 250,
			1.8
		)
		await tween.finished
		$MovingGround/Ground2.queue_free()
		
		await get_tree().create_timer(0.5).timeout
		var next_tween = create_tween()
		next_tween.tween_property(
			$MovingGround,
			"position:x",
			$MovingGround.position.x + 250,
			1.8
		)
		
		await next_tween.finished
		$MovingGround/Ground4.queue_free()
		
		await get_tree().create_timer(0.5).timeout
		var next_next_tween = create_tween()
		next_next_tween.tween_property(
			$MovingGround,
			"position:x",
			$MovingGround.position.x + 250,
			1.8
		)
		await next_next_tween.finished
		await get_tree().create_timer(1).timeout
		$MovingGround/Ground3.queue_free()
		
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 7)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level9.tscn")
		
		
		
