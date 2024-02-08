extends Node2D

## game_over.gd: This script manages responding to the player clicking buttons
##                on the game over menu, and displaying the outcome of the game.
##
## Author(s): Tessa Power

@onready var final_score = $Content/FinalScore

func _ready() -> void:
	# Update the final score label
	var score: int = game_state_manager.current_score
	if (score != 0 and score == game_state_manager.high_score):
		# Let the player know if they set a new highscore
		final_score.set_text("New High Score!!\n\nFinal Score: ")
	final_score.text += str(game_state_manager.current_score)


func _on_play_pressed() -> void:
	# TODO: set the level played in GSM so the player can replay the same level
	get_tree().change_scene_to_file("res://scenes/levels/grassy_field.tscn")


func _on_start_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
