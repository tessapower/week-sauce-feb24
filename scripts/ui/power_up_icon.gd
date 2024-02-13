extends Control

## powerup_icon.gd: Allows a power up icon scene to be instantiated conveniently
##					through code.
##
## Author(s): Tessa Power

var power_up_name: StringName = ""
var power_up_level: int = 1

func set_power_up_icon(new_icon: Texture) -> void:
	$Content/Border/Skill.set("Texture", new_icon)


func set_power_up_name(new_name: StringName) -> void:
	power_up_name = new_name
	$Content/Label.text = power_up_name + ": LVL %01d" % power_up_level


func set_power_up_level(new_level: int) -> void:
	power_up_level = new_level
	$Content/Label.text = power_up_name + ": LVL %01d" % power_up_level
