extends Bloquinho

func _ready() -> void:
	GameManager.mini_game_snake_end.connect(sobrou)
	
func sobrou():
	if !cortado:
		GameManager.mini_game_snake_score.emit(-pontos)
		print_debug("sobrou")
