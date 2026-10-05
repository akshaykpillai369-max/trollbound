extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.level_music_enabled:
		$LevelMusic.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_speed_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Player.current_speed = 900.0


func _on_return_trap_body_entered(body: Node2D) -> void:
	if body.name == "Player" and body.velocity.x < 0:
		$PlatformSound.play()
		$Ground.queue_free()


func _on_hidden_ground_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$HiddenGround.show()
		$HiddenGround/CollisionShape2D.disabled = false
		$Exit.show()
		
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 3)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level3.tscn")


func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
