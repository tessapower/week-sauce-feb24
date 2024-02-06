extends Node2D

# mallet.gd: Implements the interface and signals related to the player's mallet

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _process(_delta):
	set_global_position(get_viewport().get_mouse_position())


func attack():
	anim_player.play("attack")
