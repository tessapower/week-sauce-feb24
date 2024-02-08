extends Node2D

## start_menu.gd: This script manages responding to the player clicking buttons
##                on the start menu.
##
## Author(s): Tessa Power

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/grassy_field.tscn")

# TODO: add a level select dropdown


func _on_how_to_play_pressed() -> void:
	pass


func _on_settings_pressed() -> void:
	pass


func _on_credits_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
