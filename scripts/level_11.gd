extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.main_menu_music_enabled:
		$LevelMusic.play() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property(
		$ExitGround,
		"position:y",
		$ExitGround.position.y - 200,
		0.3
	)
	await tween.finished
	$ExitGround/Area2D.monitoring = false
	$Player.current_speed= 500



func _on_die_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Player.die()
		
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 12)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level12.tscn")
