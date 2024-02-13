class_name PowerUpSystem


const DB := preload("res://resources/powerups/power_up_db.tres")

func _init(player_: Player) -> void:
	_player = player_
	call_deferred("init_deferred")

func init_deferred() -> void:
	_player.exp_system().leveled_up.connect(_on_player_leveled_up)


func reset() -> void:
	_power_up_data = {}


func _on_player_leveled_up() -> void:
	# TODO: pause the game
	# TODO: display the power up UI
	pass

# Dictionary[StringName, PowerUp.Data]
# Each entry is meant to be used by the corresponding power up
# Do not touch!
func power_up_data() -> Dictionary: return _power_up_data
var _power_up_data: Dictionary

func player() -> Player: return _player
var _player: Player
