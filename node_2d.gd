extends Node2D

# Variáveis
var speed = 200  # Velocidade de movimento da barra
var is_interaction_active = false  # Para verificar se a interação está ativa

# Referência ao botão de interação
@onready var interact_button = $CanvasLayer/Button  # Referência ao botão no CanvasLayer

# Referência ao alvo de interação (área onde a barra deve passar)
@onready var target_area = $CanvasLayer2/TargetArea  

# Função _ready é chamada quando a cena é carregada
func _ready():
	pass

# Função _process é chamada a cada frame
func _process(delta):
	# Move a barra de cima para baixo
	position.y += speed * delta
	
	# Verifica se a barra está dentro da área do alvo
	if position.y >= target_area.position.y and position.y <= target_area.position.y + target_area.get_child(0).shape.extents.y and not is_interaction_active:
		is_interaction_active = true  # Ativa a interação quando a barra está dentro da área do alvo
	
	# Verifica se o jogador pressionou o botão de interação no momento certo
	if is_interaction_active and interact_button.is_pressed():
		print("Você acertou!")
		reset_bar()  # Reseta a barra para o topo
	elif position.y > target_area.position.y + 100 + target_area.get_child(0).shape.extents.y:
		reset_bar()  # Se a barra ultrapassar o alvo, reinicia
		is_interaction_active = false

# Reseta a posição da barra para o topo
func reset_bar():
	position.y = -50  # Reseta para um valor acima da tela
	is_interaction_active = false
