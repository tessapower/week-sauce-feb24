class_name FlashingLabel extends Label

## flashing_gd: A simple extension to a label that will flash on demand.
##
## Author(s): Tessa Power

func flash() -> void:
	$Flash.play("flash")
