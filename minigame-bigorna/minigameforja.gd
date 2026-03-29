extends Control

signal minigame_finalizado(qualidade_minigame_bonus: float)

@onready var barra_alvo: TextureRect = %barraalvo
@onready var indicador_martelo: TextureRect = %indicadormartelo
@onready var item_list: ItemList = $"../ItemList"
@onready var restantes: Label = $"../restantes"
@onready var feedback: Label = $Feedback

@export var lamina:PackedScene
# Configurações do minigame
var velocidade_indicador: float = 200.0
var direcao_indicador: int = 1
var marteladas_restantes: int = 5
var tamanho_lamina:String
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
	indicador_martelo.position.y = barra_alvo.size.y
	visible = false
	var meio_barra = (barra_alvo.size.y)/2
	feedback.position.y = meio_barra
	feedback.visible = false
	zona_verde_y_min = meio_barra-meio_barra/10
	zona_verde_y_max = meio_barra+meio_barra/10
	zona_amarela_y_min = meio_barra-3*meio_barra/10
	zona_amarela_y_max = meio_barra+3*meio_barra/10
	zona_laranja_y_min = meio_barra-6*meio_barra/10
	zona_laranja_y_max = meio_barra+6*meio_barra/10
	zona_vermelha_y_min = 0
	zona_vermelha_y_max = meio_barra+meio_barra
	#iniciar("seila")
func iniciar():
	visible = true
	pontuacao_total_minigame = 0.0
	marteladas_restantes = 5 # Será definido pelo material e lâmina no futuro
	restantes.text = "5"
	direcao_indicador = 1
	indicador_martelo.position.y = 0 

func _process(delta):
	if marteladas_restantes > 0 and visible:
		indicador_martelo.position.y += velocidade_indicador * direcao_indicador * delta
		var topo_barra = 0-indicador_martelo.size.y/2
		var base_barra = barra_alvo.size.y - indicador_martelo.size.y/2

		if indicador_martelo.position.y <= topo_barra:
			#print_debug("topo = ",indicador_martelo.position.y)
			indicador_martelo.position.y = topo_barra
			direcao_indicador = 1
		elif indicador_martelo.position.y >= base_barra:
			#print_debug("base = ",indicador_martelo.position.y)
			indicador_martelo.position.y = base_barra
			direcao_indicador = -1
			
		var pos_y_indicador = indicador_martelo.position.y + (indicador_martelo.size.y / 2)
		if pos_y_indicador >= zona_verde_y_min and pos_y_indicador <= zona_verde_y_max:
			indicador_martelo.modulate = Color.GREEN
		elif pos_y_indicador >= zona_amarela_y_min and pos_y_indicador <= zona_amarela_y_max:
			indicador_martelo.modulate = Color.YELLOW
		elif pos_y_indicador >= zona_laranja_y_min and pos_y_indicador <= zona_laranja_y_max:
			indicador_martelo.modulate = Color.ORANGE
		else:
			indicador_martelo.modulate = Color.RED


		if Input.is_action_just_pressed("interagir"): 
			marteladas_restantes -= 1
			feedback.visible = true
			restantes.text = str(marteladas_restantes)
			#print_debug("martelado",marteladas_restantes)
			calcular_pontuacao_martelada()

	elif marteladas_restantes <= 0 and visible:
		finalizar_minigame()


func calcular_pontuacao_martelada():
	var pos_y_indicador = indicador_martelo.position.y + (indicador_martelo.size.y / 2)

	var pontuacao_dessa_martelada: float = 0.0
	if pos_y_indicador >= zona_verde_y_min and pos_y_indicador <= zona_verde_y_max:
		pontuacao_dessa_martelada = 100.0 # Perfeito!
		feedback.text = "PERFEITO"
		feedback.global_position.y = indicador_martelo.global_position.y
	elif pos_y_indicador >= zona_amarela_y_min and pos_y_indicador <= zona_amarela_y_max:
		pontuacao_dessa_martelada = 75.0 # Muito bom
		feedback.text = "Muito bom."
		feedback.global_position.y = indicador_martelo.global_position.y
		
	elif pos_y_indicador >= zona_laranja_y_min and pos_y_indicador <= zona_laranja_y_max:
		pontuacao_dessa_martelada = 50.0 # Bom
		feedback.text = "Bom"
		feedback.global_position.y = indicador_martelo.global_position.y
	else:
		pontuacao_dessa_martelada = 25.0 # OK
		feedback.text = "Ok..."
		feedback.global_position.y = indicador_martelo.global_position.y
	pontuacao_total_minigame += pontuacao_dessa_martelada
	print_debug(pontuacao_dessa_martelada)
	print_debug(pontuacao_total_minigame)

func finalizar_minigame():
	var resultado_medio = pontuacao_total_minigame / 5.0 # Divida pelo número total de marteladas
	emit_signal("minigame_finalizado", resultado_medio)
	gerar_item()
	GameManager.exit_minigame.emit()
	visible = false
	# Se quiser, pode liberar a cena aqui: queue_free()
	# Mas talvez seja melhor mantê-la e reusar para performance, apenas escondendo.


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	match index:
		0:
			tamanho_lamina = "pequeno"
		1:
			tamanho_lamina = "médio"
		2:
			tamanho_lamina = "grande"
	iniciar()
	item_list.hide()


func gerar_item():
	var item_gerado:Item = lamina.instantiate()
	item_gerado.qualidade = pontuacao_total_minigame / 5.0
	item_gerado.name = "lamina"
	item_gerado.tamanho = tamanho_lamina
	item_gerado.pontuacao = item_gerado.qualidade*GameManager.multiplicador_de_qualidade
	item_gerado._ready()
	GerenciadorItens.Item_coletado.emit(0,item_gerado)




func _on_button_button_down() -> void:
	Input.action_press("interagir")


func _on_button_button_up() -> void:
	Input.action_release("interagir")
