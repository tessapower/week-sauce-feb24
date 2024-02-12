extends Node2D

## start_menu.gd: This script manages responding to the player clicking buttons
##                on the start menu.
##
## Author(s): Phuwasate Lutchanont, Tessa Power

const TRANSITION_BUTTON_SOUND: AudioStream = preload("res://assets/sounds/interface.mp3")
const BUTTON_SOUND: AudioStream = preload("res://assets/sounds/pick.mp3")

@onready var levels = $Content/Buttons/OptionButton
const DEFAULT_LEVEL = GameStateManager.LEVEL.grassy_field

func _ready() -> void:
	# Set the default selected option in the game state manager
	game_state_manager.set_level(DEFAULT_LEVEL)
	levels.selected = DEFAULT_LEVEL


func _on_play_pressed() -> void:
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	game_state_manager.load_current_level()


func _on_how_to_play_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)
	$HowToPlayPopup.show()


func _on_settings_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)


func _on_credits_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)
	$CreditsPopup.show()


func _on_exit_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)
	get_tree().quit()


func _on_level_selected(index):
	game_state_manager.set_level(index)
