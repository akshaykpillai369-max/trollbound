extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shrink_trigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.current_speed = 300.0
		await get_tree().create_timer(1.0).timeout
		var tween = create_tween()
		tween.tween_property($Sprite2D, "scale", Vector2(0.05, 0.05), 1.2)
		await tween.finished
		$CollisionShape2D.disabled = true
