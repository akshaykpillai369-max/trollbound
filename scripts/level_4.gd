extends Node2D

var door_moved = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hover_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		$HoverGround.show()
		tween.tween_property(
			$HoverGround,
			"position:y",
			$HoverGround.position.y - 300,
			2.0
		)

func show_win_screen():
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if not door_moved:
			$Exit.position.x -= 574
			$ReturnSpike.show()
			$ReturnSpike.monitoring = true
			$ReturnSpike/ControlResetTrigger.monitoring = true
			door_moved = true
			
		else:
			$Exit/Door.play()
			$Exit/DoorSound.play()
			await $Exit/Door.animation_finished
			show_win_screen()


func _on_control_reset_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.reverse_controls = false
