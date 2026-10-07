extends Node2D

var ending_started = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Settings.main_menu_music_enabled:
		$LevelMusic.play() 
	$Player.set_physics_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ground_open_trigger_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer":
		var tween = create_tween()
		tween.tween_property(
			$Ground3,
			"position:x",
			$Ground3.position.x + 200,
			0.3
		)
		await tween.finished
		$GroundOpenTrigger.monitoring = false


func _on_spike_trigger_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer":
		$Spike.show()


func _on_spike_trigger_1_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer":
		$Spike2.show()


func _on_spike_trigger_2_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer":
		$Spike3.show()


func _on_ground_free_trigger_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer":
		var tween = create_tween()
		tween.tween_property(
			$Ground7,
			"position:y",
			$Ground7.position.y + 200,
			0.3
		)
func play_ending():
	$UI/GameEnd.show()
	await type_text($UI/GameEnd/Title, "TROLLBOUND")
	await type_text($UI/GameEnd/WinMessage, "You made it to the end.\nYou survived every trap,\n troll and trick.")
	await type_text($UI/GameEnd/Thanks, "Thank you for playing.\n\nHave a nice day :)")

	await get_tree().create_timer(2.0).timeout
	var fade = create_tween()
	fade.tween_property($UI/GameEnd, "modulate:a", 0.0, 2.0)

	await fade.finished

	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func type_text(label: Label, text: String):
	label.text = ""
	label.modulate.a = 1.0

	for character in text:
		label.text += character
		await get_tree().create_timer(0.05).timeout
	
func _on_pause_button_pressed() -> void:
	$UI/PauseMenu.show()
	get_tree().paused = true
	
func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level12.tscn")


func _on_win_area_body_entered(body: Node2D) -> void:
	if body.name == "DoorPlayer" and not ending_started:
		ending_started = true
		body.set_physics_process(false)
		play_ending()
