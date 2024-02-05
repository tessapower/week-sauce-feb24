extends Node

signal attacked()
signal skill_used(num: int)

func _input(event: InputEvent):
	if event.is_action_pressed("attack"):
		attacked.emit()
	elif event.is_action_pressed("skill_1"):
		skill_used.emit(1)
	elif event.is_action_pressed("skill_2"):
		skill_used.emit(2)
	elif event.is_action_pressed("skill_3"):
		skill_used.emit(3)
	elif event.is_action_pressed("skill_4"):
		skill_used.emit(4)
