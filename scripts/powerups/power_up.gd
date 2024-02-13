class_name PowerUp extends Resource

const FINAL_LEVEL := 6

@export var name: StringName
@export var icon: Texture

func _init() -> void:
	call_deferred("_validate")

func _validate() -> void:
	assert(name)
	assert(icon)

func apply(power_up_system: PowerUpSystem) -> void:
	var data_dict := power_up_system.power_up_data()
	var current_data: Data = data_dict.get(name)
	if !current_data:
		current_data = create_data()
		data_dict[name] = current_data

	current_data.level_up(power_up_system.player())

func data() -> Data:
	return game_state_manager.player().power_up_system().power_up_data().get(name)

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
