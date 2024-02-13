extends Window

## submenu_popup.gd: Handles responding to button clicks in a submenu popup.
##
## Author(s): Tessa Power

const TRANSITION_BUTTON_SOUND: AudioStream = preload("res://assets/sounds/interface.mp3")

@export var title_string: String = "TITLE"
@export_multiline var text_content_string: String = "Lorem ipsum sit dolor amet."

func _ready():
	$Content/Title.set_text(title_string)
	$Content/Text.set_text("[center]" + text_content_string + "[/center]")
	get_viewport().transparent_bg = true
	hide()


func _on_close_pressed():
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	hide()
