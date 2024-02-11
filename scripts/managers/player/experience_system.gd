class_name ExperienceSystem


const BASE_MAX_EXP := 100
const MAX_EXP_MUL_FACTOR := 1.1
const MAX_EXP_ADD_FACTOR := 25


signal max_exp_changed(new_value: int)
signal exp_changed(new_value: int)
signal exp_gained()
signal level_changed(new_value: int)
signal leveled_up()


func reset() -> void:
	_max_exp = BASE_MAX_EXP
	_exp = 0
	_level = 1

	max_exp_changed.emit(_max_exp)
	exp_changed.emit(_exp)
	level_changed.emit(_level)

func increase_exp(amount: int) -> void:
	exp_gained.emit()
	_exp += amount
	exp_changed.emit(_exp)

	while _exp >= _max_exp:
		_exp -= _max_exp
		_max_exp = int(_max_exp * MAX_EXP_MUL_FACTOR + MAX_EXP_ADD_FACTOR)
		_level += 1

		max_exp_changed.emit(_max_exp)
		exp_changed.emit(_exp)
		level_changed.emit(_level)
		leveled_up.emit()


func max_exp() -> int: return _max_exp
func exp() -> int: return _exp
func level() -> int: return _level


var _max_exp: int
var _exp: int
var _level: int
