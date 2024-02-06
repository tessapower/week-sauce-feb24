class_name Mole extends CharacterBody2D
## mole.gd: Represents the mole enemy character
##			Interface includes: controlling the mole, interaction with its stats.
##
## Author(s): Tessa Power, Phuwasate Lutchanont

## Animations
@onready var animated_sprite = $AnimatedSprite2D

@export var data: MoleData


signal mole_died(data: MoleData)


var max_health: int:
	get: return _max_health

var current_health: int:
	get: return _current_health


func apply_damage(value: int) -> void:
	_current_health = max(0, _current_health - value)
	if _current_health == 0: mole_died.emit(data)


func _ready() -> void:
	assert(data != null)
	_load_data()

	animated_sprite.play("emerge")


## Callback function for when the mole's animated sprite finishes an animation,
## and sets the next animation appropriately.
func _on_animation_finished() -> void:
	match animated_sprite.animation:
		"emerge":
			animated_sprite.play("idle")


# Initialzes mole stats from the data
func _load_data() -> void:
	_max_health = data.max_health
	_current_health = _max_health


var _current_health: int
var _max_health: int
