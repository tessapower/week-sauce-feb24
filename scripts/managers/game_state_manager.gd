extends Node

# ====================Public Interface====================

# ----------Lifetime----------

# TODO: load persistent player data (such as highscore)

func initialize_for_scene():
	player_max_health = initial_player_max_health
	player_health = player_max_health
	reset_score()
	is_paused = false

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


# ----------Score----------

var current_score: int:
	get: return _current_score

var high_score: int:
	get: return _high_score

func add_score(extra_score: int):
	_current_score += extra_score
	if _current_score > _high_score:
		_high_score = _current_score

func reset_score():
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
		if _is_paused:
			paused.emit()
		else:
			unpaused.emit()

# ====================Private Implementation====================

# ----------Property Backing Variables (should not touch)----------

var _player_max_health: int
var _player_health: int

var _current_score: int
var _high_score: int = 0

var _is_paused: bool = false
