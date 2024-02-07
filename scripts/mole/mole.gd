class_name Mole extends CharacterBody2D
## mole.gd: Represents the mole enemy character
##			Interface includes: controlling the mole, interaction with its stats.
##
## Author(s): Phuwasate Lutchanont, Tessa Power

## Animations
@onready var animated_sprite = $AnimatedSprite2D

@export var data: MoleData


signal mole_died(data: MoleData)


var max_health: int:
	get: return max_health


var current_health: int:
	get: return current_health


## Callback function intended to be called when hit by the player's mallet.
func on_hit() -> void:
	# TODO: refactor this to take a damage value when powerups are implemented
	apply_damage(10)


# TODO: respond appropriately to mole's health.
# 		health < 0: mole flash animation
#		health == 0: mole died animation

func apply_damage(value: int) -> void:
	current_health = max(0, current_health - value)
	if current_health == 0: mole_died.emit(data)


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
	max_health = data.max_health
	current_health = max_health

