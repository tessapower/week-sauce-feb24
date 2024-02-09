class_name Mole extends CharacterBody2D
## mole.gd: Represents the mole enemy character
##			Interface includes: controlling the mole, interaction with its stats.
##
## Author(s): Phuwasate Lutchanont, Tessa Power

## Animations
@export var data: MoleData

@onready var animated_sprite = $AnimatedSprite2D
@onready var disappear_timer: Timer = $DisappearTimer
@onready var attack_timer: Timer = $AttackTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

const EMERGE_SOUND: AudioStream = preload("res://assets/sounds/deplacementroche.mp3")
const ATTACK_SOUND: AudioStream = preload("res://assets/sounds/swing-whoosh-weapon.mp3")

## Callback function intended to be called when hit by the player's mallet.
func on_hit() -> void:
	# TODO: refactor this to take a damage value when powerups are implemented
	apply_damage(50)
	# Play the appropriate animation
	if current_health == 0: animated_sprite.play("defeated")
	else: animated_sprite.play("hit")


func apply_damage(value: int) -> void:
	current_health = max(0, current_health - value)
	if current_health == 0: _defeat()


func _ready() -> void:
	assert(data != null)

	_load_data()

	disappear_timer.start()
	attack_timer.start()

	animated_sprite.play("emerge")
	SoundManager.play_sound(EMERGE_SOUND)


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


## Callback function for when the mole's animated sprite finishes an animation,
## and sets the next animation appropriately.
func _on_animation_finished() -> void:
	match animated_sprite.animation:
		"disappear", "defeated":
			queue_free()
		_:
			animated_sprite.play("idle")


func _on_attack_timer_timeout() -> void:
	# Only attack if the mole isn't already in the middle of another animation
	if animated_sprite.animation == "idle":
		game_state_manager.apply_damage(attack_damage)
		animated_sprite.play("attack")
		SoundManager.play_sound_with_pitch(ATTACK_SOUND, randf_range(0.75, 1.25))


func _disappear() -> void:
	if animated_sprite.animation == "idle":
		# Make sure we don't monitor for collisions and interrupt this
		collision_shape.set_deferred("disabled", true)
		animated_sprite.play("disappear")


func _defeat() -> void:
	# Make sure we don't monitor for collisions and interrupt this
	collision_shape.set_deferred("disabled", true)
	game_state_manager.add_exp(exp_reward)
	game_state_manager.add_score(score_reward)


# Initialzes mole stats from the data
func _load_data() -> void:
	exp_reward = data.exp_reward
	score_reward = data.score_reward
	disappear_timer.wait_time = data.time_until_disappear
	max_health = data.max_health; current_health = max_health
	attack_damage = data.attack_damage
	attack_timer.wait_time = 1.0 / data.attack_speed
