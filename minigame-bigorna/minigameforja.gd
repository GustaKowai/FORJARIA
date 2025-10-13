extends Control

signal minigame_finalizado(qualidade_minigame_bonus: float)

@onready var barra_alvo: TextureRect = %BarraAlvo
@onready var indicador_martelo: TextureRect = %IndicadorMartelo

# Configurações do minigame
var velocidade_indicador: float = 200.0
var direcao_indicador: int = 1
var marteladas_restantes: int = 5

# Variável para acumular a pontuação do minigame (de 0 a 100 por martelada)
var pontuacao_total_minigame: float = 0.0

#marcadores
var zona_verde_y_min: float = 80
var zona_verde_y_max: float = 120 # Ex: do pixel Y 80 ao 120 é verde
var zona_amarela_y_min: float = 60
var zona_amarela_y_max: float = 140 # Ex: do pixel Y 60 ao 140 é amarelo (excluindo verde)
var zona_laranja_y_min: float = 40
var zona_laranja_y_max: float = 160 # Ex: do pixel Y 40 ao 160 é laranja (excluindo amarelo e verde)
var zona_vermelha_y_min: float = 0
var zona_vermelha_y_max: float = 340 # O resto da barra (ou o total)

func _ready():
	indicador_martelo.position.y = barra_alvo.size.y / 2
	visible = false

func iniciar(laminas_escolhidas: String):
	visible = true
	pontuacao_total_minigame = 0.0
	marteladas_restantes = 5 # Será definido pelo material e lâmina no futuro
	direcao_indicador = 1
	indicador_martelo.position.y = 0 

func _process(delta):
	if marteladas_restantes > 0 and visible:
		indicador_martelo.position.y += velocidade_indicador * direcao_indicador * delta
		var topo_barra = 0
		var base_barra = barra_alvo.size.y - indicador_martelo.size.y

		if indicador_martelo.position.y <= topo_barra:
			indicador_martelo.position.y = topo_barra
			direcao_indicador = 1
		elif indicador_martelo.position.y >= base_barra:
			indicador_martelo.position.y = base_barra
			direcao_indicador = -1


		if Input.is_action_just_pressed("interagir"): 
			marteladas_restantes -= 1
			calcular_pontuacao_martelada()

	elif marteladas_restantes <= 0 and visible:
		finalizar_minigame()


func calcular_pontuacao_martelada():
	var pos_y_indicador = indicador_martelo.position.y + (indicador_martelo.size.y / 2)

	var pontuacao_dessa_martelada: float = 0.0
	if pos_y_indicador >= zona_verde_y_min and pos_y_indicador <= zona_verde_y_max:
		pontuacao_dessa_martelada = 100.0 # Perfeito!
	elif pos_y_indicador >= zona_amarela_y_min and pos_y_indicador <= zona_amarela_y_max:
		pontuacao_dessa_martelada = 75.0 # Muito bom
	elif pos_y_indicador >= zona_laranja_y_min and pos_y_indicador <= zona_laranja_y_max:
		pontuacao_dessa_martelada = 50.0 # Bom
	else:
		pontuacao_dessa_martelada = 25.0 # OK
	pontuacao_total_minigame += pontuacao_dessa_martelada


func finalizar_minigame():
	var resultado_medio = pontuacao_total_minigame / 5.0 # Divida pelo número total de marteladas
	emit_signal("minigame_finalizado", resultado_medio)
	
	visible = false
	# Se quiser, pode liberar a cena aqui: queue_free()
	# Mas talvez seja melhor mantê-la e reusar para performance, apenas escondendo.
