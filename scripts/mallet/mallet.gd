extends Node2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func attack():
	anim_player.play("attack")
