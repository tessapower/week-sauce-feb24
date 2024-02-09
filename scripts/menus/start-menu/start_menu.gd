extends Node2D

## start_menu.gd: This script manages responding to the player clicking buttons
##                on the start menu.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

const TRANSITION_BUTTON_SOUND: AudioStream = preload("res://assets/sounds/interface.mp3")
const BUTTON_SOUND: AudioStream = preload("res://assets/sounds/pick.mp3")

func _on_play_pressed() -> void:
	# SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	get_tree().change_scene_to_file("res://scenes/levels/grassy_field.tscn")

# TODO: add a level select dropdown


func _on_how_to_play_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)


func _on_settings_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)


func _on_credits_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)


func _on_exit_pressed() -> void:
	SoundManager.play_sound(BUTTON_SOUND)
	get_tree().quit()
