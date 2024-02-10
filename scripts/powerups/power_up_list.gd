class_name PowerUpList extends Resource

@export var power_up_data_array: Array[PowerUpData]

func _init():
	_power_up_datas = {}
	for data in power_up_data_array:
		_power_up_datas[data.id] = data

func power_up_datas() -> Dictionary: return _power_up_datas

var _power_up_datas: Dictionary
