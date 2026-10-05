extends Node2D

var door_moved := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.level_music_enabled:
		$LevelMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spike_show_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$CeilingSpike.show()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.current_jump_velocity = -2000.0

func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 6)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level6.tscn")


func _on_door_move_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not door_moved:
			door_moved = true
			body.ceiling_locked = true
			body.current_speed = 100.0
			$ChasingSpike.show()
			$ChasingSpike.monitoring = true
			
			var tween = create_tween()
			tween.tween_property(
				$Exit,
				"position",
				$Exit.position + Vector2(400, 0),
				0.3
			)
			
			var spike_tween = create_tween()
			spike_tween.tween_property(
				$ChasingSpike,
				"position:x",
				$ChasingSpike.position.x + 1000,
				5.0
			)
