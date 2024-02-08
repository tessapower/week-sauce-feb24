class_name Mole extends CharacterBody2D
## mole.gd: Represents the mole enemy character
##			Interface includes: controlling the mole, interaction with its stats.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

## Animations
@onready var animated_sprite = $AnimatedSprite2D

@export var data: MoleData
@export var disappear_timer: Timer
@export var attack_timer: Timer

var exp_reward: int:
	get: return exp_reward

var score_reward: int:
	get: return score_reward

var max_health: int:
	get: return max_health

var current_health: int:
	get: return current_health

var attack_damage: int:
	get: return attack_damage

func apply_damage(value: int) -> void:
	current_health = max(0, current_health - value)
	if current_health == 0: _defeat()


func _ready() -> void:
	assert(data != null)
	assert(disappear_timer != null)
	assert(attack_timer != null)
	_load_data()
	disappear_timer.timeout.connect(_disappear)
	# TODO: attack_timer.timeout.connect(*INSER ATTACK FUNCTION HERE*)

	animated_sprite.play("emerge")

## Callback function for when the mole's animated sprite finishes an animation,
## and sets the next animation appropriately.
func _on_animation_finished() -> void:
	match animated_sprite.animation:
		"emerge":
			animated_sprite.play("idle")

func _disappear() -> void:
	# TODO: turn off collision, play mole disappear animation, and remove them from the scene
	pass

func _defeat() -> void:
	GameStateManager.add_exp(exp_reward)
	GameStateManager.add_score(score_reward)
	_disappear()

# Initialzes mole stats from the data
func _load_data() -> void:
	exp_reward = data.exp_reward
	score_reward = data.score_reward
	disappear_timer.wait_time = data.time_until_disappear
	max_health = data.max_health; current_health = max_health
	attack_damage = data.attack_damage
	attack_timer.wait_time = 1.0 / data.attack_speed
