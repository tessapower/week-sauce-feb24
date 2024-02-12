class_name StatSystem


const BASE_ATK_DMG := 100
const ATK_DMG_MUL_FACTOR := 1.05
const ATK_DMG_ADD_FACTOR := 10

const BASE_ATK_SPD := 1.25


func _init(exp_system: ExperienceSystem) -> void:
	exp_system.leveled_up.connect(_level_up_stats)


func reset() -> void:
	_premod_atk_dmg = BASE_ATK_DMG
	_premod_atk_spd = BASE_ATK_SPD

	_atk_dmg_mod = {}
	_atk_spd_mod = {}

	_update_atk_dmg()
	_update_atk_spd()


func atk_dmg() -> int: return _atk_dmg
func atk_spd() -> float: return _atk_spd


func add_atk_dmg_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_atk_dmg_mod[mod_name] = mod
	_update_atk_dmg()

func add_atk_spd_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_atk_spd_mod[mod_name] = mod
	_update_atk_spd()

func rm_atk_dmg_mod(mod_name: String) -> void:
	_atk_dmg_mod.erase(mod_name)
	_update_atk_dmg()

func rm_atk_spd_mod(mod_name: String) -> void:
	_atk_spd_mod.erase(mod_name)
	_update_atk_spd()

func _update_atk_dmg() -> void:
	var total_mod := 1.0
	for mod: float in _atk_dmg_mod.values():
		total_mod *= mod

	_atk_dmg = int(_premod_atk_dmg * total_mod)

func _update_atk_spd() -> void:
	var total_mod := 1.0
	for mod: float in _atk_spd_mod.values():
		total_mod *= mod

	_atk_spd = _premod_atk_spd * total_mod

func _level_up_stats() -> void:
	_premod_atk_dmg = int(_premod_atk_dmg * ATK_DMG_MUL_FACTOR + ATK_DMG_ADD_FACTOR)
	_update_atk_dmg()

var _premod_atk_dmg: int
var _premod_atk_spd: float

var _atk_dmg_mod: Dictionary
var _atk_spd_mod: Dictionary

var _atk_dmg: int
var _atk_spd: float
