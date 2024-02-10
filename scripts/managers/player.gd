class_name Player

const POWER_UP_LIST := preload("res://resources/powerups/power_up_list.tres")

const HURT_SOUND := preload("res://assets/sounds/hurt.mp3")
const DIED_SOUND := preload("res://assets/sounds/negative_beeps.mp3")
const GAIN_EXP_SOUND := preload("res://assets/sounds/coin.mp3")
const LEVEL_UP_SOUND := preload("res://assets/sounds/cute-level-up.mp3")

const INITIAL_MAX_HP := 100
const MAX_HP_MUL_FACTOR := 1.1
const MAX_HP_ADD_FACTOR := 20

const INITIAL_MAX_EXP := 100
const MAX_EXP_MUL_FACTOR := 1.1
const MAX_EXP_ADD_FACTOR := 50

const INITIAL_ATK := 100
const ATK_MUL_FACTOR := 1.05
const ATK_ADD_FACTOR := 10

const INITIAL_ATK_SPD := 1.25

signal max_hp_changed(new_max_hp: int)
signal hp_changed(new_hp: int)
signal level_changed(new_level: int)
signal max_exp_changed(new_max_exp: int)
signal exp_changed(new_exp: int)
signal atk_changed(new_atk: int)
signal atk_spd_changed(new_atk_spd: float)

signal hp_reached_zero()
signal leveled_up(new_level: int)


func reset() -> void:
	_max_hp = INITIAL_MAX_HP
	_hp = _max_hp
	_max_exp = INITIAL_MAX_EXP
	_exp = 0
	_level = 1
	_atk = INITIAL_ATK
	_atk_spd = INITIAL_ATK_SPD
	_power_ups = {}

	max_hp_changed.emit(_max_hp)
	hp_changed.emit(_hp)
	max_exp_changed.emit(_max_exp)
	exp_changed.emit(_exp)
	level_changed.emit(_level)
	atk_changed.emit(_atk)
	atk_spd_changed.emit(_atk_spd)


func max_hp() -> int: return _max_hp
func hp() -> int: return _hp
func max_exp() -> int: return _max_exp
func exp() -> int: return _exp
func level() -> int: return _level
func atk() -> int: return _atk
func atk_spd() -> float: return _atk_spd


func inc_hp(amount: int) -> void:
	_hp = min(_hp + amount, _max_hp)
	hp_changed.emit(_hp)

func dec_hp(amount: int) -> void:
	_hp = max(_hp - amount, 0)
	hp_changed.emit(_hp)
	SoundManager.play_sound(HURT_SOUND)
	if _hp == 0:
		hp_reached_zero.emit()
		SoundManager.play_sound(DIED_SOUND)

func inc_exp(amount: int) -> void:
	_exp += amount
	exp_changed.emit(_exp)
	SoundManager.play_sound(GAIN_EXP_SOUND)

	while _exp >= _max_exp:
		_exp -= _max_exp
		_max_exp = int(_max_exp * MAX_EXP_MUL_FACTOR + MAX_EXP_ADD_FACTOR)
		_max_hp = int(_max_hp * MAX_HP_MUL_FACTOR + MAX_HP_ADD_FACTOR)
		_hp = _max_hp
		_atk = int(_atk * ATK_MUL_FACTOR + ATK_ADD_FACTOR)
		_level += 1

		max_exp_changed.emit(_max_exp)
		exp_changed.emit(_exp)
		max_hp_changed.emit(_max_hp)
		hp_changed.emit(_hp)
		atk_changed.emit(_atk)
		level_changed.emit(_level)
		leveled_up.emit(_level)

		SoundManager.play_sound(LEVEL_UP_SOUND)


func add_power_up(power_up_data: PowerUpData) -> void:
	var power_up: PowerUp = _power_ups.get(power_up_data.id)
	if power_up != null:
		power_up.level_up()
	else:
		_power_ups[power_up_data.id] = PowerUp.new(power_up_data)

func get_upgradable_power_ups() -> Array[PowerUpData]:
	var result: Array[PowerUpData] = []
	for id: String in POWER_UP_LIST.power_up_datas():
		var power_up: PowerUp = _power_ups.get(id)
		if power_up == null || power_up.level() < PowerUp.FINAL_LEVEL:
			result.append(power_up.data())
	return result


var _max_hp: int
var _hp: int
var _max_exp: int
var _exp: int
var _level: int
var _atk: int
var _atk_spd: float
var _power_ups: Dictionary
