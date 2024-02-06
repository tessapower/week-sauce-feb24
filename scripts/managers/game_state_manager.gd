extends Node

# game_state_manager.gd: 
# Serves the following functionalities:
#	manage player stats
#	control the pause state of the game

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

# ----------Lifetime----------

# TODO: load persistent player data (such as highscore)

func initialize_for_scene() -> void:
	player_max_health = initial_player_max_health
	player_health = player_max_health
	reset_exp_and_level()
	reset_score()
	_reset_time()
	is_paused = false

# ----------Time Monitoring----------

var time_elapsed_usec: int:
	get: return _time_elapsed_usec

# ----------Player Health----------

signal player_died()

@export var initial_player_max_health: int = 100:
	get:
		return initial_player_max_health

	set(new_value):
		initial_player_max_health = max(0, new_value)


var player_max_health: int:
	get:
		return _player_max_health

	set(new_value):
		_player_max_health = max(0, _player_max_health)
		player_health = min(player_health, _player_max_health)


var player_health: int:
	get:
		return _player_health

	set(new_value):
		_player_health = min(max(0, new_value), player_max_health)
		if _player_health == 0:
			player_died.emit()

# ----------Experience and Level----------

signal player_leveled_up()

@export var initial_player_max_exp: int = 100
@export var player_max_exp_mul_factor: float = 1.1
@export var player_max_exp_add_factor: int = 50

func reset_exp_and_level() -> void:
	_player_exp = 0
	_player_max_exp = initial_player_max_exp
	_player_level = 1

func add_exp(value: int) -> void:
	_player_exp += value
	while _player_exp >= _player_max_exp:
		_player_exp -= _player_max_exp

		_player_max_exp = int(
			_player_max_exp * player_max_exp_mul_factor
			+ player_max_exp_add_factor)

		_player_level += 1

		player_leveled_up.emit()


# ----------Score----------

var current_score: int:
	get: return _current_score

var high_score: int:
	get: return _high_score

func add_score(extra_score: int) -> void:
	_current_score += extra_score
	if _current_score > _high_score:
		_high_score = _current_score

func reset_score() -> void:
	_current_score = 0


# ----------Pausing----------

signal paused()
signal unpaused()

var is_paused: bool:
	get:
		return _is_paused

	set(new_value):
		if _is_paused == new_value:
			return

		_is_paused = new_value
		get_tree().paused = _is_paused
		if _is_paused:
			paused.emit()
		else:
			unpaused.emit()

# ====================Private Implementation====================

# ----------Inherited From Parent----------

func _ready() -> void:
	_ready_time()

func _process(_delta: float) -> void:
	_process_time()


# these should not be accessed by other functionalities other than their own

# ----------Time Monitoring----------

var _last_time_point: int
var _time_elapsed_usec: int

func _ready_time() -> void:
	paused.connect(_on_paused_time)
	unpaused.connect(_on_unpaused_time)

func _reset_time() -> void:
	_last_time_point = Time.get_ticks_usec()
	_time_elapsed_usec = 0

func _process_time() -> void:
	if !is_paused: _update_time()

func _on_paused_time() -> void:
	_update_time()

func _on_unpaused_time() -> void:
	_last_time_point = Time.get_ticks_usec()

func _update_time() -> void:
	var current_time_point := Time.get_ticks_usec()
	_time_elapsed_usec += current_time_point - _last_time_point
	_last_time_point = current_time_point
	

# ----------Player Health----------
var _player_max_health: int
var _player_health: int

# ----------Score----------
var _current_score: int
var _high_score: int = 0

# ----------Pausing----------
var _is_paused: bool = false

# ----------Experience and Level----------
var _player_exp: int
var _player_max_exp: int
var _player_level: int
