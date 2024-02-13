class_name Hud extends Control

## hud.gd: Controls the display of the game's HUD
##
## Author(s): Phuwasate Lutchanont, Tessa Power

@onready var level_label: FlashingLabel = get_node("Content/BottomUI/LevelLabel")
@onready var health_bar: Range = get_node("Content/BottomUI/HealthAndXP/HealthBar")
@onready var health_label: FlashingLabel = get_node("Content/BottomUI/HealthAndXP/HealthLabel")
@onready var exp_bar: Range = get_node("Content/BottomUI/HealthAndXP/ExperienceBar")
@onready var score_label: FlashingLabel = get_node("Content/ScoreLabel")

const BUBBLE_LABEL = preload("res://scenes/ui/bubble_label.tscn")

func _ready() -> void:
	assert(level_label != null)
	assert(health_bar != null)
	assert(exp_bar != null)
	assert(score_label != null)

	var player := game_state_manager.player()
	var hp_system := player.hp_system()
	var exp_system := player.exp_system()

	hp_system.hp_changed.connect(_on_player_hp_changed)
	hp_system.max_hp_changed.connect(_on_player_max_hp_changed)
	exp_system.exp_changed.connect(_on_player_exp_changed)
	exp_system.max_exp_changed.connect(_on_player_max_exp_changed)
	exp_system.level_changed.connect(_on_player_level_changed)
	game_state_manager.score_system().current_score_changed.connect(_on_score_changed)


func _on_player_level_changed(new_value: int) -> void:
	level_label.text = "LVL: %03d" % new_value
	if new_value > 1:
		level_label.flash()


func _on_player_hp_changed(new_value: int) -> void:
	# Add a bubble label for the health change
	var bubble_label = BUBBLE_LABEL.instantiate()
	var difference = new_value - health_bar.value
	# Don't do anything if there is no difference
	if difference == 0: return

	var s = "+" if sign(difference) > 0 else ""
	var color = Color.SEA_GREEN if difference > 0 else Color.CRIMSON
	bubble_label.init(s + str(difference) + "HP", color, health_bar.global_position)
	add_child(bubble_label)

	health_bar.value = new_value
	health_bar.get_node("Flash").play("flash")

func _on_player_max_hp_changed(new_value: int) -> void:
	health_bar.max_value = new_value
	health_bar.get_node("Flash").play("flash")


func _on_player_exp_changed(new_value: int) -> void:
	exp_bar.get_node("Flash").play("flash")
	exp_bar.value = new_value


func _on_player_max_exp_changed(new_value: int) -> void:
	exp_bar.get_node("Flash").play("flash")
	exp_bar.max_value = new_value


func _on_score_changed(new_value: int) -> void:
	score_label.text = "SCORE: %09d" % new_value
	if new_value > 0:
		score_label.flash()
