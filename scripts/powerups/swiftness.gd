class_name SwiftnessPowerUp extends PowerUp

@export var atk_spd_mods: Array[float] = []

func _validate() -> void:
	super._validate()
	assert(atk_spd_mods && atk_spd_mods.size() == FINAL_LEVEL)

func create_data() -> Data:
	return Data.new(self)

class Data extends PowerUp.Data:
	func _init(power_up_: SwiftnessPowerUp) -> void:
		super._init(power_up_)

	func level_up(player: Player) -> void:
		super.level_up(player)
		player.stat_system().add_atk_spd_mod(power_up().name, power_up().atk_spd_mods[level()])
		if level() == FINAL_LEVEL: player.set_perma_attack()

	func power_up() -> SwiftnessPowerUp:
		return super.power_up()
