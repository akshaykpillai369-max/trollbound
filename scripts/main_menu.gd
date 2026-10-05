extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
const TIME_TO_DISPLAY_SECONDS: float = 1

@onready var label = $Title

func _ready() -> void:
	Settings.load_progress()
	label.visible_ratio = 0.0
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(label, "visible_ratio", 1.0, TIME_TO_DISPLAY_SECONDS)
	
func _on_play_button_pressed() -> void:
	
	get_tree().change_scene_to_file('res://levels/level_select.tscn')
	


func _on_settings_button_pressed() -> void:
	$SettingsPanel.show()


func _on_back_button_pressed() -> void:
	$SettingsPanel.hide()


func _on_main_menu_music_button_toggled(toggled_on: bool) -> void:
	Settings.main_menu_music_enabled = toggled_on
	$MenuMusic.playing = toggled_on


func _on_level_music_button_toggled(toggled_on: bool) -> void:
	Settings.level_music_enabled = toggled_on
