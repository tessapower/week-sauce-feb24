class_name PowerUp

const FINAL_LEVEL := 6

func _init(data_: PowerUpData, level_: int = 1) -> void:
	_data = data_
	_level = level_

func data() -> PowerUpData: return _data
func level() -> int: return _level

func level_up() -> void: _level += 1

var _data: PowerUpData
var _level: int
