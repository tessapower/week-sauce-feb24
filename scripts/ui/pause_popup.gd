extends Window

## pause_popup.gd: Handles responding to button clicks in the pause popup.
##
## Author(s): Tessa Power

func _ready():
	get_viewport().transparent_bg = true
	hide()


func _on_resume_pressed():
	GameStateManager.set("is_paused", false)
	hide()


func _on_settings_pressed():
	# TODO: wire this up when settings support is implemented
	pass


func _on_start_menu_pressed():
	# TODO: wire this up when the start menu is implemented
	pass


func _on_exit_pressed():
	get_tree().quit()
