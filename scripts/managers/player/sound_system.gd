class_name SoundSystem

const GAINED_EXP_SOUND := preload("res://assets/sounds/coin.mp3")
const LEVELED_UP_SOUND := preload("res://assets/sounds/cute-level-up.mp3")

const HURT_SOUND := preload("res://assets/sounds/hurt.mp3")
const DIED_SOUND := preload("res://assets/sounds/negative_beeps.mp3")

func _init(exp_system: ExperienceSystem, hp_system: HealthSystem):
	exp_system.exp_gained.connect(func(): SoundManager.play_sound(GAINED_EXP_SOUND))
	exp_system.leveled_up.connect(func(): SoundManager.play_sound(LEVELED_UP_SOUND))

	hp_system.damaged.connect(func(): SoundManager.play_sound(HURT_SOUND))
	hp_system.hp_reached_zero.connect(func(): SoundManager.play_sound(DIED_SOUND))
