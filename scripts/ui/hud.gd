class_name Hud extends Control
# hud.gd: Controls the display of the game's HUD

# Author(s): Phuwasate Lutchanont

@export var level_label: Label
@export var health_bar: Range
@export var exp_bar: Range
@export var score_label: Label


func _ready() -> void:
	assert(level_label != null)
	assert(health_bar != null)
	assert(exp_bar != null)
	assert(score_label != null)

	game_state_manager.player.level_changed.connect(_on_player_level_changed)
	game_state_manager.player.hp_changed.connect(_on_player_hp_changed)
	game_state_manager.player.max_hp_changed.connect(_on_player_max_hp_changed)
	game_state_manager.player.exp_changed.connect(_on_player_exp_changed)
	game_state_manager.player.max_exp_changed.connect(_on_player_max_exp_changed)
	game_state_manager.score_changed.connect(_on_score_changed)

func _on_player_level_changed(new_value: int) -> void:
	level_label.text = "LV %02d" % new_value

func _on_player_hp_changed(new_value: int) -> void:
	health_bar.value = new_value

func _on_player_max_hp_changed(new_value: int) -> void:
	health_bar.max_value = new_value

func _on_player_exp_changed(new_value: int) -> void:
	exp_bar.value = new_value

func _on_player_max_exp_changed(new_value: int) -> void:
	exp_bar.max_value = new_value

func _on_score_changed(new_value: int) -> void:
	score_label.text = str(new_value)
