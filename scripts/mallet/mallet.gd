extends Node2D

var anim_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player = $AnimationPlayer

func attack():
	anim_player.play("attack")
