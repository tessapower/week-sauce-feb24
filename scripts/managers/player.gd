class_name Player

func reset() -> void:
	_exp_system.reset()
	_hp_system.reset()
	_stat_system.reset()
	_power_up_system.reset()


func exp_system() -> ExperienceSystem: return _exp_system
func hp_system() -> HealthSystem: return _hp_system
func stat_system() -> StatSystem: return _stat_system
func power_up_system() -> PowerUpSystem: return _power_up_system
func sound_system() -> SoundSystem: return _sound_system

var _exp_system := ExperienceSystem.new()
var _hp_system := HealthSystem.new(_exp_system)
var _stat_system := StatSystem.new(_exp_system)
var _power_up_system := PowerUpSystem.new(self)
var _sound_system := SoundSystem.new(_exp_system, _hp_system)


signal perma_attack_changed(state: bool)

func set_perma_attack(state: bool = true) -> void:
	_perma_attack = state
	perma_attack_changed.emit(_perma_attack)

func perma_attack() -> bool: return _perma_attack
var _perma_attack: bool = false


func attack_effect() -> PackedScene: return _attack_effect
func set_attack_effect(scene: PackedScene) -> void: _attack_effect = scene
var _attack_effect: PackedScene
