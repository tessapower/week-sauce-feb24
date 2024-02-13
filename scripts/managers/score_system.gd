class_name ScoreSystem

signal current_score_changed(new_value: int)
signal high_score_changed(new_value: int)

func reset() -> void:
	_current_score = 0
	current_score_changed.emit(_current_score)

func current_score() -> int: return _current_score
func high_score() -> int: return _high_score

func add_current_score(amount: int) -> void:
	_current_score += amount
	current_score_changed.emit(_current_score)
	if _current_score > _high_score:
		_high_score = _current_score
		high_score_changed.emit(_high_score)


var _current_score: int = 0
var _high_score: int = 0
