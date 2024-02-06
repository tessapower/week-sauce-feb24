class_name MoleData extends Resource

# mole_data.gd:
#	Database class for storing stats of a mole

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

# Name of the mole type
@export var name: String

# Initial max health of the mole at the start of the game
@export var base_max_health: int = 100

# Amount of extra max health gained per 5 minutes
@export var max_health_over_time: int = 300

# The exponent that the max health will be scaled by every 5 minutes
@export var max_health_expn_factor: float = 1.1

# Initial experience reward at the start of the game
@export var base_exp_reward: int = 5

# Amount of extra exp rewarded per 5 minutes
@export var exp_reward_over_time: int = 15

# The exponent that the exp reward will be scaled by every 5 minutes
@export var exp_reward_expn_factor: float = 1.1


var max_health: int:
	get: return _calculate_stat(base_max_health, max_health_over_time, max_health_expn_factor)

var exp_reward: int:
	get: return _calculate_stat(base_exp_reward, exp_reward_over_time, exp_reward_expn_factor)


func _calculate_stat(base: int, gain_over_time: int, expn_factor: float) -> int:
	var five_minute_intervals := float(GameStateManager.time_elapsed_usec) / 1e6 / 60 / 5
	var gain := gain_over_time * five_minute_intervals
	var extra_expn := (expn_factor - 1) * five_minute_intervals

	return int((base + gain) ** (1 + extra_expn))

	# const minutes := GameStateManager.
