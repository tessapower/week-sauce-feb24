class_name PowerUpDB extends Resource

@export var power_ups: Array[PowerUp] = []

func get_random_power_ups(count: int) -> Array[PowerUp]:
	var power_up_system: PowerUpSystem = game_state_manager.player().power_up_system()
	var candidates: Array[PowerUp] = power_ups.filter(func (power_up: PowerUp):
		var data: PowerUp.Data = power_up_system.power_up_data().get(power_up.name)
		return !data || data.level() < PowerUp.FINAL_LEVEL)

	candidates.shuffle()
	return candidates.slice(0, count)
