extends Node

# ====================Public Interface====================

# ---------Signals----------

signal player_died()

@export var initial_player_max_health: int = 100:
	get:
		return initial_player_max_health

	set(new_value):
		initial_player_max_health = max(0, new_value)



# ----------Player Health----------

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


# ----------Lifetime----------

func initialize_for_scene():
	player_max_health = initial_player_max_health
	player_health = player_max_health



# ====================Private Implementation====================

# ----------Backing Variables----------
var _player_max_health: int
var _player_health: int

# ----------Inherited from parent----------
