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
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()	


func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level2.tscn")


func _on_troll_trigger_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$TrollSpike.show()
		$TrollSpike.monitoring = true

func _on_troll_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$PlatformSound.play()
		$TrollGround.queue_free()
