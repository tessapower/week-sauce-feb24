extends Node

# ====================Public Interface====================

@export var spawn_area: Area2D
@export var mole_scene: PackedScene

signal mole_spawned(mole: Mole, position: Vector2)

func spawn_mole():
	mole_spawned.emit(
		mole_scene.instantiate() as Mole,
		_get_random_spawn_point())

# ====================Internal details====================

# ----------Inherited from parent----------

func _ready():
	# Assertions
	assert(mole_scene != null)

# ----------Callbacks----------

func _on_timer_timeout():
	spawn_mole()

# ----------Private Implementations----------

func _get_random_spawn_point() -> Vector2:
	return Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y))
