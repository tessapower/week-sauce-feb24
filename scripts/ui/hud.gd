class_name Hud extends Control

## hud.gd: Controls the display of the game's HUD
##
## Author(s): Phuwasate Lutchanont, Tessa Power

@onready var level_label = get_node("Content/BottomUI/LevelLabel")
@onready var health_bar: Range = get_node("Content/BottomUI/HealthAndXP/HealthBar")
@onready var exp_bar: Range = get_node("Content/BottomUI/HealthAndXP/ExperienceBar")
@onready var score_label: Label = get_node("Content/ScoreLabel")


func _ready() -> void:
	game_state_manager.player_level_changed.connect(_on_player_level_changed)
	game_state_manager.player_health_changed.connect(_on_player_health_changed)
	game_state_manager.player_max_health_changed.connect(_on_player_max_health_changed)
	game_state_manager.player_exp_changed.connect(_on_player_exp_changed)
	game_state_manager.player_max_exp_changed.connect(_on_player_max_exp_changed)
	game_state_manager.score_changed.connect(_on_score_changed)


func _on_player_level_changed(new_value: int) -> void:
	level_label.text = "LVL: %03d" % new_value
	if new_value > 1:
		level_label.flash()


func _on_player_health_changed(new_value: int) -> void:
	health_bar.value = new_value


func _on_player_max_health_changed(new_value: int) -> void:
	health_bar.max_value = new_value


func _on_player_exp_changed(new_value: int) -> void:
	exp_bar.value = new_value


func _on_player_max_exp_changed(new_value: int) -> void:
	exp_bar.max_value = new_value


func _on_score_changed(new_value: int) -> void:
	score_label.text = "SCORE: %09d" % new_value
	if new_value > 0:
		score_label.flash()
