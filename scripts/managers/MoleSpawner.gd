extends Node

# ====================Public Interface====================

@export var spawn_area: Rect2
@export var mole_scene: PackedScene

@onready var spawn_timer: Timer = $Timer

signal mole_spawned(mole: Node2D, position: Vector2)

func spawn_mole():
	mole_spawned.emit(
		mole_scene.instantiate() as Node2D,
		_get_random_spawn_point());

# ====================Internal details====================

# ----------Inhertied from parent---------- 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Assertions
	assert(spawn_timer != null)
	assert(mole_scene != null)

	spawn_timer.timeout.connect(_on_spawn_timer_timeouted)

# ----------Callbacks----------

func _on_spawn_timer_timeouted():
	spawn_mole()

# ----------Private Implementations----------

func _get_random_spawn_point() -> Vector2:
	return Vector2(
		randf_range(spawn_area.position.x, spawn_area.end.x),
		randf_range(spawn_area.position.y, spawn_area.end.y));
