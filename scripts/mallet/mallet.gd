extends Node2D

## mallet.gd: Implements the interface and signals related to the player's mallet
##
## Author(s): Phuwasate Lutchanont, Tessa Power

# ====================Public Interface====================

const HIT_SOUND: AudioStream = preload("res://assets/sounds/bonk-sound-effect.mp3")

const ATTACK_BUFFER_TIMEOUT := 0.5

@export var level: Level


@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hit_area: Area2D = $HitArea
@onready var anim_length: float = anim_player.get_animation("attack").length
@onready var player: Player = game_state_manager.player()
@onready var stat_system: StatSystem = player.stat_system()
@onready var collision_area: CollisionShape2D = hit_area.get_child(0)
@onready var collision_shape: CircleShape2D = collision_area.shape
@onready var base_collision_radius: float = collision_shape.radius


func _ready() -> void:
	assert(level)

	anim_player.animation_finished.connect(_on_animation_finished)
	player.perma_attack_changed.connect(_on_player_perma_attack_changed)
	player.stat_system().atk_radius_changed.connect(_on_player_attack_radius_changed)

func _process(delta: float) -> void:
	set_global_position(get_viewport().get_mouse_position())
	_process_attack_buffer(delta)


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		if _attack_buffered:
			_dispatch_attack()
			_unset_attack_buffered()
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

	# Spawn special effect
	var effect = player.attack_effect()
	if effect:
		var effect_instance = effect.instantiate()
		level.add_child(effect_instance)
		effect_instance.set_global_position(collision_area.global_position)


func _process_attack_buffer(delta: float) -> void:
	if _attack_buffered:
		_attack_buffer_time_left -= delta
		if _attack_buffer_time_left <= 0:
			_unset_attack_buffered()

func attack() -> void:
	if _is_attacking:
		_attack_buffered = true
		_attack_buffer_time_left = ATTACK_BUFFER_TIMEOUT
	else:
		_dispatch_attack()
		_is_attacking = true

func attack_damage() -> int: return stat_system.atk_dmg()
func attack_speed() -> float: return stat_system.atk_spd()

func _dispatch_attack() -> void:
	var playback_speed := anim_length * attack_speed()
	anim_player.play("attack", -1, playback_speed)


func _on_player_perma_attack_changed(state: bool) -> void:
	if state:
		attack()
		attack()


func _on_player_attack_radius_changed(value: float) -> void:
	collision_shape.radius = value


func _unset_attack_buffered() -> void:
	_attack_buffered = player.perma_attack()

var _attack_buffered: bool = false
var _attack_buffer_time_left: float
var _is_attacking: bool = false
