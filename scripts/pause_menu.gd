extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_restart_button_2_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_level_select_button_3_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://levels/level_select.tscn")


func _on_main_menu_button_4_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
