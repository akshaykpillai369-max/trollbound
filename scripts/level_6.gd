extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.level_music_enabled:
		$LevelMusic.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_death_ground_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()


func _on_trap_spike_trigger_body_entered(body: Node2D) -> void:
	$TrapSpike.show()
	
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 7)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
