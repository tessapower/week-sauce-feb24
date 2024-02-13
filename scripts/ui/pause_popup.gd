extends Window

## pause_popup.gd: Handles responding to button clicks in the pause popup.
##
## Author(s): Tessa Power

const TRANSITION_BUTTON_SOUND: AudioStream = preload("res://assets/sounds/interface.mp3")

func _ready():
	get_viewport().transparent_bg = true
	hide()


func _on_resume_pressed():
	game_state_manager.pause_system().set_paused(false)
	hide()


func _on_settings_pressed():
	# TODO: wire this up when settings support is implemented
	pass


func _on_start_menu_pressed():
	hide()
	game_state_manager.set("is_paused", false)
	game_state_manager.pause_system().set_paused(false)
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_exit_pressed():
	get_tree().quit()
