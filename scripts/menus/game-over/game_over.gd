extends Node2D

## game_over.gd: This script manages responding to the player clicking buttons
##                on the game over menu, and displaying the outcome of the game.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

@onready var final_score = $Content/FinalScore

const TRANSITION_BUTTON_SOUND: AudioStream = preload("res://assets/sounds/interface.mp3")

func _ready() -> void:
	# Update the final score label
	var score: int = game_state_manager.current_score
	if (score != 0 and score == game_state_manager.high_score):
		# Let the player know if they set a new highscore
		final_score.set_text("New High Score!!\n\nFinal Score: ")
	final_score.text += str(game_state_manager.current_score)


func _on_play_pressed() -> void:
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	game_state_manager.load_current_level()


func _on_start_menu_pressed() -> void:
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_exit_pressed() -> void:
	SoundManager.play_sound(TRANSITION_BUTTON_SOUND)
	get_tree().quit()
