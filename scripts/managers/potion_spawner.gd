extends Node2D

## potion_spawner.gd: Handles instantiating potions, including generating a
##	random location in given spawn area. Does not handle adding the
##	instantiated potion to the scene tree and setting its position, but rather
##	emits the instantiated potion and the random position through the signal
##	[code]health_potion_spawned(potion: HealthPotion, position: Vector2)[/code].
##
## Author(s): Tessa Power

## A [code]ReferenceRect[/code] which outlines where potions can be spawned.
@export var spawn_area: ReferenceRect
@export_range(0.0, 1.0, 0.05) var chance_of_potion: float = 0.5

const BUFFER_AREA = preload("res://scenes/mole/buffer_area.tscn")
@onready var buffer = BUFFER_AREA.instantiate()

## The health potion scene to be spawned.
@export var health_potion: PackedScene

signal health_potion_spawned(potion: Node2D, position: Vector2)

func _ready() -> void:
	assert(spawn_area != null)
	assert(health_potion != null)

	var random_point = SpawnUtils.random_spawn_point(spawn_area)
	buffer.set_global_position(random_point)
	add_child(buffer)


func _physics_process(_delta) -> void:
	if buffer.has_overlapping_bodies() or buffer.has_overlapping_areas():
		buffer.set_global_position(SpawnUtils.random_spawn_point(spawn_area))


func _on_timer_timeout() -> void:
	spawn_health_potion()


func spawn_health_potion() -> void:
	var current_health = game_state_manager.player().hp_system().hp()
	var max_health = game_state_manager.player().hp_system().max_hp()

	if current_health < max_health and randf() < chance_of_potion:
		emit_signal("health_potion_spawned", health_potion.instantiate(), buffer.global_position)
