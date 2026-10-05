extends Node

var main_menu_music_enabled := true
var level_music_enabled := true
var highest_unlocked_level := 1

func save_progress():
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_32(highest_unlocked_level)

func load_progress():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		highest_unlocked_level = file.get_32()
