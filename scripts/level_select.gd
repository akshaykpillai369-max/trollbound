extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LevelButtons/Level2Button.disabled = Settings.highest_unlocked_level < 2
	$LevelButtons/Level3Button.disabled = Settings.highest_unlocked_level < 3
	$LevelButtons/Level4Button.disabled = Settings.highest_unlocked_level < 4
	$LevelButtons/Level5Button.disabled = Settings.highest_unlocked_level < 5
	$LevelButtons/Level6Button.disabled = Settings.highest_unlocked_level < 6
	$LevelButtons/Level7Button.disabled = Settings.highest_unlocked_level < 7
	$LevelButtons/Level8Button.disabled = Settings.highest_unlocked_level < 8
	$LevelButtons/Level9Button.disabled = Settings.highest_unlocked_level < 9
	$SecondRow/Level10Button.disabled = Settings.highest_unlocked_level < 10
	$SecondRow/Level11Button.disabled = Settings.highest_unlocked_level < 11
	$SecondRow/Level12Button.disabled = Settings.highest_unlocked_level < 12
	$SecondRow/Level13Button.disabled = Settings.highest_unlocked_level < 13
	$SecondRow/Level14Button.disabled = Settings.highest_unlocked_level < 14
	$SecondRow/Level15Button.disabled = Settings.highest_unlocked_level < 15
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


func _on_level_6_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level6.tscn")
	
func _on_level_7_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level7.tscn")


func _on_level_8_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level8.tscn")


func _on_level_9_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level9.tscn")


func _on_level_10_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level10.tscn")


func _on_level_11_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level11.tscn")


func _on_level_12_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level12.tscn")


func _on_level_13_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level13.tscn")

func _on_level_14_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level14.tscn")


func _on_level_15_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level15.tscn")
