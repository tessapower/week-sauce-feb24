class_name PowerUp extends Resource

const FINAL_LEVEL := 6

@export var name: StringName
@export var icon: Texture

func _init() -> void:
	call_deferred("_validate")

func _validate() -> void:
	assert(name)
	assert(icon)

func apply(_power_up_system: PowerUpSystem) -> void:
	var data_dict := _power_up_system.power_up_data()
	var data: Data = data_dict.get(name)
	if !data:
		data = create_data()
		data_dict[name] = data

	data.level_up(_power_up_system.player())


# Need to be implemented by subclass
func create_data() -> Data:
	return null

class Data:
	func _init(power_up_: PowerUp) -> void:
		_power_up = power_up_
		_level = 0

	# Should be overridden to implement buffs to the player
	func level_up(_player: Player) -> void:
		_level += 1

	func power_up() -> PowerUp: return _power_up
	func level() -> int: return _level

	var _power_up: PowerUp
	var _level: int
