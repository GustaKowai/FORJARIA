extends Node

signal mini_game_snake_end()
signal mini_game_snake_score(int)
signal mini_game_start()
signal exit_minigame()
var is_game_over:bool = false
var jogador:Jogador
var multiplicador_de_qualidade:float
#var player_position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
