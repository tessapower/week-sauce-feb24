class_name PauseSystem

signal paused()
signal unpaused()

func _init(node: Node) -> void:
	_node = node

func is_paused() -> bool: return _is_paused

func set_paused(state: bool = true) -> void:
	if _is_paused == state: return

	_is_paused = state
	_node.get_tree().paused = _is_paused

	if is_paused: paused.emit()
	else: unpaused.emit()


var _is_paused: bool = false
var _node: Node
