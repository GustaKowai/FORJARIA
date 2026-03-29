extends Node2D
var soprador:bool
var carvao:bool
var minerio:bool
@onready var combustivel: ProgressBar = $Combustivel
@onready var temperatura: ProgressBar = $Temperatura
@onready var minerio_processado: ProgressBar = $Area_minerio2/Minerio

@onready var forja_sprite: AnimatedSprite2D = $forja
@export var variacao_temperatura:float
@export var velocidade_queima:float
@export var velocidade_minerio:float
@export var minerioQuente:PackedScene
@onready var seta_soprador: Node2D = $SetaSoprador
@onready var seta_minerio: Node2D = $SetaMinerio
@onready var seta_carvao: Node2D = $SetaCarvao
@onready var alerta: Label = $alerta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	temperatura.value -= variacao_temperatura*delta
	combustivel.value -= temperatura.value*velocidade_queima*delta
	forja_sprite.speed_scale = combustivel.value/500.0
	var intensidade_fogo = temperatura.value/50
	forja_sprite.modulate = Color(intensidade_fogo,intensidade_fogo,intensidade_fogo)
	if combustivel.value == 0:
		forja_sprite.modulate = Color(0,0,0)
		alerta.visible = true
	if minerio_processado.value > 0 and minerio_processado.value <= 100:
		minerio_processado.value += temperatura.value*velocidade_minerio*delta

#region soprador da forja
func _on_area_soprador_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_soprador.visible = true
		soprador = true
		print_debug(body)


func _on_area_soprador_body_exited(body: Node2D) -> void:
	seta_soprador.visible = false
	soprador = false


func _on_area_soprador_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and soprador and combustivel.value!=0:
		if temperatura.value < 100:
			temperatura.value += 20

#endregion

#region colocar carvao
func _on_area_carvao_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_carvao.visible = true
		carvao = true
		print_debug(body)


func _on_area_carvao_body_exited(body: Node2D) -> void:
	seta_carvao.visible = false
	carvao = false


func _on_area_carvao_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and carvao and GerenciadorItens.inventario[0] != null:
		if GerenciadorItens.inventario[0].item_name == "carvão":
			if combustivel.value < 1000:
				combustivel.value += 200
				alerta.visible = false
				GerenciadorItens.inventario[0] = null
				GerenciadorItens.item_dropado.emit(0)
#endregion

#region colocar minerio
func _on_area_minerio_body_entered(body: Node2D) -> void:
	if body.is_in_group("jogador"):
		seta_minerio.visible = true
		minerio = true
		print_debug(body)


func _on_area_minerio_body_exited(body: Node2D) -> void:
	seta_minerio.visible = false
	minerio = false


func _on_area_minerio_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and minerio and GerenciadorItens.inventario[0] != null and minerio_processado.value == 0:
		if GerenciadorItens.inventario[0].item_name == "minerio":
			minerio_processado.value += 1
			GerenciadorItens.inventario[0] = null
			GerenciadorItens.item_dropado.emit(0)
			
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and minerio_processado.value >= 100  and GerenciadorItens.inventario[0] == null:
		minerio_processado.value = 0
		var minerio_quente:Item = minerioQuente.instantiate()
		minerio_quente._collect()
#endregion
