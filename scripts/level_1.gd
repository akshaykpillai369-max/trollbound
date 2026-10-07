extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.level_music_enabled:
		$LevelMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 2)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()	

func _on_troll_trigger_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$TrollSpike.show()
		$TrollSpike.monitoring = true

func _on_troll_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$PlatformSound.play()
		$TrollGround.queue_free()


func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
