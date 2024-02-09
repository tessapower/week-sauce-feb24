class_name Level extends Node
## level.gd: This script manages adding spawned moles to the level scene.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

@onready var spawn_timer = $MoleSpawner/Timer
@onready var mallet: Node2D = $Mallet

const HEALTH_POTION = preload("res://scenes/powerups/health_potion.tscn")
const HEALTH_POTION_CHANCE: float = 1.0

const PAUSE_POPUP = preload("res://scenes/ui/pause_popup.tscn")
@onready var pause = PAUSE_POPUP.instantiate()

const HUD = preload("res://scenes/ui/hud.tscn")
@onready var hud = HUD.instantiate()


func _ready() -> void:
	add_child(pause)
	add_child(hud)

	game_state_manager.initialize_for_scene()
	spawn_timer.start()
	game_state_manager.player_died.connect(_on_game_over)


func _input(event) -> void:
	if event.is_action_pressed("attack"):
		mallet.attack()
	elif event.is_action_pressed("pause"):
		game_state_manager.set("is_paused", true)
		pause.show()


func _on_mole_spawned(mole: Mole, position: Vector2) -> void:
	mole.set_global_position(position)
	add_child(mole)


func _on_health_potion_timer_timeout():
	var current_health = game_state_manager.player_health
	var max_health = game_state_manager.player_max_health
	if current_health < max_health and randf() < HEALTH_POTION_CHANCE:
		var potion: Node2D = HEALTH_POTION.instantiate()
		potion.set_global_position(SpawnUtils.random_spawn_point($SpawnArea))
		add_child(potion)


func _on_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")
