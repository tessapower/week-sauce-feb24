class_name TimeSystem

func process(delta: float) -> void:
	_time_elapsed += delta

func reset() -> void:
	_time_elapsed = 0

func time_elapsed() -> float: return _time_elapsed

var _time_elapsed: float
