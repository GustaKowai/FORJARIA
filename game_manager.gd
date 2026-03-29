extends Node

signal mini_game_snake_end()
signal mini_game_snake_score(int)
signal mini_game_start()
signal exit_minigame()
signal chama_cliente()
signal pedido_entrou_saiu(int)
var is_game_over:bool = false
var jogador:Jogador
var multiplicador_de_qualidade:float
var direcao_tesoura:String #c = cima, b = baixo, e = esquerda, d = direita
var valor_do_couro:int
var fama:int = 0
var ouro:int = 0
signal muda_ouro()
signal muda_fama()
#var player_position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
