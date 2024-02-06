extends Node2D

# mallet.gd: Implements the interface and signals related to the player's mallet

# Author: Phuwasate Lutchanont

# ====================Public Interface====================

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func attack():
	anim_player.play("attack")
