extends Node2D

var shrinking = false

# Called when the node enters the scene tree for the first time.
var collision_start_position: Vector2

func _ready() -> void:
	var collision = $ShrinkingGround/CollisionShape2D
	
	collision.shape = collision.shape.duplicate()
	collision.scale = Vector2.ONE
	collision.shape.size = Vector2(450, 40)
	
	collision_start_position = collision.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_platform_drop_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property($MovingGround, "position:y", $MovingGround.position.y + 400, 0.8)


func _on_shrink_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not shrinking:
		shrinking = true
		
		var tween = create_tween()
		tween.tween_method(shrink_platform, 0.0, 1.0, 3)
		
func shrink_platform(amount: float) -> void:
	var left_x = lerp(-225.0, 210.0, amount)

	$ShrinkingGround/Polygon2D.polygon = PackedVector2Array([
		Vector2(left_x, -20),
		Vector2(225, -20),
		Vector2(225, 20),
		Vector2(left_x, 20)
	])

	var width = 225.0 - left_x
	var center_x = (left_x + 225.0) / 2.0

	$ShrinkingGround/CollisionShape2D.shape.size.x = width
	$ShrinkingGround/CollisionShape2D.position.x = collision_start_position.x + center_x


func _on_spike_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var tween = create_tween()
		tween.tween_property(
			$Spike,
			"global_position:x",
			$SpikeTrigger.global_position.x,
			0.3
		)
		
func show_win_screen():
	$Player.set_physics_process(false)
	$UI/WinnerScreen.show()
	
func _on_next_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level4.tscn")
