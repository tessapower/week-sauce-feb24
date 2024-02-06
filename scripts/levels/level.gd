class_name Level extends Node
## level.gd: This script manages adding spawned moles to the level scene.
##
## Author(s): Tessa Power

@onready var spawn_timer = $MoleSpawner/Timer
@onready var mallet: Node2D = $Mallet

const PAUSE_POPUP = preload("res://scenes/ui/pause_popup.tscn")
@onready var pause = PAUSE_POPUP.instantiate()

func _ready() -> void:
	add_child(pause)
	spawn_timer.start()


func _input(event) -> void:
	if event.is_action_pressed("attack"):
		mallet.attack()
	elif event.is_action_pressed("pause"):
		GameStateManager.set("is_paused", true)
		pause.show()


func _on_mole_spawned(mole: Mole, position: Vector2) -> void:
	mole.set_global_position(position)
	add_child(mole)
