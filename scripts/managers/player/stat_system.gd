class_name StatSystem


const BASE_ATK_DMG := 50
const ATK_DMG_MUL_FACTOR := 1.05
const ATK_DMG_ADD_FACTOR := 10

const BASE_ATK_SPD := 1.75

const BASE_ATK_RADIUS := 35.0


signal atk_dmg_changed(new_value: int)
signal atk_spd_changed(new_value: float)
signal atk_radius_changed(new_value: float)


func _init(exp_system: ExperienceSystem) -> void:
	exp_system.leveled_up.connect(_level_up_stats)


func reset() -> void:
	_premod_atk_dmg = BASE_ATK_DMG
	_premod_atk_spd = BASE_ATK_SPD
	_premod_atk_radius = BASE_ATK_RADIUS

	_atk_dmg_mod = {}
	_atk_spd_mod = {}
	_atk_radius_mod = {}

	_update_atk_dmg()
	_update_atk_spd()
	_update_atk_radius()

	atk_dmg_changed.emit(_atk_dmg)
	atk_spd_changed.emit(_atk_spd)
	atk_radius_changed.emit(_atk_radius)


func atk_dmg() -> int: return _atk_dmg
func atk_spd() -> float: return _atk_spd
func atk_radius() -> float: return _atk_radius


func add_atk_dmg_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_atk_dmg_mod[mod_name] = mod
	_update_atk_dmg()
	atk_dmg_changed.emit(_atk_dmg)

func add_atk_spd_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_atk_spd_mod[mod_name] = mod
	_update_atk_spd()
	atk_spd_changed.emit(_atk_spd)

func add_atk_radius_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_atk_radius_mod[mod_name] = mod
	_update_atk_radius()
	atk_radius_changed.emit(_atk_radius)


func rm_atk_dmg_mod(mod_name: String) -> void:
	_atk_dmg_mod.erase(mod_name)
	_update_atk_dmg()
	atk_dmg_changed.emit(_atk_dmg)

func rm_atk_spd_mod(mod_name: String) -> void:
	_atk_spd_mod.erase(mod_name)
	_update_atk_spd()
	atk_spd_changed.emit(_atk_spd)

func rm_atk_radius_mod(mod_name: String) -> void:
	_atk_radius_mod.erase(mod_name)
	_update_atk_radius()
	atk_radius_changed.emit(_atk_radius)


func _update_atk_dmg() -> void:
	_atk_dmg = int(_premod_atk_dmg * _get_total_mod(_atk_dmg_mod))

func _update_atk_spd() -> void:
	_atk_spd = _premod_atk_spd * _get_total_mod(_atk_spd_mod)

func _update_atk_radius() -> void:
	_atk_radius = _premod_atk_radius * _get_total_mod(_atk_radius_mod)

func _get_total_mod(mods: Dictionary) -> float:
	var total_mod := 1.0
	for mod: float in mods.values():
		total_mod *= mod

	return total_mod

func _level_up_stats() -> void:
	_premod_atk_dmg = int(_premod_atk_dmg * ATK_DMG_MUL_FACTOR + ATK_DMG_ADD_FACTOR)
	_update_atk_dmg()
	atk_dmg_changed.emit(_atk_dmg)


var _premod_atk_dmg: int
var _premod_atk_spd: float
var _premod_atk_radius: float

var _atk_dmg_mod: Dictionary
var _atk_spd_mod: Dictionary
var _atk_radius_mod: Dictionary

var _atk_dmg: int
var _atk_spd: float
var _atk_radius: float
