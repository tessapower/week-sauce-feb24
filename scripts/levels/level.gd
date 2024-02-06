class_name Level extends Node

## level.gd: This script manages adding spawned moles to the level scene.
##
## Author(s): Tessa Power

@onready var spawn_timer = $MoleSpawner/Timer

func _ready() -> void:
	spawn_timer.start()


func _on_mole_spawned(mole: Mole, position: Vector2) -> void:
	mole.set_global_position(position)
	#print("spawned mole at:", mole.global_position)
	add_child(mole)