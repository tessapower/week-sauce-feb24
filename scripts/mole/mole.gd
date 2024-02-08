class_name Mole extends CharacterBody2D
## mole.gd: Represents the mole enemy character
##			Interface includes: controlling the mole, interaction with its stats.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

# TODO: mole doesnt hit
# TODO: mole doesnt disappear

## Animations
@export var data: MoleData

@onready var animated_sprite = $AnimatedSprite2D
@onready var disappear_timer: Timer = $DisappearTimer
@onready var attack_timer: Timer = $AttackTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

enum State { ALIVE, DISAPPEARED, DEFEATED }
var state: State = State.ALIVE


## Callback function intended to be called when hit by the player's mallet.
func on_hit() -> void:
	# TODO: refactor this to take a damage value when powerups are implemented
	apply_damage(10)
	animated_sprite.play("hit")


# TODO: respond appropriately to mole's health.
# 		health > 0: mole flash animation
#		health == 0: mole died animation

func apply_damage(value: int) -> void:
	current_health = max(0, current_health - value)
	if current_health == 0:
		_defeat()
	else:
		# TODO: animated_sprite.play("flash")
		pass


func _ready() -> void:
	assert(data != null)
	assert(disappear_timer != null)
	assert(attack_timer != null)
	assert(collision_shape != null)

	_load_data()

	disappear_timer.timeout.connect(_disappear)
	attack_timer.timeout.connect(_on_attack_timer_timeouted)

	disappear_timer.start()
	attack_timer.start()

	animated_sprite.play("emerge")


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
		"disappear":
			queue_free()
		_:
			match state:
				State.ALIVE:
					animated_sprite.play("idle")

				State.DISAPPEARED:
					# TODO: replace the animation with one that does
					#		indicate that the mole was hit
					animated_sprite.play("disappear")

				State.DEFEATED:
					animated_sprite.play("disappear")


func _on_attack_timer_timeouted() -> void:
	game_state_manager.apply_damage(attack_damage)
	animated_sprite.play("attack")


func _disappear() -> void:
	state = State.DISAPPEARED
	collision_shape.set_deferred("disabled", true)


func _defeat() -> void:
	state = State.DEFEATED
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
