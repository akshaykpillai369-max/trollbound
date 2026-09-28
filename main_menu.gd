extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

const TIME_TO_DISPLAY_SECONDS: float = 1

@onready var label = $Title

func _ready() -> void:
	label.visible_ratio = 0.0
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label, "visible_ratio", 1.0, TIME_TO_DISPLAY_SECONDS)
	
func _on_play_button_pressed() -> void:
	
	get_tree().change_scene_to_file('res://levels/level1.tscn')
	
