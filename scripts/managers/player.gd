class_name Player

func _init() -> void:
	_exp_system = ExperienceSystem.new()
	_hp_system = HealthSystem.new(_exp_system)
	_stat_system = StatSystem.new(_exp_system)
	_sound_system = SoundSystem.new(_exp_system, _hp_system)


func reset() -> void:
	_exp_system.reset()
	_hp_system.reset()
	_stat_system.reset()

func exp_system() -> ExperienceSystem: return _exp_system
func hp_system() -> HealthSystem: return _hp_system
func stat_system() -> StatSystem: return _stat_system
func sound_system() -> SoundSystem: return _sound_system

var _exp_system: ExperienceSystem
var _hp_system: HealthSystem
var _stat_system: StatSystem
var _sound_system: SoundSystem
