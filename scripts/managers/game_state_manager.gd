class_name GameStateManager extends Node

# game_state_manager.gd:
# Serves the following functionalities:
#	manage player stats
#	control the pause state of the game

# Author: Phuwasate Lutchanont, Tessa Power

# TODO: load persistent player data (such as highscore)


func _process(delta: float) -> void:
	_process_time(delta)

func initialize_for_scene() -> void:
	player.reset()
	_reset_score()
	_reset_time()
	is_paused = false

# ----------Level Scene----------

enum LEVEL {grassy_field = 0, desert, underwater}
var level_scenes: Dictionary = {
	LEVEL.grassy_field: "res://scenes/levels/grassy_field.tscn",
	LEVEL.desert: "res://scenes/levels/desert.tscn",
	LEVEL.underwater: "res://scenes/levels/underwater.tscn"
}
# Set default level to grassy field
var current_level: String = level_scenes.get(LEVEL.grassy_field)

func set_level(level: LEVEL) -> void:
	current_level = level_scenes.get(level)


func load_current_level() -> void:
	get_tree().change_scene_to_file(current_level)

# ----------Player Health----------

var player := Player.new()

# ----------Score----------

var current_score: int:
	get:
		return current_score

	set(new_value):
		current_score = new_value
		score_changed.emit(current_score)

var high_score: int:
	get: return high_score

signal score_changed(new_value: int)

func add_score(extra_score: int) -> void:
	current_score += extra_score
	if current_score > high_score:
		high_score = current_score

	score_changed.emit(current_score)

func _reset_score() -> void:
	current_score = 0
	score_changed.emit(current_score)


# ----------Pausing----------

signal paused()
signal unpaused()

var is_paused: bool = false:
	get:
		return is_paused

	set(new_value):
		if is_paused == new_value:
			return

		is_paused = new_value
		get_tree().paused = is_paused
		if is_paused:
			paused.emit()
		else:
			unpaused.emit()


# ----------Time Monitoring----------

var time_elapsed: float:
	get: return time_elapsed

func _reset_time() -> void:
	time_elapsed = 0

func _process_time(delta: float) -> void:
	time_elapsed += delta
