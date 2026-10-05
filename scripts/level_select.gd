extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LevelButtons/Level2Button.disabled = Settings.highest_unlocked_level < 2
	$LevelButtons/Level3Button.disabled = Settings.highest_unlocked_level < 3
	$LevelButtons/Level4Button.disabled = Settings.highest_unlocked_level < 4
	$LevelButtons/Level5Button.disabled = Settings.highest_unlocked_level < 5
	if Settings.main_menu_music_enabled:
		$MenuMusic.playing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level1.tscn")


func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level2.tscn")


func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level3.tscn")


func _on_level_4_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level4.tscn")


func _on_level_5_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level5.tscn")
