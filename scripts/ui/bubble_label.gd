extends Label

@export var direction: float = 0.5
var font_color: Color = Color.WHITE
var final_color: Color = Color.TRANSPARENT
var tween: Tween


func _ready() -> void:
	play_animation()


func init(string: String, color: Color, pos: Vector2) -> void:
	text = string
	set("theme_override_colors/font_color", color)
	global_position = pos


func play_animation() -> void:
	tween = create_tween().set_parallel(true)
	tween.tween_property(self, "theme_override_colors/font_color", Color.TRANSPARENT, 1.0)
	tween.parallel().tween_property(self, "global_position:y", global_position.y - 150, 1.0)
	await tween.finished
	queue_free()
