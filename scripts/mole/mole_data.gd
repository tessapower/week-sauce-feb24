class_name MoleData extends Resource

# mole_data.gd:
#	Database class for storing stats of a mole

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

# Name of the mole type
@export var name: String

# Initial experience reward at the start of the game
@export var base_exp_reward: int = 5

# Amount of extra exp rewarded per 5 minutes
@export var exp_reward_over_time: int = 15

# The exponent that the exp reward will be scaled by every 5 minutes
@export var exp_reward_expn_factor: float = 1.1

# Initial score reward on kill at the start of the game
@export var base_score_reward: int = 20

# Amount of extra score reward per 5 minutes
@export var score_reward_over_time: int = 60

# The exponent that score reward will be scaled by every 5 minutes
@export var score_reward_expn_factor: float = 1.1

# Time until this mole disappears (in seconds)
@export var time_until_disappear: float = 5

# Initial max health of the mole at the start of the game
@export var base_max_health: int = 100

# Amount of extra max health gained per 5 minutes
@export var max_health_over_time: int = 300

# The exponent that the max health will be scaled by every 5 minutes
@export var max_health_expn_factor: float = 1.1

# Initial damage this mole can inflict on the player per hit at the start of the game
@export var base_attack_damage: int = 5

# Amount of extra attack damage per 5 minutes
@export var attack_damage_over_time: int = 15

# The exponent that the attack damage will be scaled by every 5 minutes
@export var attack_damage_expn_factor: float = 1.1

# The number of attack this mole can perform on the player per second
@export var attack_speed: float = 0.25



var exp_reward: int:
	get: return _calculate_stat(base_exp_reward, exp_reward_over_time, exp_reward_expn_factor)

var score_reward: int:
	get: return _calculate_stat(base_score_reward, score_reward_over_time, score_reward_expn_factor)

var max_health: int:
	get: return _calculate_stat(base_max_health, max_health_over_time, max_health_expn_factor)

var attack_damage: int:
	get: return _calculate_stat(base_attack_damage, attack_damage_over_time, attack_damage_expn_factor)


func _calculate_stat(base: int, gain_over_time: int, expn_factor: float) -> int:
	var five_minute_intervals := float(game_state_manager.time_elapsed) / 1e6 / 60 / 5
	var gain := gain_over_time * five_minute_intervals
	var extra_expn := (expn_factor - 1) * five_minute_intervals

	return int((base + gain) ** (1 + extra_expn))
