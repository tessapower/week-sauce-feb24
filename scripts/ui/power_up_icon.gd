extends Control

## powerup_icon.gd: Allows a power up icon scene to be instantiated conveniently
##					through code.
##
## Author(s): Tessa Power

var power_up_name: StringName = ""
var power_up_level: int = 1

@onready var _skill: TextureRect = $Content/Border/CenterContainer/PanelContainer/Skill
@onready var _label: Label = $Content/Label


func set_power_up_icon(new_icon: Texture) -> void:
	_skill.set_texture(new_icon)


func set_power_up_name(new_name: StringName) -> void:
	power_up_name = new_name
	_update_text()


func set_power_up_level(new_level: int) -> void:
	power_up_level = new_level
	_update_text()

func _update_text() -> void:
	if power_up_level == PowerUp.FINAL_LEVEL:
		_label.text = power_up_name + ": LVL MAX"
	else:
		_label.text = power_up_name + ": LVL %01d" % power_up_level
