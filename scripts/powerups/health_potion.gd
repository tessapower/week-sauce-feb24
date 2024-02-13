class_name HealthPotion extends CharacterBody2D

## health_potion.gd: A health potion that gives the player back some of their
##	health throughout the game.
##
## Author: Tessa Power

const INCREASE: int = 30

const HEAL_SOUND := preload("res://assets/sounds/coin-collect-retro-8-bit-sound-effect.mp3")

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

signal hit(pos: Vector2)

func _ready():
	animated_sprite.play("emerge")


func on_hit() -> void:
	if animated_sprite.animation == "idle":
		collision_shape.set_deferred("disabled", true)
		game_state_manager.player().hp_system().heal(INCREASE)
		SoundManager.play_sound(HEAL_SOUND)
		animated_sprite.play("disappear")
		emit_signal("hit", global_position, INCREASE)


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
