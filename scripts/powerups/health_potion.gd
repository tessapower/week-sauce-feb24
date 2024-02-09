extends CharacterBody2D

# mole_spawner.gd:
#	Handles the instantiation of mole and the location at which to spawn it.
#	This class does not handle the addition of the instantiated mole
#	to the scene tree and setting its position. A manager must be connected
#	to the 'mole_spawned' signal and handles the aforementioned procedures.

# Author: Tessa Power

const INCREASE: int = 30

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

func _ready():
	animated_sprite.play("emerge")


func on_hit() -> void:
	if animated_sprite.animation == "idle":
		collision_shape.set_deferred("disabled", true)
		game_state_manager.heal(INCREASE)
		# TODO: replace disappear animation with "+INCREASE" text
		animated_sprite.play("disappear")


func _on_disappear_timer_timeout():
	if animated_sprite.animation == "idle":
		animated_sprite.play("disappear")
		collision_shape.set_deferred("disabled", true)


func _on_animation_finished():
	match animated_sprite.animation:
		"emerge":
			$DisappearTimer.start()
			animated_sprite.play("idle")
		"disappear":
			queue_free()
		_:
			animated_sprite.play("idle")
