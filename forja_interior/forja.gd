extends Node2D
# variaveis dos minigames
var corte_de_couro:bool = false
var bigorna:bool = false
var montagem:bool = false
@onready var espada: Espada = $Montagem/Espada
@onready var inventario: CanvasLayer = $Inventario

@export var minigame_snake:PackedScene
@export var minigame_bigorna:PackedScene
@onready var window: Window = $Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	corte_de_couro = false
	GameManager.exit_minigame.connect(close_minigame)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interagir"):
		if corte_de_couro:
			inicia_minigame(minigame_snake)
		if bigorna:
			inicia_minigame(minigame_bigorna)
			
func checa_itens(item_necessario,mao_necessaria,minigame):
	if GerenciadorItens.inventario[0] != null and GerenciadorItens.inventario[2] != null and window.visible == false:
		if GerenciadorItens.inventario[0].item_name  == item_necessario and GerenciadorItens.inventario[2].item_name == mao_necessaria:
			GameManager.multiplicador_de_qualidade = GerenciadorItens.inventario[0].qualidade
			GerenciadorItens.inventario[0] = null
			inicia_minigame(minigame)

func close_minigame():
	window.visible = false
	if window.get_child(0):
		window.get_child(0).queue_free()

#region corte de couro
func _on_snake_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		corte_de_couro = true
		print_debug(body)

func _on_snake_body_exited(body: Node2D) -> void:
	corte_de_couro = false

func _on_snake_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and corte_de_couro:
		checa_itens("couro","mao tesoura", minigame_snake)

#endregion

#region minigame bigorna

func _on_bigorna_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		bigorna = true
		#print_debug(body)

func _on_bigorna_body_exited(body: Node2D) -> void:
	bigorna = false

func _on_bigorna_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and bigorna:
		checa_itens("minerio","mao martelo", minigame_bigorna)

#endregion

func inicia_minigame(minigame):
	print_debug("jogando")
	GameManager.mini_game_start.emit()
	var minigame_scene = minigame.instantiate()
	window.add_child(minigame_scene)
	window.visible = true


func _on_montagem_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		montagem = true
		#print_debug(body)


func _on_montagem_body_exited(body: Node2D) -> void:
	montagem = false


func _on_montagem_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and montagem:
		if GerenciadorItens.inventario[0] != null or GerenciadorItens.inventario[1] != null:
			if GerenciadorItens.inventario[0] != null:
				checa_material(GerenciadorItens.inventario[0],0)
			else:
				checa_material(GerenciadorItens.inventario[1],1)
				espada._collect()
		else:
			espada._collect()

func checa_material(item_tentando:Item,slot:int):
	if item_tentando.item_name == "cabo" and espada.tamanho_cabo == "vazio":
		espada.tamanho_cabo = item_tentando.tamanho
		espada.cabo.texture = item_tentando.sprites_tamanhos_moldes[item_tentando.dicionario[item_tentando.tamanho]]
	elif item_tentando.item_name == "lamina" and espada.tamanho_lamina == "vazio":
		espada.tamanho_lamina = item_tentando.tamanho
		espada.lamina.texture = item_tentando.sprites_tamanhos_moldes[item_tentando.dicionario[item_tentando.tamanho]]
	else:
		print_debug("Esse item não pode ser adicionado a espada")
		return
	espada.qualidade += item_tentando.qualidade
	GerenciadorItens.inventario[slot] = null
	inventario.RemoveItem(slot)
