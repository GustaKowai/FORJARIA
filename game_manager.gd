extends Node

signal mini_game_snake_end()
signal mini_game_snake_score(int)
signal mini_game_start()
signal exit_minigame()
signal chama_cliente()
signal pedido_entrou_saiu(int)
signal mao_animacao(String)
signal fim_do_dia()
signal comeco_do_dia()
var mao_em_uso:String
var is_game_over:bool = false
var jogador:Jogador
var multiplicador_de_qualidade:float
var direcao_tesoura:String #c = cima, b = baixo, e = esquerda, d = direita
var valor_do_couro:int
var fama:int = 0
var ouro:int = 0
var posicao_comeco_dia:Vector2
var pedidos_corretos:int = 0
var pedidos_errados:int = 0
var pedidos_incompletos:int = 0
signal muda_ouro(int)
signal muda_fama(int)
#var player_position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
