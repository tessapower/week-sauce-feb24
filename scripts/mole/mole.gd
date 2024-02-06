class_name Mole extends CharacterBody2D
## mole.gd: Controls the mole enemy character.
##
## Author(s): Tessa Power

## Animations
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("emerge")


## Callback function for when the mole's animated sprite finishes an animation,
## and sets the next animation appropriately.
func _on_animation_finished() -> void:
	match animated_sprite.animation:
		"emerge":
			animated_sprite.play("idle")
