extends Node2D

## mallet.gd: Implements the interface and signals related to the player's mallet
##
## Author(s): Phuwasate Lutchanont, Tessa Power

# ====================Public Interface====================

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hit_area: Area2D = $HitArea


func _process(_delta) -> void:
	set_global_position(get_viewport().get_mouse_position())


func _on_hit() -> void:
	# Get any overlapping areas
	if hit_area.has_overlapping_bodies():
		var overlapping = hit_area.get_overlapping_bodies()
		for obj in overlapping:
			if obj.is_in_group("whackable"):
				obj.on_hit()


func attack():
	anim_player.play("attack")
