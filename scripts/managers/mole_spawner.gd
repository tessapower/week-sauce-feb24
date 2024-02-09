extends Node

# mole_spawner.gd:
#	Handles the instantiation of mole and the location at which to spawn it.
#	This class does not handle the addition of the instantiated mole
#	to the scene tree and setting its position. A manager must be connected
#	to the 'mole_spawned' signal and handles the aforementioned procedures.

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

## A [code]ReferenceRect[/code] which outlines where moles can be spawned.
@export var spawn_area: ReferenceRect

## The mole scene to be spawned.
@export var mole_scene: PackedScene

signal mole_spawned(mole: Mole, position: Vector2)

func spawn_mole():
	mole_spawned.emit(
		mole_scene.instantiate() as Mole,
		SpawnUtils.random_spawn_point(spawn_area))

# ====================Internal details====================

# ----------Inherited from parent----------

func _ready():
	# Assertions
	assert(mole_scene != null)
	assert(spawn_area != null)


# ----------Callbacks----------

func _on_timer_timeout():
	spawn_mole()
