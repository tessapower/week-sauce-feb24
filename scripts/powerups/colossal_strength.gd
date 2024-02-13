class_name ColossalStrengthPowerUp extends PowerUp

@export var atk_dmg_mods: Array[float] = []

func _validate() -> void:
	super._validate()
	assert(atk_dmg_mods && atk_dmg_mods.size() == FINAL_LEVEL)

func create_data() -> Data:
	return Data.new(self)

class Data extends PowerUp.Data:
	func _init(power_up_: ColossalStrengthPowerUp) -> void:
		super._init(power_up_)

	func level_up(player: Player) -> void:
		super.level_up(player)
		player.stat_system().add_atk_dmg_mod(power_up().name,power_up().atk_dmg_mods[level()])

		# TODO: at the final, attacks become AOE

	func power_up() -> ColossalStrengthPowerUp:
		return super.power_up()
