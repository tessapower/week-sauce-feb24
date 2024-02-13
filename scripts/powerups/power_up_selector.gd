extends Control

func _ready():
	assert(_skills_container)
	assert(_hud)

	hide()
	game_state_manager.player().exp_system().leveled_up.connect(_on_player_leveled_up)

func _on_player_leveled_up() -> void:
	var power_ups := game_state_manager.player().power_up_system().DB.get_random_power_ups(2)
	if power_ups.is_empty(): return

	game_state_manager.pause_system().set_paused()

	for power_up in power_ups: _add_skill_button(power_up)
	show()

func _on_skill_button_pressed(power_up: PowerUp) -> void:
	power_up.apply(game_state_manager.player().power_up_system())
	_hud.add_or_update_powerup(power_up)
	hide()
	_clear_skills_container()
	game_state_manager.pause_system().set_paused(false)

func _add_skill_button(power_up: PowerUp) -> void:
	var button := TextureButton.new()
	button.texture_normal = power_up.icon
	button.pressed.connect(func(): _on_skill_button_pressed(power_up))
	_skills_container.add_child(button)

func _clear_skills_container() -> void:
	for child in _skills_container.get_children():
		child.queue_free()

@export var _skills_container: Control
@export var _hud: Hud
