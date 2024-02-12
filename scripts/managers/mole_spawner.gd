extends Node

## mole_spawner.gd:
##	Handles the instantiation of mole and the location at which to spawn it.
##	This class does not handle the addition of the instantiated mole
##	to the scene tree and setting its position. A manager must be connected
##	to the 'mole_spawned' signal and handles the aforementioned procedures.
##
## Author(s): Phuwasate Lutchanont, Tessa Power

# ====================Public Interface====================

## A [code]ReferenceRect[/code] which outlines where moles can be spawned.
@export var spawn_area: ReferenceRect

## The mole scene to be spawned.
@export var mole_scene: PackedScene
const GOLDEN_MOLE = preload("res://scenes/mole/golden_mole.tscn")
@export_range(0.0, 1.0, 0.05) var chance_of_golden_mole = 0.1

const BUFFER_AREA = preload("res://scenes/mole/buffer_area.tscn")
@onready var buffer = BUFFER_AREA.instantiate()

signal mole_spawned(mole: Mole, position: Vector2)

func spawn_mole():
	if randf() < chance_of_golden_mole:
		mole_spawned.emit(GOLDEN_MOLE.instantiate() as Mole, buffer.global_position)
	else:
		mole_spawned.emit(mole_scene.instantiate() as Mole, buffer.global_position)

# ====================Internal details====================

# ----------Inherited from parent----------

func _ready():
	# Assertions
	assert(mole_scene != null)
	assert(spawn_area != null)

	# Buffer Object
	var random_point = SpawnUtils.random_spawn_point(spawn_area)
	buffer.set_global_position(random_point)
	add_child(buffer)


func _physics_process(_delta) -> void:
	if buffer.has_overlapping_bodies():
		buffer.set_global_position(SpawnUtils.random_spawn_point(spawn_area))


# ----------Callbacks----------

func _on_timer_timeout():
	spawn_mole()
