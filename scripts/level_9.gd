extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.main_menu_music_enabled:
		$LevelMusic.play() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass  

func _on_hidegroundtrigger_body_entered(body: Node2D) -> void:
		if body.name == "Player":
			$TrollGround.hide()
			$TrollGround/Ground2.collision_layer = 0
			$TrollGround/Ground2.collision_mask = 0
			await get_tree().create_timer(1.2).timeout
			$TrollGround.show()
			$TrollGround/Ground2.collision_layer = 1
			$TrollGround/Ground2.collision_mask = 1
			

func _on_gone_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property($TrollGround/Ground2, "scale", Vector2(0.05, 0.05), 1.2)
		await tween.finished
		$TrollGround/Ground5.collision_layer = 0
		$TrollGround/Ground5.collision_mask = 0
		await get_tree().create_timer(0.5).timeout
		var next_tween = create_tween()
		next_tween.tween_property($TrollGround/Ground3, "scale", Vector2(0.05, 0.05), 1.2)
		await next_tween.finished
		$TrollGround/Ground3.collision_mask = 0
		await get_tree().create_timer(0.3).timeout
		$TrollGround/Ground5.collision_layer = 1
		$TrollGround/Ground5.collision_mask = 1
		
func show_win_screen():
	Settings.highest_unlocked_level = max(Settings.highest_unlocked_level, 10)
	Settings.save_progress()
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level10.tscn")
		
		
	
