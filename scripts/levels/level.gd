class_name Level extends Node
## level.gd: This script manages adding spawned moles to the level scene.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

@onready var spawn_timer = $MoleSpawner/Timer
@onready var mallet: Node2D = $Mallet

const PAUSE_POPUP = preload("res://scenes/ui/pause_popup.tscn")
const HUD = preload("res://scenes/ui/hud.tscn")

@onready var pause = PAUSE_POPUP.instantiate()
@onready var hud = HUD.instantiate()

func _ready() -> void:
	add_child(pause)
	add_child(hud)

	game_state_manager.initialize_for_scene()
	spawn_timer.start()


func _input(event) -> void:
	if event.is_action_pressed("attack"):
		mallet.attack()
	elif event.is_action_pressed("pause"):
		game_state_manager.set("is_paused", true)
		pause.show()


func _on_mole_spawned(mole: Mole, position: Vector2) -> void:
	mole.set_global_position(position)
	add_child(mole)
