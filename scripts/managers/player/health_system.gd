class_name HealthSystem

const BASE_MAX_HP := 100
const MAX_HP_MUL_FACTOR := 1.1
const MAX_HP_ADD_FACTOR := 30


signal max_hp_changed(new_value: int)
signal hp_changed(new_value: int)
signal hp_reached_zero()
signal damaged()
signal healed()


func _init(exp_system: ExperienceSystem) -> void:
	exp_system.leveled_up.connect(_level_up_stats)

func reset() -> void:
	_premod_max_hp = BASE_MAX_HP

	_max_hp_mod = {}

	_update_max_hp()

	_hp = _max_hp

	_emit_signals()


func max_hp() -> int: return _max_hp
func hp() -> int: return _hp

func apply_damage(amount: int) -> void:
	_hp = max(0, _hp - amount)
	hp_changed.emit(_hp)
	damaged.emit()
	if _hp == 0: hp_reached_zero.emit()

func heal(amount: int) -> void:
	_hp = min(_max_hp, _hp + amount)
	hp_changed.emit(_hp)
	healed.emit()

func add_max_hp_mod(mod_name: String, mod: float) -> void:
	assert(mod >= 0)
	_max_hp_mod[mod_name] = mod
	_update_max_hp()
	_emit_signals()

func rm_max_hp_mod(mod_name: String) -> void:
	_max_hp_mod.erase(mod_name)
	_update_max_hp()
	_emit_signals()

func _update_max_hp() -> void:
	var hp_ratio := float(_hp) / float(_max_hp)
	var total_mod := 1.0
	for mod: float in _max_hp_mod.values():
		total_mod *= mod

	_max_hp = int(_premod_max_hp * total_mod)
	_hp = int(hp_ratio * _max_hp)


func _level_up_stats() -> void:
	_premod_max_hp = int(_premod_max_hp * MAX_HP_MUL_FACTOR + MAX_HP_ADD_FACTOR)
	_update_max_hp()
	_hp = _max_hp
	_emit_signals()


func _emit_signals() -> void:
	max_hp_changed.emit(_max_hp)
	hp_changed.emit(_hp)
	if _hp == 0: hp_reached_zero.emit()


var _premod_max_hp: int

var _max_hp_mod: Dictionary

var _max_hp: int
var _hp: int
