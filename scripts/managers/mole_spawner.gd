extends Node

# ====================Public Interface====================

## A [code]ReferenceRect[/code] which outlines where moles can be spawned.
@export var spawn_area: ReferenceRect

## The mole scene to be spawned.
@export var mole_scene: PackedScene

signal mole_spawned(mole: Mole, position: Vector2)

func spawn_mole():
	mole_spawned.emit(
		mole_scene.instantiate() as Mole,
		_get_random_spawn_point())

# ====================Internal details====================

# ----------Inherited from parent----------

var spawn_area_start: Vector2
var spawn_area_end: Vector2

func _ready():
	# Assertions
	assert(mole_scene != null)
	assert(spawn_area != null)
	spawn_area_start = spawn_area.get_global_position()
	spawn_area_end = spawn_area_start + spawn_area.size



# ----------Callbacks----------

func _on_timer_timeout():
	spawn_mole()

# ----------Private Implementations----------

func _get_random_spawn_point() -> Vector2:
	return Vector2(
		randf_range(spawn_area_start.x, spawn_area_end.x),
		randf_range(spawn_area_start.y, spawn_area_end.y))
