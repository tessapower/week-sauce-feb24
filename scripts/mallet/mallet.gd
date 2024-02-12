extends Node2D

## mallet.gd: Implements the interface and signals related to the player's mallet
##
## Author(s): Phuwasate Lutchanont, Tessa Power

# ====================Public Interface====================

const HIT_SOUND: AudioStream = preload("res://assets/sounds/bonk-sound-effect.mp3")

const ATTACK_BUFFER_TIMEOUT := 0.5

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hit_area: Area2D = $HitArea

@export var attack_speed: float = 2.0

@onready var anim_length: float = anim_player.get_animation("attack").length

func _ready() -> void:
	anim_player.animation_finished.connect(_on_animation_finished)

func _process(delta: float) -> void:
	set_global_position(get_viewport().get_mouse_position())
	_process_attack_buffer(delta)


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		if _attack_buffered:
			_dispatch_attack()
			_attack_buffered = false
		else:
			_is_attacking = false


func _on_hit() -> void:
	# Get any overlapping areas
	if hit_area.has_overlapping_bodies():
		var overlapping = hit_area.get_overlapping_bodies()
		for obj in overlapping:
			if obj.is_in_group("whackable"):
				obj.on_hit()
				SoundManager.play_sound_with_pitch(HIT_SOUND, randf_range(0.75, 1.25))


var _attack_buffered: bool = false
var _attack_buffer_time_left: float
var _is_attacking: bool = false

func _process_attack_buffer(delta: float) -> void:
	if _attack_buffered:
		_attack_buffer_time_left -= delta
		if _attack_buffer_time_left <= 0:
			_attack_buffered = false

func attack() -> void:
	if _is_attacking:
		_attack_buffered = true
		_attack_buffer_time_left = ATTACK_BUFFER_TIMEOUT
	else:
		_dispatch_attack()
		_is_attacking = true

func _dispatch_attack() -> void:
	var playback_speed := anim_length * attack_speed
	anim_player.play("attack", -1, playback_speed)
