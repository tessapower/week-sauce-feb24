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

	GameStateManager.player_level_changed.connect(_on_player_level_changed)
	GameStateManager.player_health_changed.connect(_on_player_health_changed)
	GameStateManager.player_max_health_changed.connect(_on_player_max_health_changed)
	GameStateManager.player_exp_changed.connect(_on_player_exp_changed)
	GameStateManager.player_max_exp_changed.connect(_on_player_max_exp_changed)
	GameStateManager.score_changed.connect(_on_score_changed)

func _on_player_level_changed(new_value: int) -> void:
	level_label.text = "LV %02d" % new_value

func _on_player_health_changed(new_value: int) -> void:
	health_bar.value = new_value

func _on_player_max_health_changed(new_value: int) -> void:
	health_bar.max_value = new_value

func _on_player_exp_changed(new_value: int) -> void:
	exp_bar.value = new_value

func _on_player_max_exp_changed(new_value: int) -> void:
	exp_bar.max_value = new_value

func _on_score_changed(new_value: int) -> void:
	score_label.text = str(new_value)
