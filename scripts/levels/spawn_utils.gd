class_name SpawnUtils extends Node

static var spawn_area_start: Vector2
static var spawn_area_end: Vector2

static func random_spawn_point(spawn_area: ReferenceRect) -> Vector2:
	spawn_area_start = spawn_area.get_global_position()
	spawn_area_end = spawn_area_start + spawn_area.size

	return Vector2(
		randf_range(spawn_area_start.x, spawn_area_end.x),
		randf_range(spawn_area_start.y, spawn_area_end.y))
