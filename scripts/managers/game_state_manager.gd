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
	_reset_health()
	_reset_exp_and_level()
	_reset_score()
	_reset_time()
	is_paused = false

# ----------Player Health----------

signal player_health_changed(new_value: int)
signal player_max_health_changed(new_value: int)
signal player_died()

@export var initial_player_max_health: int = 100:
	get:
		return initial_player_max_health

	set(new_value):
		initial_player_max_health = max(0, new_value)

func apply_damage(value: int):
	player_health -= value

var player_max_health: int:
	get:
		return player_max_health

	set(new_value):
		player_max_health = max(0, new_value)
		player_max_health_changed.emit(player_max_health)
		player_health = min(player_health, player_max_health)


var player_health: int:
	get:
		return player_health

	set(new_value):
		player_health = min(max(0, new_value), player_max_health)
		player_health_changed.emit(player_health)
		if player_health == 0:
			player_died.emit()


func _reset_health() -> void:
	player_max_health = initial_player_max_health
	player_health = player_max_health

# ----------Experience and Level----------

signal player_leveled_up(new_value: int)
signal player_level_changed(new_value: int)
signal player_exp_changed(new_value: int)
signal player_max_exp_changed(new_value: int)

@export var initial_player_max_exp: int = 100
@export var player_max_exp_mul_factor: float = 1.1
@export var player_max_exp_add_factor: int = 50


func _reset_exp_and_level() -> void:
	player_exp = 0
	player_max_exp = initial_player_max_exp
	player_level = 1


func add_exp(value: int) -> void:
	player_exp += value
	while player_exp >= player_max_exp:
		player_exp -= player_max_exp

		player_max_exp = int(
			player_max_exp * player_max_exp_mul_factor
			+ player_max_exp_add_factor)

		player_level += 1
		player_leveled_up.emit(player_level)


var player_exp: int:
	get:
		return player_exp

	set(new_value):
		player_exp = new_value
		player_exp_changed.emit(player_exp)


var player_max_exp: int:
	get:
		return player_max_exp

	set(new_value):
		player_max_exp = new_value
		player_max_exp_changed.emit(player_max_exp)


var player_level: int:
	get:
		return player_level

	set(new_value):
		player_level = new_value
		player_level_changed.emit(player_level)

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
