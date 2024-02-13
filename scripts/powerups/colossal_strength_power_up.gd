class_name ColossalStrengthPowerUp extends PowerUp

const EFFECT := preload("res://scenes/powerups/puff_effect.tscn")

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

		var stat_system: StatSystem = player.stat_system()

		stat_system.add_atk_dmg_mod(power_up().name, power_up().atk_dmg_mods[level() - 1])
		
		if level() == FINAL_LEVEL:
			stat_system.add_atk_radius_mod(power_up().name, 3.5)
			player.set_attack_effect(EFFECT)


	func power_up() -> ColossalStrengthPowerUp:
		return super.power_up()
