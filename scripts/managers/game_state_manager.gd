class_name GameStateManager extends Node

## game_state_manager.gd:
##	Serves the following functionalities:
##	Manage player stats
##	Control the pause state of the game
##
## Author(s): Phuwasate Lutchanont, Tessa Power

# TODO: load persistent player data (such as highscore)

func _process(delta: float) -> void:
	_time_system.process(delta)


func initialize_for_scene() -> void:
	_player.reset()
	_score_system.reset()
	_time_system.reset()
	_pause_system.set_paused(false)

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

func player() -> Player: return _player
var _player := Player.new()

func score_system() -> ScoreSystem: return _score_system
var _score_system := ScoreSystem.new()

func pause_system() -> PauseSystem: return _pause_system
var _pause_system := PauseSystem.new(self)

func time_system() -> TimeSystem: return _time_system
var _time_system := TimeSystem.new()
